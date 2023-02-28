import 'package:delivery/base/custom_loader.dart';
import 'package:delivery/base/show_custom_snackbar.dart';
import 'package:delivery/controllers/auth_controller.dart';
import 'package:delivery/models/sign_up_model.dart';
import 'package:delivery/utils/colors.dart';
import 'package:delivery/utils/dimensions.dart';
import 'package:delivery/widget/app_text_field.dart';
import 'package:delivery/widget/big_test.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../routes/route_helper.dart';

class SignUpPage extends StatelessWidget {
 SignUpPage({super.key});
var emailController=TextEditingController();
var passwordController=TextEditingController();
var nameController=TextEditingController();
var phoneController=TextEditingController();
var signUpImages=[
  "",
  "",
  "",
  ""
];
  @override
  Widget build(BuildContext context) {
      void _registration( AuthController authController){

      String name=nameController.text.trim();
      String email=emailController.text.trim();
      String password=passwordController.text.trim();
      String phone=phoneController.text.trim();
      if(name.isEmpty){
showCustomSnackbar("Type In Your Name",title: "Name");
      }
      else if(phone.isEmpty){
showCustomSnackbar("Type In Your Phone Number",title: "Phone");
      }
      else if(email.isEmpty){
showCustomSnackbar("Type In Your Email Address",title: "Email");
      }
      else if(!GetUtils.isEmail(email)){
showCustomSnackbar("Enter A Valid Email address",title: "Invalid Email");
      }
      else if(password.isEmpty){
showCustomSnackbar("Type In Your Password",title: "Password");
      }
      else if(password.length<6){
showCustomSnackbar("Password can not be less thab six characters",title: "Short Password");
      }
      else{
//showCustomSnackbar("All went well",title: "Perfect");
    SignUpBody signUpBody= SignUpBody(email: email, name: name,
     password: password, phone: phone);
     authController.registration(signUpBody).then((status){
      if(status.isSuccess){
Get.offNamed(RouteHelper.getInitial());
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
        builder: (_authController) {
          return !_authController.isLoading? SingleChildScrollView(
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
                AppTextField(iconData: Icons.email, 
                text: "Email", 
                textEditingController: emailController),
                SizedBox(height: Dimensions.height20,),
                 AppTextField(iconData: Icons.password_sharp, 
                text: "Password", 
                textEditingController: passwordController,isObscure: true,),
                SizedBox(height: Dimensions.height20,),
                 AppTextField(iconData: Icons.person, 
                text: "Name", 
                textEditingController: nameController),
                SizedBox(height: Dimensions.height20,),
                 AppTextField(iconData: Icons.phone, 
                text: "Phone", 
                textEditingController: phoneController),
                SizedBox(height: Dimensions.height20,),
                GestureDetector(
                  onTap: (){
                   _registration(_authController);
                  },
                  child: Container(
                    width: Dimensions.screenWidth*0.5,
                    height: Dimensions.screenHeight/13,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius30),
                      color: AppColors.mainColor
                    ),
                    child: Center(child: BigText(text: "Sign Up",size: Dimensions.font20*1.5,color: Colors.white,)),
                  ),
                ),
                SizedBox(height: Dimensions.height10,),
                RichText(text: TextSpan(
                  recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                  text: "Have An Account Already?",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: Dimensions.font20,
                  )
                )),
                SizedBox(height: Dimensions.screenHeight*0.05,),
                RichText(text: TextSpan(
                  text: "Sign Up using One of the following methods",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: Dimensions.font16,
                  )
                )),
                Wrap(
                  children: List.generate(3, (index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: Dimensions.radius30,
                      backgroundImage: AssetImage("assets/images/${signUpImages[index]}"),
                    ),
                  )),
                )
              ],
            ),
          ):const CustomLoader();
        }
      ),
    );
    
  
  }
}