import 'package:anth_package/anth_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/components/components.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/services/services.dart';
import 'package:kaylee/widgets/widgets.dart';

class PolicyCheckBox extends StatefulWidget {
  final ValueSetter<bool>? onChecked;

  const PolicyCheckBox({Key? key, this.onChecked}) : super(key: key);

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
            widget.onChecked?.call(isChecked);
          },
          child: Image.asset(
            isChecked ? Images.icChecked : Images.icNotCheck,
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
              const TextSpan(text: 'khi sử dụng ứng dụng Kaylee')
            ])),
          ),
        )
      ],
    );
  }
}

class _PolicyView extends StatefulWidget {
  static Widget newInstance({required ScrollController scrollController}) =>
      BlocProvider(
        create: (context) => _PolicyViewBloc(
            context.read<NetworkModule>().provideCommonService()),
        child: _PolicyView._(
          scrollController: scrollController,
        ),
      );

  final ScrollController scrollController;

  const _PolicyView._({required this.scrollController});

  @override
  _PolicyViewState createState() => _PolicyViewState();
}

class _PolicyViewState extends KayleeState<_PolicyView> {
  _PolicyViewBloc get bloc => context.read<_PolicyViewBloc>();

  @override
  void initState() {
    super.initState();
    bloc.loadPolicy();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<_PolicyViewBloc, dynamic>(
      builder: (context, state) {
        if (state is LoadingState) {
          return const KayleeLoadingIndicator();
        } else if (state is ErrorState) {
          return Container();
        } else if (state is _SuccessPolicyViewState) {
          return Column(
            children: [
              KayleeText.normal16W500(
                state.content?.name ?? '',
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
                      state.content?.content ?? '',
                      textStyle: TextStyles.normal16W400,
                    ),
                  ),
                ),
              )
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
      listener: (context, state) {
        if (state is ErrorState && state.error != null) {
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
        request: commonService.getContent(Content.policyHashtag),
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
  Content? content;

  _SuccessPolicyViewEvent(this.content);
}

class _SuccessPolicyViewState {
  Content? content;

  _SuccessPolicyViewState(this.content);
}

class _LoadPolicyViewEvent {}
