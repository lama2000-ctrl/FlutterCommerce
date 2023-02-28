import 'package:delivery/models/order_model.dart';
import 'package:delivery/pages/address/pick_address_map.dart';
import 'package:delivery/pages/auth/sign_in_page.dart';
import 'package:delivery/pages/cart/cart_history.dart';
import 'package:delivery/pages/cart/cart_page.dart';
import 'package:delivery/pages/items/recommended_food_detail.dart';
import 'package:delivery/pages/payment/payment_page.dart';
import 'package:delivery/pages/splash/splah_screen.dart';
import 'package:flutter/material.dart';

import 'package:delivery/helper/dependecies.dart';
import 'package:delivery/pages/home/main_food_page.dart';
import 'package:delivery/pages/items/popular_items_detail.dart';
import 'package:get/get.dart';

import '../pages/address/address_page.dart';
import '../pages/home/home_page.dart';
import '../pages/payment/order_success_page.dart';

class RouteHelper{

static const String initial="/";
static const String popularFood="/Popular-Food";
static const String recommendedFood="/Recommended-Food";
static const String cartPage="/Cart-Page";
static const String signIn="/sign-In";
static const String addAddress="/add-address";
static const String splahScreen='/splash-page';
static const String cartHistory="/cart-history";
static const String pickAddressMap="/pick-address";
static const String payment='/payment';
static const String orderSuccess='/order-successful';

static String getSplahPage()=>'/$splahScreen';
static String getPopularFood(int pageId,String page) => '$popularFood?pageId=$pageId&page=$page';
static String getRecommendedFood(int pageId,String page) => '$recommendedFood?pageId=$pageId&page=$page';
static String getInitial()=>'$initial';
static String getCartPage()=> '$cartPage';
static String getSignInPage()=>'$signIn';
static String getAddressPage()=>'$addAddress';
static String getCartHistory()=> '$cartHistory';
static String getPickAddressPage()=> '$pickAddressMap';
static String getPaymentPage(String id,int userId)=>'$payment?id=$id&userId=$userId';
static String getOrderSuccessPage(String OrderId,String status) =>'$orderSuccess?id=$OrderId&status=$status';
  static List<GetPage> routes=[
    GetPage(name: initial, page: ()=>HomePage(),transition: Transition.fade),
    GetPage(name: "/splash-page", page: (){
      return SplahScreen();
}),
    GetPage(name: "/cart-history", page: (){
      return CartHistory();
}),

  GetPage(name: payment, page: (){
      return PaymentPage(
        orderModel: OrderModel(id: int.parse(Get.parameters["id"]!),
        userId: int.parse(Get.parameters["userId"]!)),
      );
}),

  GetPage(name: orderSuccess, page: (){
      return OrderSuccessPage(
        orderId: Get.parameters['id']!,status: Get.parameters['status'].toString().
        contains("success")?1:0,
      );
}),

   GetPage(name: signIn, page: (){
      return SignInPage();
},transition: Transition.fade),
GetPage(name: pickAddressMap, page: (){
     PickAddressMap _pickAddress=Get.arguments;
     return _pickAddress;
},transition:Transition.fade),

    GetPage(name: popularFood, page: (){
      var pageId=Get.parameters["pageId"];
      var page=Get.parameters["page"];
     
   return PopularItemsDetail(pageId: int.parse(pageId!),page: page!);
},transition: Transition.fadeIn),
    GetPage(name: recommendedFood, page: (){
      var pageId=Get.parameters["pageId"];
      var page=Get.parameters["page"];
     return  RecommendedFoodDetail(pageId: int.parse(pageId!),page: page!);
},transition: Transition.fadeIn),
GetPage(name: cartPage, page: (){
   var pageId=Get.parameters["pageId"];
     return  CartPage();
},transition: Transition.fadeIn),
GetPage(name: addAddress, page: (){
   var pageId=Get.parameters["pageId"];
     return  AddressPage();
},transition: Transition.fadeIn)
  ];
}