import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/locator/locator.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/knowledge/list/bloc/knowledge_screen_bloc.dart';
import 'package:kaylee/screens/src/knowledge/list/knowledge_item.dart';

class KnowledgeScreen extends StatefulWidget {
  static Widget newInstance() => BlocProvider<KnowledgeListBloc>(
      create: (context) => KnowledgeListBloc(
            knowledgeRepository: context.repositories.knowledge,
          ),
      child: const KnowledgeScreen());

  @visibleForTesting
  const KnowledgeScreen({Key? key}) : super(key: key);

  @override
  _KnowledgeScreenState createState() => _KnowledgeScreenState();
}

class _KnowledgeScreenState extends KayleeState<KnowledgeScreen> {
  KnowledgeListBloc get _bloc => context.read<KnowledgeListBloc>();

  @override
  void initState() {
    super.initState();
    _bloc.loadInitData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<KnowledgeListBloc, LoadMoreModel<Content>>(
      listener: (context, state) {
        if (!state.loading) {
          if (state.error != null) {
            showKayleeAlertErrorYesDialog(
              context: context,
              error: state.error,
              onPressed: popScreen,
            );
          }
        }
      },
      child: Scaffold(
        appBar: const KayleeAppBar(
          title: Strings.kienThuc,
        ),
        body: BlocBuilder<KnowledgeListBloc, LoadMoreModel<Content>>(
          builder: (context, state) {
            return PaginationRefreshListView<Content>(
              controller: _bloc,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index, item) {
                return KnowledgeItem(knowledge: item);
              },
              physics: const BouncingScrollPhysics(),
              loadingIndicatorBuilder: (context) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: Dimens.px16),
                  child: KayleeLoadingIndicator(),
                );
              },
              separatorBuilder: (c, index) {
                return Container(
                  height: Dimens.px1,
                  color: ColorsRes.textFieldBorder,
                  margin: const EdgeInsets.symmetric(horizontal: Dimens.px16),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
