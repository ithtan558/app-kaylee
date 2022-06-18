import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/screens/src/supplier/product_list/list/bloc/supplier_prod_cate_list_bloc.dart';
import 'package:kaylee/screens/src/supplier/product_list/list/bloc/supplier_prod_list_bloc.dart';
import 'package:kaylee/screens/src/supplier/product_list/list/widgets/supplier_product_card.dart';

class SupplierProductListTab extends StatefulWidget {
  const SupplierProductListTab({Key? key}) : super(key: key);

  @override
  _SupplierProductListTabState createState() => _SupplierProductListTabState();
}

class _SupplierProductListTabState extends State<SupplierProductListTab>
    with AutomaticKeepAliveClientMixin<SupplierProductListTab> {
  SupplierProdListBloc get _bloc => context.bloc<SupplierProdListBloc>()!;

  Supplier get supplier => context.getArguments<Supplier>()!;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        SizedBox(
          height: Dimens.px40,
          child: BlocBuilder<SupplierProdCateListBloc, LoadMoreModel<ProdCate>>(
            buildWhen: (previous, current) {
              return !current.loading;
            },
            builder: (context, state) {
              final categories = state.items;
              return BlocBuilder<SupplierProdListBloc, LoadMoreModel<Product>>(
                  builder: (context, state) {
                return KayleeTabBar(
                  itemCount: categories?.length ?? 0,
                  mapTitle: (index) => categories!.elementAt(index).name,
                  onSelected: (value) {
                    // context.read<SearchInputFieldController>().clear();
                    _bloc.changeTab(category: categories!.elementAt(value));
                  },
                  initialIndex: _bloc.category == null
                      ? 0
                      : categories!.indexOf(_bloc.category!),
                );
              });
            },
          ),
        ),
        Expanded(
            child: BlocConsumer<SupplierProdListBloc, LoadMoreModel<Product>>(
          listener: (context, state) {
            if (!state.loading && state.error != null) {
              showKayleeAlertErrorYesDialog(
                  context: context, error: state.error, onPressed: context.pop);
            }
          },
          builder: (context, state) {
            return PaginationRefreshListView<Product>(
              controller: _bloc,
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              padding: const EdgeInsets.all(Dimens.px16),
              itemBuilder: (c, index, item) {
                return SupplierProductCard(
                    product: item.copyWith(supplier: supplier));
              },
              separatorBuilder: (context, index) =>
                  const SizedBox(height: Dimens.px16),
              loadingIndicatorBuilder: (context) => const Align(
                alignment: Alignment.topCenter,
                child: KayleeLoadingIndicator(),
              ),
            );
          },
        ))
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
