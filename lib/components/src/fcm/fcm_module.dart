import 'dart:convert';

import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';

const _SHARE_REF_CAMPAIGN = 'SHARE_REF_CAMPAIGN';

abstract class FcmModule {
  factory FcmModule.init() = _FcmModuleImpl._;

  FcmModule._();

  List<Campaign> getTopics();

  void overrideTopics({List<Campaign> campaigns});
}

class _FcmModuleImpl extends FcmModule {
  _FcmModuleImpl._() : super._();

  @override
  List<Campaign> getTopics() {
    final json = SharedRef.getString(_SHARE_REF_CAMPAIGN);
    if (json.isNullOrEmpty) return [];
    return (jsonDecode(json) as List)
        .map((json) => Campaign.fromJson(json))
        .toList();
  }

  @override
  void overrideTopics({List<Campaign> campaigns}) {
    final json = jsonEncode(campaigns ?? []);
    SharedRef.putString(_SHARE_REF_CAMPAIGN, json);
  }
}
