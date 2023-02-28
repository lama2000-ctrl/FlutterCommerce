
import 'dart:developer';

import 'package:delivery/base/show_custom_snackbar.dart';
import 'package:delivery/data/repository/auth_repo.dart';
import 'package:delivery/models/response_model.dart';
import 'package:delivery/models/sign_up_model.dart';
import 'package:get/get.dart';

import '../utils/app_constants.dart';

class AuthController extends GetxController implements GetxService{
final AuthRepo authRepo;
AuthController({required this.authRepo});
bool _isLoading=false;
bool get isLoading => _isLoading;
Future<ResponseModel> registration(SignUpBody signUpBody) async{
_isLoading=true;
update();
Response response=await authRepo.registration(signUpBody);
late ResponseModel responseModel;
if(response.statusCode==200){
authRepo.saveUserToken(response.body["token"]);
print("Token ..........");
print('the token is'+response.body["token"]);
responseModel=ResponseModel(true, response.body["token"]);
}
else{
responseModel=ResponseModel(false, response.statusText!);
}
_isLoading=false;
update();
return responseModel;
}

Future<ResponseModel> login(String phone,String password) async{
  print("Get User Token ......");
print('user token is'+authRepo.getUserToken());
_isLoading=true;
update();
Response response=await authRepo.login(phone, password);
late ResponseModel responseModel;
if(response.statusCode==200){
authRepo.saveUserToken(response.body["token"]);
print(response.body["token"]);
responseModel=ResponseModel(true, response.body["token"]);
}
else{
responseModel=ResponseModel(false, response.statusText!);
}
_isLoading=false;
update();
return responseModel;
}
bool UserLoggedIn() {
  return  authRepo.UserLoggedIn();
}

void saveUserNumberAndPassword(String phone,String password) {
 authRepo.saveUserNumberAndPassword(phone, password);
  }

  bool clearSharedData(){
    return authRepo.clearSharedData();
  }
}