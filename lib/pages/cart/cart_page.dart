import 'package:delivery/base/no_data_page.dart';
import 'package:delivery/base/show_custom_snackbar.dart';
import 'package:delivery/controllers/auth_controller.dart';
import 'package:delivery/controllers/cart_controller.dart';
import 'package:delivery/controllers/location_controller.dart';
import 'package:delivery/controllers/order_controller.dart';
import 'package:delivery/controllers/popular_product_controller.dart';
import 'package:delivery/controllers/user_controller.dart';
import 'package:delivery/models/place_order_model.dart';
import 'package:delivery/pages/home/main_food_page.dart';
import 'package:delivery/pages/items/popular_items_detail.dart';
import 'package:delivery/routes/route_helper.dart';
import 'package:delivery/utils/app_constants.dart';
import 'package:delivery/utils/colors.dart';
import 'package:delivery/utils/dimensions.dart';
import 'package:delivery/widget/app_icon.dart';
import 'package:delivery/widget/big_test.dart';
import 'package:delivery/widget/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../controllers/recommended_product_controller.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: Dimensions.height20*3,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              GestureDetector(
                onTap: (){
                  Get.back();
                },
                child: AppIcon(icon: Icons.arrow_back,iconColor: Colors.white,
                backgroundColor: AppColors.mainColor,
                iconSize: Dimensions.iconSize24,),
              ),
              SizedBox(width: Dimensions.width20*5),
               GestureDetector(
                onTap: (){
                  Get.toNamed(RouteHelper.getInitial());
                },
                 child: AppIcon(icon: Icons.home_outlined,iconColor: Colors.white,
                             backgroundColor: AppColors.mainColor,
                             iconSize: Dimensions.iconSize24,),
               ),
               GestureDetector(
                onTap: (){
                  Get.toNamed(RouteHelper.getCartHistory());
                },
                 child: AppIcon(icon: Icons.shopping_cart,iconColor: Colors.white,
                             backgroundColor: AppColors.mainColor,
                             iconSize: Dimensions.iconSize24,),
               ),
            ]),
          ),
          GetBuilder<CartController>(
            builder: (_cartController) {
              return _cartController.get_Items().length>0? Positioned(

                top: Dimensions.height20*5,
                left: Dimensions.width20,
                right: Dimensions.width20,
                bottom: 0,

                child: Container(
                  margin: EdgeInsets.only(top: Dimensions.height20),
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: GetBuilder<CartController>(
                      builder: (cartController) {
                        var _cartList=cartController.get_Items();
                        return ListView.builder(
                  
                          itemCount: _cartList.length,
                          itemBuilder: (_ ,index){
                  return Container(
                        height: 100,width: double.maxFinite,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: (){
                                var popularIndex=Get.find<PopularProductController>().
                                PopularProductList.indexOf(_cartList[index].product);
                                if(popularIndex>=0){
                                 Get.toNamed(RouteHelper.getPopularFood(popularIndex,"cartpage"));
                                }
                                else{
                                  var recommendedIndex=Get.find<RecommendedProductController>().
                                RecommendedProductList.indexOf(_cartList[index].product);
                                if(recommendedIndex<0){
                                   Get.snackbar("History Product", "Product review is not available for history products",backgroundColor: AppColors.mainColor,
  colorText: Colors.white);

                                }else{
                                  Get.toNamed(RouteHelper.getRecommendedFood(recommendedIndex,"cartpage"));
                                }
                                }

                              },
                              child: Container(width: Dimensions.height20*5,
                              height: Dimensions.height20*5,
                              margin: EdgeInsets.only(bottom: Dimensions.height20),
                              decoration: 
                              BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(AppConstants.BASE_URL+AppConstants.UPLOAD_URL+cartController.get_Items()[index].img!)),
                                borderRadius: BorderRadius.circular(Dimensions.radius20)),),
                            ),

                              Expanded(child: Container(
                                padding: EdgeInsets.only(left: Dimensions.width10),
                                height: Dimensions.height20*5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                BigText(text: cartController.get_Items()[index].name!,color: Colors.black54,),
                                SmallText(text: "",),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                   BigText(text: "\$ ${cartController.get_Items()[index].price!}",color: Colors.redAccent),
                                    Container(
                        padding: EdgeInsets.only(top: Dimensions.height10,bottom: Dimensions.height10,
                        left: Dimensions.width10,right: Dimensions.width10),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.radius20),
                        color: Colors.white),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: (){
                              cartController.addItem(_cartList[index].product!, -1);
                              },
                              child: Icon(Icons.remove,color: AppColors.signColor,)
                              ),
                            SizedBox(width: Dimensions.width10/2,),
                            BigText(text: _cartList[index].quantity.toString()),
                             SizedBox(width: Dimensions.width10/2,),
                            GestureDetector(
                              onTap: (){
                              cartController.addItem(_cartList[index].product!, 1);
                              },
                              child: Icon(Icons.add,color: AppColors.signColor,)
                            )
                          ],
                        ),
                        ),
                                ],)

                              ],),
                              ),)
                          ],
                        ),
                  );
                        } );
                      }
                    ),
                  )
                  )
                ):NoDataPage(text: "Your Cart is Empty");
            }
          )

        ]
      ),
      bottomNavigationBar: GetBuilder<CartController>(
        builder: (cartController) {
          return Container(
            height: Dimensions.height120,
            padding: EdgeInsets.only(top: Dimensions.height30,bottom: Dimensions.height30,
            left: Dimensions.width20,right: Dimensions.width20),
            decoration: BoxDecoration(borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.radius20*2),
              topRight: Radius.circular(Dimensions.radius20*2)
            ),
            color: AppColors.buttonBackgroundColor),
            child: cartController.get_Items().length>0? Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               Container(
                padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,
                left: Dimensions.width20,right: Dimensions.width20),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.white),
                child: Row(
                  children: [
                  
                    SizedBox(width: Dimensions.width10/2,),
                    BigText(text:"\$ ${cartController.totalAmount}"),
                     SizedBox(width: Dimensions.width10/2,),
                  
                  
                  ],
                ),
                ),
                GestureDetector(
                    onTap: (){
                      //popularProducts.addItem(product);
                     if(Get.find<AuthController>().UserLoggedIn()){
 //cartController.addToHistory();
 if(Get.find<LocationController>().addressList.isEmpty){
  Get.toNamed(RouteHelper.getAddressPage());
 } else{
  var location=Get.find<LocationController>().getUserAddress();
  var cart =Get.find<CartController>().get_Items();
  var user=Get.find<UserController>().userModel;
  PlaceOrderBody placeOrderBody=PlaceOrderBody(
    cart: cart,
    orderAmount: 200.0,
    orderNote: "Not About the food",
    address: location.address,
    latitude: location.latitude,
    longitude: location.longitude,
    contactPersonNumber: user.phone,
    contactPersonName: user.name,
    scheduleAt: '',
    distance: 12.0
  );
  //Get.offNamed(RouteHelper.getInitial());
  Get.find<OrderController>().placeOrder(placeOrderBody,_callback);
 }
                     }
                     else{
Get.toNamed(RouteHelper.getSignInPage());
                     }
                     
                    },
                  child: Container(
                    padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,
                  left: Dimensions.width20,right: Dimensions.width20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.mainColor
                    ),
                   
                      child: BigText(text: "Checkout")),
                ),
                
              ],
            ): Container(),
          );
        }
      ),
    );
  }
  void _callback(bool isSuccess,String message,String OrderId){
    if(isSuccess){
Get.offNamed(RouteHelper.getPaymentPage(OrderId, Get.find<UserController>().userModel.id));
    }
    else{
      showCustomSnackbar(message);
    }
  }
}