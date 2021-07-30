import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/services/services.dart';

class ContactUsBloc extends BaseBloc {
  Content? _content;
  CommonService commonService;

  ContactUsBloc(this.commonService);

  @override
  Stream mapEventToState(event) async* {
    if (event is LoadContactResetPassScrEvent) {
      yield LoadingState();
      RequestHandler(
        request: commonService.getContent(Content.contactUsHashtag),
        onSuccess: ({message, result}) {
          _content = result;
          add(SuccessLoadContactResetPassScrEvent(_content!));
        },
        onFailed: (code, {error}) {
          errorEvent(code, error: error);
        },
      );
    } else if (event is SuccessLoadContactResetPassScrEvent) {
      yield SuccessLoadContactUsState(event.content);
    } else if (event is ErrorEvent) {
      yield* errorState(event);
    }
  }

  void getContact() {
    if (_content != null) {
      add(SuccessLoadContactResetPassScrEvent(_content!));
    } else {
      add(LoadContactResetPassScrEvent());
    }
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
