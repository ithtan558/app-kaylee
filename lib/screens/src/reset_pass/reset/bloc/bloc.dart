import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

import 'event.dart';
import 'state.dart';

class ResetPassScreenBloc extends BaseBloc {
  UserService userService;
  CommonService commonService;

  ResetPassScreenBloc(this.userService, this.commonService);

  Content _content;

  @override
  Stream mapEventToState(e) async* {
    if (e is ErrorEvent) {
      yield* errorState(e);
    } else if (e is VerifyPhoneResetPassScrEvent) {
      yield LoadingState();
      RequestHandler(
        request: userService?.verifyPhone(VerifyPhoneBody(phone: e.phone)),
        onSuccess: ({message, result}) {
          add(SuccessResetPassScrEvent(result));
        },
        onFailed: (code, {error}) {
          if (error.code.isNotNull) {
            add(PhoneErrorResetPassScrEvent(error.message));
          } else {
            errorEvent(code, error: error);
          }
        },
      );
    } else if (e is SuccessResetPassScrEvent) {
      yield SuccessResetPassScrState(e.result);
    } else if (e is PhoneErrorResetPassScrEvent) {
      yield PhoneErrorResetPassScrState(e.message);
    } else if (e is LoadContactResetPassScrEvent) {
      yield LoadingState();
      RequestHandler(
        request: commonService?.getContent(Content.CONTACT_US_HASHTAG),
        onSuccess: ({message, result}) {
          _content = result;
          add(SuccessLoadContactResetPassScrEvent(_content));
        },
        onFailed: (code, {error}) {
          errorEvent(code, error: error);
        },
      );
    } else if (e is SuccessLoadContactResetPassScrEvent) {
      yield SuccessLoadContactResetPassScrState(e.content);
    }
  }

  void verifyPhone(String phone) {
    add(VerifyPhoneResetPassScrEvent(phone));
  }

  void getContact() {
    if (_content.isNotNull)
      add(SuccessLoadContactResetPassScrEvent(_content));
    else
      add(LoadContactResetPassScrEvent());
  }
}
