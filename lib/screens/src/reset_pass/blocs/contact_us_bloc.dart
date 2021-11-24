import 'package:anth_package/anth_package.dart';
import 'package:kaylee/apis/apis.dart';
import 'package:kaylee/models/models.dart';

class ContactUsBloc extends BaseBloc {
  Content? _content;
  CommonApi commonService;

  ContactUsBloc(this.commonService) {
    on<LoadContactResetPassScrEvent>((event, emit) {
      emit(LoadingState());
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
    });
    on<SuccessLoadContactResetPassScrEvent>(
        (event, emit) => emit(SuccessLoadContactUsState(event.content)));
    on<ErrorEvent>((event, emit) => emit(errorState(event)));
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
