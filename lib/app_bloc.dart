import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class AppBloc extends Cubit {
  final UserService userService;
  final CampaignService campaignService;
  PackageInfo? _packageInfo;

  PackageInfo? get packageInfo => _packageInfo;

  set packageInfo(value) {
    _packageInfo = value;
  }

  AppBloc({
    required this.userService,
    required this.campaignService,
  }) : super(InitState());

  bool isShowingLoginDialog = false;
  final _unauthorizedController = PublishSubject<UnauthorizedState>();

  Stream get unauthorizedStream => _unauthorizedController.stream;

  ///handle warning expiration
  bool isShowingExpirationWarningDialog = false;

  final _expirationWarningController = PublishSubject<ExpirationWarningState>();

  Stream get expirationWarningStream => _expirationWarningController.stream;

  ///handle expiration
  bool isShowingExpirationScreen = false;

  final _expirationController = PublishSubject<ExpirationState>();

  Stream get expirationStream => _expirationController.stream;

  ///handle out of date
  bool isShowingOutOfDateDialog = false;

  final _outOfDateController = PublishSubject<OutOfDateState>();

  Stream get outOfDateStream => _outOfDateController.stream;

  void loggedIn(LoginResult result) {
    emit(LoggedInState(result: result));
  }

  void loggedOut() {
    _reset();
    emit(LoggedOutState());
  }

  void unauthorized({required Error error}) {
    _unauthorizedController.add(UnauthorizedState(error: error));
  }

  void expirationWarning({required Error error}) {
    _expirationWarningController.add(ExpirationWarningState(error: error));
  }

  void expired({required Error error}) {
    _expirationController.add(ExpirationState(error: error));
  }

  void outOfDate({required Error error}) {
    _outOfDateController.add(OutOfDateState(error: error));
  }

  void notifyUpdateProfile({required UserInfo userInfo}) {
    RequestHandler(
      request: userService.getProfile(),
      onSuccess: ({message, result}) {
        emit(UpdateProfileState(
          userInfo: result,
        ));
      },
      onFailed: (code, {error}) {
        emit(UpdateProfileState(
          userInfo: userInfo,
        ));
      },
    );
  }

  void doneLoggedInSetup() => emit(DoneSetupLoggedInState());

  void getFcmTopic() {
    RequestHandler(
      request: campaignService.getAllCampaign(),
      onSuccess: ({message, result}) {
        final campaigns = ((result as List<Campaign>?)
            ?.where((campaign) => campaign.isNotNull))?.toList();
        emit(LoadedTopicState(campaigns: campaigns));
      },
      onFailed: (code, {error}) {},
    );
  }

  @override
  Future<void> close() {
    _unauthorizedController.close();
    _expirationController.close();
    _expirationWarningController.close();
    _outOfDateController.close();
    return super.close();
  }

  void _reset() {
    isShowingLoginDialog = false;
    isShowingExpirationWarningDialog = false;
    isShowingExpirationScreen = false;
    isShowingOutOfDateDialog = false;
  }
}

class LoggedInState {
  LoginResult result;

  LoggedInState({required this.result});
}

class LoggedOutState {}

class DoneSetupLoggedInState {}

class UnauthorizedState {
  Error error;

  UnauthorizedState({required this.error});
}

class OutOfDateState {
  Error error;

  OutOfDateState({required this.error});
}

class ExpirationWarningState {
  Error error;

  ExpirationWarningState({required this.error});
}

class ExpirationState {
  Error error;

  ExpirationState({required this.error});
}

class CartBloc extends Cubit<CartState> {
  CartBloc() : super(CartState());

  void updateCart() => emit(CartState());
}

class CartState {}

class UpdateProfileState {
  final UserInfo userInfo;

  UpdateProfileState({required this.userInfo});
}

class LoadedTopicState {
  List<Campaign>? campaigns;

  LoadedTopicState({required this.campaigns});
}
