import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';

part 'user_service.g.dart';

@RestApi()
abstract class UserService {
  factory UserService(Dio dio) = _UserService;

  @POST('register')
  Future<ResponseModel> register(@Body() RegisterBody body);

  @POST('login')
  Future<ResponseModel<LoginResult>> login(@Body() LoginBody body);

  @POST('forgot/verify-phone-and-send-otp')
  Future<ResponseModel<VerifyPhoneResult>> verifyPhone(
      @Body() VerifyPhoneBody body);

  @POST('forgot/verify-otp')
  Future<ResponseModel<VerifyOtpResult>> verifyOtp(@Body() VerifyOtpBody body);
}
