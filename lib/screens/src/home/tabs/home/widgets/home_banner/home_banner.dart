import 'package:anth_package/anth_package.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide Banner;
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/home/tabs/home/widgets/home_banner/bloc/home_banner_bloc.dart';
import 'package:kaylee/utils/utils.dart';
import 'package:kaylee/widgets/widgets.dart';

class HomeBanner extends StatefulWidget {
  static Widget newInstance() => BlocProvider(
        create: (context) =>
            HomeBannerBloc(service: context.network.provideAdvertiseService()),
        child: HomeBanner._(),
      );

  HomeBanner._();

  @override
  _HomeBannerState createState() => _HomeBannerState();
}

class _HomeBannerState extends KayleeState<HomeBanner> {
  final _indicatorController = IndicatorController();

  double get width => context.screenSize.width;

  double get height => (context.screenSize.width - Dimens.px8 * 2) / ratio;

  final ratio = 359 / 128;
  final _pageController = PageController();

  HomeBannerBloc get _bloc => context.bloc<HomeBannerBloc>();

  @override
  void initState() {
    super.initState();
    _bloc.loadBanners();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void onReloadWidget(Type widget, Bundle bundle) {
    if (widget == HomeBanner) {
      _bloc.loadBanners();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<HomeBannerBloc, SingleModel<List<Banner>>>(
          builder: (context, state) {
            if (state.item.isNullOrEmpty) return Container();
            return Container(
              height: height,
              padding:
                  const EdgeInsets.only(top: Dimens.px16, bottom: Dimens.px8),
              child: PageView(
                controller: _pageController,
                children: state.item
                    .map((e) => _buildBanner(
                          image: e.image,
                          onTap: () {},
                        ))
                    .toList(),
                onPageChanged: (value) {
                  _indicatorController.jumpTo(index: value);
                },
              ),
            );
          },
        ),
        BlocBuilder<HomeBannerBloc, SingleModel<List<Banner>>>(
          builder: (context, state) {
            _indicatorController.length = state.item?.length ?? 0;
            return Indicator(
              controller: _indicatorController,
              onSelect: (index) {},
            );
          },
        )
      ],
    );
  }

  Widget _buildBanner({
    String image,
    VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Dimens.px8),
      child: Material(
        color: ColorsRes.filterButton,
        borderRadius: BorderRadius.circular(Dimens.px5),
        clipBehavior: Clip.antiAlias,
        child: Container(
          width: width,
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: image,
                errorWidget: (context, url, error) => SizedBox(),
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onTap,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
