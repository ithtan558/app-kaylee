import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart' hide Banner;
import 'package:kaylee/base/kaylee_state.dart';
import 'package:kaylee/locator/locator.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/screens/src/home/tabs/home/widgets/home_banner/bloc/home_banner_bloc.dart';
import 'package:kaylee/utils/deeplink_helper.dart';

class HomeBanner extends StatefulWidget {
  static Widget newInstance() => BlocProvider(
        create: (context) => HomeBannerBloc(service: context.api.advertise),
        child: const HomeBanner._(),
      );

  const HomeBanner._();

  @override
  _HomeBannerState createState() => _HomeBannerState();
}

class _HomeBannerState extends KayleeState<HomeBanner>
    with AutomaticKeepAliveClientMixin {
  final _indicatorController = IndicatorController();

  double get width => context.screenSize.width - Dimens.px8 * 2;

  double get height => width / ratio;

  final ratio = 359 / 128;
  final _pageController = PageController();

  HomeBannerBloc get _bloc => context.bloc<HomeBannerBloc>()!;

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
  void onReloadWidget(Type widget, Bundle? bundle) {
    if (widget == HomeBanner) {
      _bloc.loadBanners();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      margin: const EdgeInsets.only(top: Dimens.px16),
      height: height,
      child: BlocBuilder<HomeBannerBloc, SingleModel<List<Banner>>>(
        builder: (context, state) {
          if (state.item?.isEmpty ?? true) return Container();
          _indicatorController.length = state.item!.length;

          return Stack(
            children: [
              Positioned.fill(
                child: PageView(
                  controller: _pageController,
                  children: state.item!
                      .map((banner) => _buildBanner(
                            image: banner.image ?? '',
                            onTap: () {
                              final url = banner.url;
                              final pageIntent =
                                  DeepLinkHelper.handleLink(link: url);
                              if (pageIntent != null) pushScreen(pageIntent);
                            },
                          ))
                      .toList(),
                  onPageChanged: (value) {
                    _indicatorController.jumpTo(index: value);
                  },
                ),
              ),
              Positioned(
                  bottom: Dimens.px8,
                  left: Dimens.px0,
                  right: Dimens.px0,
                  child: Indicator(
                    controller: _indicatorController,
                    onSelect: (index) {},
                  ))
            ],
          );
        },
      ),
    );
  }

  Widget _buildBanner({
    required String image,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Dimens.px8),
      child: Material(
        color: ColorsRes.filterButton,
        borderRadius: BorderRadius.circular(Dimens.px5),
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          width: width,
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: image,
                errorWidget: (context, url, error) => const SizedBox.shrink(),
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

  @override
  void onForceReloadingWidget() {
    _bloc.loadBanners();
  }

  @override
  bool get wantKeepAlive => true;
}
