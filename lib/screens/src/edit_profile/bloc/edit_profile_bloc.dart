import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class EditProfileBloc extends Cubit<SingleModel<UserInfo>> {
  final UserService userService;
  UserInfo userInfo;

  EditProfileBloc({required this.userService, required this.userInfo})
      : super(SingleModel(item: userInfo));

  void loadProfile() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: userService.getProfile(),
      onSuccess: ({message, result}) {
        emit(ProfileModel.copy(state
          ..loading = false
          ..item = userInfo = result));
      },
      onFailed: (code, {error}) {
        emit(SingleModel.copy(state
          ..loading = false
          ..error = error
          ..code = code));
      },
    );
  }

  void updateProfile() {
    emit(SingleModel.copy(state..loading = true));
    RequestHandler(
      request: userService.update(
        name: userInfo.name,
        birthday: userInfo.birthday,
        address: userInfo.address,
        cityId: userInfo.city?.id,
        districtId: userInfo.district?.id,
        wardsId: userInfo.wards?.id,
        image: userInfo.imageFile,
      ),
      onSuccess: ({message, result}) {
        emit(UpdateProfileModel.copy(state
          ..loading = false
          ..message = message));
      },
      onFailed: (code, {error}) {
        emit(SingleModel.copy(state
          ..loading = false
          ..error = error
          ..code = code));
      },
    );
  }
}

class ProfileModel extends SingleModel<UserInfo> {
  ProfileModel.copy(SingleModel old) {
    this
      ..loading = old.loading
      ..item = old.item;
  }
}

class UpdateProfileModel extends SingleModel<UserInfo> {
  UpdateProfileModel.copy(SingleModel old) {
    this
      ..loading = old.loading
      ..message = old.message;
  }
}
