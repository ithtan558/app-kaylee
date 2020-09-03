import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/screens.dart';
import 'package:kaylee/screens/src/product/categories/list/bloc/bloc.dart';
import 'package:kaylee/screens/src/product/categories/list/widgets/prod_cate_item.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class ProdCateListScreen extends StatefulWidget {
  static Widget newInstance() => BlocProvider(
      create: (context) => ProCateListScreenBloc(
            productService: context.network.provideProductService(),
          ),
      child: ProdCateListScreen._());

  ProdCateListScreen._();

  @override
  _ProdCateListScreenState createState() => _ProdCateListScreenState();
}

class _ProdCateListScreenState extends KayleeState<ProdCateListScreen> {
  ProCateListScreenBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.bloc<ProCateListScreenBloc>();
    _bloc.loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KayleeAppBar(
        title: Strings.quanLyDanhMuc,
      ),
      body: KayleeLoadMoreHandler(
        controller: context.bloc<ProCateListScreenBloc>(),
        child: BlocConsumer<ProCateListScreenBloc, LoadMoreModel<ProdCate>>(
          listener: (context, state) {
            if (!state.loading) {
              if (state.code.isNotNull &&
                  state.code != ErrorType.UNAUTHORIZED) {
                showKayleeAlertErrorYesDialog(
                  context: context,
                  error: state.error,
                  onPressed: () {
                    popScreen();
                  },
                );
              }
            }
          },
          builder: (context, state) {
            return KayleeListView(
              padding: EdgeInsets.all(Dimens.px16),
              itemBuilder: (c, index) {
                final item = state.items.elementAt(index);
                return ProdCateItem(
                  category: item,
                  onTap: () {
                    pushScreen(PageIntent(
                        screen: ProdCateDetailScreen, bundle: Bundle(item)));
                  },
                );
              },
              itemCount: state.items?.length,
              separatorBuilder: (context, index) =>
                  SizedBox(height: Dimens.px16),
              loadingBuilder: (context) {
                if (state.ended) return Container();
                return Align(
                  alignment: Alignment.topCenter,
                  child: KayleeLoadingIndicator(),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
