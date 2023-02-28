import 'package:delivery/base/custom_loader.dart';
import 'package:delivery/controllers/auth_controller.dart';
import 'package:delivery/controllers/cart_controller.dart';
import 'package:delivery/controllers/location_controller.dart';
import 'package:delivery/controllers/user_controller.dart';
import 'package:delivery/routes/route_helper.dart';
import 'package:delivery/utils/colors.dart';
import 'package:delivery/utils/dimensions.dart';
import 'package:delivery/widget/account_widget.dart';
import 'package:delivery/widget/app_icon.dart';
import 'package:delivery/widget/big_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn=Get.find<AuthController>().UserLoggedIn();
    if(_userLoggedIn){
      Get.find<UserController>().getUserInfo();
    }
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
      title: BigText(text: "Profile",size: Dimensions.height20,),
      ),
      body: GetBuilder<UserController>(
        builder: (userController) {
          return _userLoggedIn?
          (userController.isLoading?
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.only(top: Dimensions.height20),
            child: Column(
              
              children: [
                AppIcon(icon: Icons.person,backgroundColor: AppColors.mainColor,
                iconSize:  Dimensions.height15*5,
                iconColor: Colors.white,size: Dimensions.height15*10,),
                SizedBox(height: Dimensions.height30,),
                //
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        AccountWidget(appIcon:AppIcon(icon: Icons.person,
                        backgroundColor: AppColors.mainColor,
                        iconSize:  Dimensions.height10*3,
                        iconColor: Colors.white,size: Dimensions.height15*3),
                        bigText: BigText(text: userController.userModel.name,)),
                        SizedBox(height: Dimensions.height20,),
                        //
                         AccountWidget(appIcon:AppIcon(icon: Icons.phone,
                         backgroundColor: AppColors.yellowColor,
                        iconSize:  Dimensions.height10*3,
                        iconColor: Colors.white,size: Dimensions.height15*3),
                        bigText: BigText(text: userController.userModel.phone,)),
                        SizedBox(height: Dimensions.height20,),
                        //
                         AccountWidget(appIcon:AppIcon(icon: Icons.email,
                         backgroundColor: AppColors.yellowColor,
                        iconSize:  Dimensions.height10*3,
                        iconColor: Colors.white,size: Dimensions.height15*3),
                        bigText: BigText(text: userController.userModel.email,)),
                        SizedBox(height: Dimensions.height20,),
                        //
                         GetBuilder<LocationController>(
                           builder: (locationController) {
                            if(_userLoggedIn && locationController.addressList.isEmpty){
                             return GestureDetector(
                              onTap: (){
                               Get.offNamed(RouteHelper.getAddressPage());
                              },
                               child: AccountWidget(appIcon:AppIcon(icon: Icons.location_on,
                               backgroundColor: AppColors.yellowColor,
                                                     iconSize:  Dimensions.height10*3,
                                                     iconColor: Colors.white,
                                                     size: Dimensions.height15*3),
                                                     bigText: 
                                                     BigText(text: "Fill in your address",)),
                             );
                            }
                            else{
                               return GestureDetector(
                              onTap: (){
                               Get.offNamed(RouteHelper.getAddressPage());
                              },
                               child: AccountWidget(appIcon:AppIcon(icon: Icons.location_on,
                               backgroundColor: AppColors.yellowColor,
                                                     iconSize:  Dimensions.height10*3,
                                                     iconColor: Colors.white,
                                                     size: Dimensions.height15*3),
                                                     bigText: 
                                                     BigText(text: "your address",)),
                             );
                            }
                           }
                          
                         ),
                        SizedBox(height: Dimensions.height20,),
                        //
                         AccountWidget(appIcon:AppIcon(icon: Icons.message_outlined,backgroundColor: Colors.redAccent,
                        iconSize:  Dimensions.height10*3,
                        iconColor: Colors.white,size: Dimensions.height15*3),
                        bigText: BigText(text: "Messages",)),
                        SizedBox(height: Dimensions.height20,),
                          GestureDetector(
                            onTap: (){
                              if(Get.find<AuthController>().UserLoggedIn()){
                              Get.find<AuthController>().clearSharedData();
                               Get.find<CartController>().clear();
                              Get.find<CartController>().clearCartHistory();
                              Get.find<LocationController>().clearAddressList();
                              Get.offNamed(RouteHelper.getSignInPage());
                              }
                            },
                            child: AccountWidget(appIcon:AppIcon(icon: Icons.logout_outlined,backgroundColor: Colors.redAccent,
                                              iconSize:  Dimensions.height10*3,
                                              iconColor: Colors.white,size: Dimensions.height15*3),
                                              bigText: BigText(text: "Logout",)),
                          ),
                        SizedBox(height: Dimensions.height20,),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ):CustomLoader()):
          Container(child: Center(child: 
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.maxFinite,
                height: Dimensions.height20*7,
                margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(""))
                ),
              ),

              GestureDetector(
                onTap: (){
                  Get.toNamed(RouteHelper.getSignInPage());
                },
                child: Container(
                  width: double.maxFinite,
                  height: Dimensions.height20*5,
                  margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
                  decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                  
                  ),
                  child: Center(child: BigText(text: "Sign In",color: Colors.white,
                  size: Dimensions.font20,)),
                ),
              ),
            ],
          )),
          
          );
        }
      ),
    );
  }
}