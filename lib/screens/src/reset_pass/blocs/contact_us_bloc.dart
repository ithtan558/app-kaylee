import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class ContactUsBloc extends BaseBloc {
  Content? _content;
  CommonService commonService;

  ContactUsBloc(this.commonService);

  @override
  Stream mapEventToState(e) async* {
    if (e is LoadContactResetPassScrEvent) {
      yield LoadingState();
      RequestHandler(
        request: commonService.getContent(Content.CONTACT_US_HASHTAG),
        onSuccess: ({message, result}) {
          _content = result;
          add(SuccessLoadContactResetPassScrEvent(_content!));
        },
        onFailed: (code, {error}) {
          errorEvent(code, error: error);
        },
      );
    } else if (e is SuccessLoadContactResetPassScrEvent) {
      yield SuccessLoadContactUsState(e.content);
    } else if (e is ErrorEvent) {
      yield* errorState(e);
    }
  }

  void getContact() {
    if (_content != null)
      add(SuccessLoadContactResetPassScrEvent(_content!));
    else
      add(LoadContactResetPassScrEvent());
  }
}

class LoadContactResetPassScrEvent {}

class SuccessLoadContactResetPassScrEvent {
  Content content;

  SuccessLoadContactResetPassScrEvent(this.content);
}

class SuccessLoadContactUsState {
  Content content;

  SuccessLoadContactUsState(this.content);
}
