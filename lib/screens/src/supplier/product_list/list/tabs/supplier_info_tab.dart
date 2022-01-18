import 'dart:io';

import 'package:anth_package/anth_package.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/res/res.dart';
import 'package:kaylee/screens/src/supplier/product_list/list/bloc/supplier_prod_list_screen_bloc.dart';

class SupplierInfoTab extends StatefulWidget {
  const SupplierInfoTab({Key? key}) : super(key: key);

  @override
  State<SupplierInfoTab> createState() => _SupplierInfoTabState();
}

class _SupplierInfoTabState extends State<SupplierInfoTab>
    with AutomaticKeepAliveClientMixin<SupplierInfoTab> {
  SupplierProdListScreenBloc get _bloc =>
      context.bloc<SupplierProdListScreenBloc>()!;

  Supplier? get _supplier => _bloc.state.item;

  LatLng get _latLng => LatLng(_supplier?.lat ?? 0, _supplier?.lng ?? 0);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.px16)
          .copyWith(top: Dimens.px8, bottom: Dimens.px16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: Dimens.px8),
                child: Image.asset(
                  Images.icLocationPin,
                  width: Dimens.px16,
                  height: Dimens.px16,
                ),
              ),
              Expanded(child: KayleeText.hint16W400(_supplier?.location ?? ''))
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: Dimens.px16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: Dimens.px8),
                  child: Material(
                    clipBehavior: Clip.antiAlias,
                    type: MaterialType.circle,
                    color: ColorsRes.hintText,
                    child: Image.asset(
                      Images.icOtherPhone,
                      width: Dimens.px16,
                      height: Dimens.px16,
                    ),
                  ),
                ),
                Expanded(
                    child: GestureDetector(
                        onTap: () {
                          makeCall(_supplier?.phone);
                        },
                        child: KayleeText.hint16W400('${_supplier?.phone}')))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: Dimens.px24),
            child: AspectRatio(
              aspectRatio: 343 / 293,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: _latLng,
                  zoom: 15,
                ),
                zoomControlsEnabled: false,
                scrollGesturesEnabled: false,
                zoomGesturesEnabled: false,
                tiltGesturesEnabled: false,
                rotateGesturesEnabled: false,
                liteModeEnabled: Platform.isAndroid,
                compassEnabled: false,
                myLocationButtonEnabled: false,
                myLocationEnabled: false,
                markers: {
                  Marker(
                    markerId: MarkerId(
                      '${_supplier?.id}',
                    ),
                    position: _latLng,
                  )
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
