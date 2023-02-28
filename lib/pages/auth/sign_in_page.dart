import 'package:delivery/base/custom_loader.dart';
import 'package:delivery/pages/auth/signup_page.dart';
import 'package:delivery/routes/route_helper.dart';
import 'package:delivery/utils/colors.dart';
import 'package:delivery/utils/dimensions.dart';
import 'package:delivery/widget/app_text_field.dart';
import 'package:delivery/widget/big_test.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../base/show_custom_snackbar.dart';
import '../../controllers/auth_controller.dart';
import '../../models/sign_up_model.dart';

class SignInPage extends StatelessWidget {
 SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
var passwordController=TextEditingController();
var phoneController=TextEditingController();
    void _login( AuthController authController){

      
      String phone=phoneController.text.trim();
      String password=passwordController.text.trim();
     

       if(phone.isEmpty){
showCustomSnackbar("Type In Your Phone number",title: "Phone Number");
      }
//       else if(!GetUtils.isEmail(phone)){
// showCustomSnackbar("Enter A Valid Email address",title: "Invalid Email");
//       }
      else if(password.isEmpty){
showCustomSnackbar("Type In Your Password",title: "Password");
      }
      else if(password.length<6){
showCustomSnackbar("Password can not be less than six characters",title: "Short Password");
      }
      else{
//showCustomSnackbar("All went well",title: "Perfect");
    
     authController.login(phone, password).then((status){
      if(status.isSuccess){
        //Get.toNamed(RouteHelper.getCartPage());
Get.toNamed(RouteHelper.getInitial());
      }
      else{
        showCustomSnackbar(status.message);
      }
     });
      }
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(
        builder: (authController) {
          return !authController.isLoading? SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: Dimensions.screenHeight*0.05,),
                Container(
                
                  height: Dimensions.screenHeight*0.25,
                  child: Center(
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage(""),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: Dimensions.width20),
                  width: double.maxFinite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    
                    children: [
                      Text("Hello",style: TextStyle(fontSize: Dimensions.font20*4,
                      fontWeight: FontWeight.bold),),
                       Text("Sign In to your account",style: TextStyle(fontSize: Dimensions.font20,
                       color: Colors.grey[400],
                      fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
                SizedBox(height: Dimensions.height20,),
                AppTextField(iconData: Icons.email, 
                text: "Phone", 
                textEditingController: phoneController),
                SizedBox(height: Dimensions.height20,),
                 AppTextField(iconData: Icons.password_sharp, 
                text: "Password", 
                textEditingController: passwordController,isObscure: true,),
                SizedBox(height: Dimensions.height20,),
           Row(
          //  mainAxisAlignment: MainAxisAlignment.end,
   children: [
    Expanded(child: Container()),
     RichText(text: TextSpan(
                      text: "Sign in to your Account?",
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimensions.font20,
                      )
                    )),
                    SizedBox(height: Dimensions.height20),
   ],
 ),
                GestureDetector(
                  onTap: (){
                    _login(authController);
                  },
                  child: Container(
                    width: Dimensions.screenWidth*0.5,
                    height: Dimensions.screenHeight/13,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius30),
                      color: AppColors.mainColor
                    ),
                    child: Center(child: BigText(text: "Sign In",size: Dimensions.font20*1.5,color: Colors.white,)),
                  ),
                ),
                SizedBox(height: Dimensions.height10,),


            
                SizedBox(height: Dimensions.screenHeight*0.05,),
                RichText(text: TextSpan(
                  text: "Don\'t have an Account?",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: Dimensions.font20,
                  ),
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()..onTap=() => Get.to(()=>SignUpPage(),
                      transition: Transition.fadeIn),
                  text: "Create",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.mainBlackColor,
                    fontSize: Dimensions.font20,
                  ))
                  ]
                )),
              
              ],
            ),
          ):const CustomLoader();
        }
      ),
    );
  }
}