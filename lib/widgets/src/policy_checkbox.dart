import 'package:anth_package/anth_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:kaylee/base/networks/network_module.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/res/src/dimens.dart';
import 'package:kaylee/res/src/images.dart';
import 'package:kaylee/services/services.dart';
import 'package:kaylee/widgets/kaylee_widgets.dart';

class PolicyCheckBox extends StatefulWidget {
  final ValueSetter<bool> onChecked;

  PolicyCheckBox({this.onChecked});

  @override
  _PolicyCheckBoxState createState() => _PolicyCheckBoxState();
}

class _PolicyCheckBoxState extends BaseState<PolicyCheckBox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isChecked = !isChecked;
            });
            if (widget.onChecked.isNotNull) widget.onChecked(isChecked);
          },
          child: Image.asset(
            isChecked ? Images.ic_checked : Images.ic_notcheck,
            width: Dimens.px24,
            height: Dimens.px24,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: Dimens.px10),
            child: Text.rich(TextSpan(text: 'Tôi đồng ý mọi', children: [
              TextSpan(
                  text: ' điều khoản và quy định ',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      showKayleeBottomSheet(context,
                          maxChildSize: 635 / 667, initialChildSize: 635 / 667,
                          builder: (context, scrollController) {
                        return _PolicyView.newInstance(
                          scrollController: scrollController,
                        );
                      });
                    },
                  style: TextStyles.hyper16W400),
              TextSpan(text: 'khi sử dụng ứng dụng Kaylee')
            ])),
          ),
        )
      ],
    );
  }
}

class _PolicyView extends StatefulWidget {
  static Widget newInstance({ScrollController scrollController}) =>
      BlocProvider(
        create: (context) => _PolicyViewBloc(
            context.repository<NetworkModule>().provideCommonService()),
        child: _PolicyView._(
          scrollController: scrollController,
        ),
      );

  final ScrollController scrollController;

  _PolicyView._({this.scrollController});

  @override
  _PolicyViewState createState() => _PolicyViewState();
}

class _PolicyViewState extends BaseState<_PolicyView> {
  _PolicyViewBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.bloc<_PolicyViewBloc>();
    bloc.loadPolicy();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<_PolicyViewBloc, dynamic>(
      builder: (context, state) {
        if (state is LoadingState) {
          return CupertinoActivityIndicator();
        } else if (state is ErrorState) {
          return Container();
        } else if (state is _SuccessPolicyViewState) {
          return Column(
            children: [
              KayleeText.normal16W500(
                state.content?.name,
                overflow: TextOverflow.visible,
                maxLines: 1,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: Dimens.px16),
                  child: SingleChildScrollView(
                    controller: widget.scrollController,
                    padding: const EdgeInsets.only(
                        left: Dimens.px16,
                        right: Dimens.px16,
                        bottom: Dimens.px16),
                    child: HtmlWidget(
                      state.content.content,
                      textStyle: TextStyles.normal16W400,
                    ),
                  ),
                ),
              )
            ],
          );
        } else
          return Container();
      },
      listener: (context, state) {
        if (state is ErrorState) {
          showKayleeAlertDialog(
            context: context,
            view: KayleeAlertDialogView.error(
              error: state.error,
              actions: [
                KayleeAlertDialogAction.huy(
                  onPressed: () {
                    popScreen();
                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class _PolicyViewBloc extends BaseBloc {
  CommonService commonService;

  _PolicyViewBloc(this.commonService);

  @override
  Stream mapEventToState(e) async* {
    if (e is ErrorEvent) {
      yield* errorState(e);
    } else if (e is _SuccessPolicyViewEvent) {
      yield _SuccessPolicyViewState(e.content);
    } else if (e is _LoadPolicyViewEvent) {
      yield LoadingState();
      RequestHandler(
        request: commonService.getContent(Content.POLICY_HASHTAG),
        onSuccess: ({message, result}) {
          add(_SuccessPolicyViewEvent(result));
        },
        onFailed: (code, {error}) {
          errorEvent(code, error: error);
        },
      );
    }
  }

  void loadPolicy() {
    add(_LoadPolicyViewEvent());
  }
}

class _SuccessPolicyViewEvent {
  Content content;

  _SuccessPolicyViewEvent(this.content);
}

class _SuccessPolicyViewState {
  Content content;

  _SuccessPolicyViewState(this.content);
}

class _LoadPolicyViewEvent {}
