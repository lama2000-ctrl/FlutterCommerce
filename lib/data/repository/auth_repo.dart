
import 'package:delivery/data/api/api_client.dart';
import 'package:delivery/models/sign_up_model.dart';
import 'package:delivery/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({required this.apiClient,required this.sharedPreferences});
 Future<Response> registration(SignUpBody signUpBody) async {
    return await apiClient.postData(AppConstants.REGISTRATION_URI,signUpBody.toJson());
  }

  Future<bool>saveUserToken(String token) async {
apiClient.token=token;
apiClient.updateHeader(token);
return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }
Future<Response> login(String phone,String password) async {
    return await apiClient.postData(AppConstants.LOGIN_URI,{"phone":phone,"password":password});
  }
String getUserToken() {
  return  sharedPreferences.getString(AppConstants.TOKEN)?? "None";
}
bool UserLoggedIn() {
  return  sharedPreferences.containsKey(AppConstants.TOKEN);
}

  Future<void>saveUserNumberAndPassword(String phone,String password) async{
    try{
await sharedPreferences.setString(AppConstants.PHONE, phone);
await sharedPreferences.setString(AppConstants.PASSWORD, password);
    }catch(e){
      throw e;
    }
  }
  bool clearSharedData(){
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.remove(AppConstants.PASSWORD);
    sharedPreferences.remove(AppConstants.PHONE);
    apiClient.token='';
    apiClient.updateHeader('');
return true;
  }
}