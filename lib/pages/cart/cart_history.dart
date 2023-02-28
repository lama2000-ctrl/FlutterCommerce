import 'dart:convert';

import 'package:delivery/base/no_data_page.dart';
import 'package:delivery/controllers/cart_controller.dart';
import 'package:delivery/models/cart_model.dart';
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
import 'package:intl/intl.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList=Get.find<CartController>().
    getCartHistoryList().reversed.toList();
    Map<String,int> cartItemsPerOrder=Map();
    for(int i=0;i< getCartHistoryList.length;i++){
      if(cartItemsPerOrder.containsKey(getCartHistoryList[i].time)){
        cartItemsPerOrder.update(getCartHistoryList[i].time!, (value) => ++value);
      }
      else{
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }
    List<int> cartItemsPerOrderToList(){
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

     List<String> cartOrderTimeToList(){
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }
    List<int> itemsPerOrder=cartItemsPerOrderToList();
    var list_counter=0;
   Widget timeWidget(int index){
    var outputDate=DateTime.now().toString();
    if(index<getCartHistoryList.length){
       DateTime parseData=DateFormat("yyyy-MM-dd HH:mm:ss").parse(getCartHistoryList[list_counter].time!);
                            var inputDate=DateTime.parse(parseData.toString());
                           var outputFormat= DateFormat("MM/dd/yyyy hh:mm a");
                           var outputDate=outputFormat.format(inputDate);
                            return BigText(text: outputDate);
    }
    return BigText(text: outputDate);
   }
    return Scaffold(
      body: Column(
          children: [
           Container(
            height: Dimensions.height10*10,
            color: AppColors.mainColor,
            width: double.maxFinite,
            padding: EdgeInsets.only(top: Dimensions.height45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                     GestureDetector(
                      onTap: (){
                        Get.back();

                      },
                       child: AppIcon(icon: Icons.arrow_back,iconColor: AppColors.mainColor,
                                     backgroundColor: AppColors.yellowColor,),
                     ),
                BigText(text: "Cart History",color: Colors.white,),
                AppIcon(icon: Icons.shopping_cart_outlined,iconColor: AppColors.mainColor,
                backgroundColor: AppColors.yellowColor,),
      
              ],
            ),
           ),
           GetBuilder<CartController>(
             builder: (_cartController) {
               return (_cartController.getCartHistoryList().length>0)?Expanded(
                 child: Container(
                  margin: EdgeInsets.only(top: Dimensions.height20,
                  left: Dimensions.width20,
                  right: Dimensions.width20),
                  child: MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: ListView(
                      children: [
                        for(int i=0;i<itemsPerOrder.length;i++)
                           Container(
                          height: Dimensions.height120,
                          margin: EdgeInsets.only(bottom: Dimensions.height20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            timeWidget(list_counter),
                           // BigText(text: ""),
                            SizedBox(height: Dimensions.height10/2,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                               Wrap(
                                direction: Axis.horizontal,
                                children: List.generate(itemsPerOrder[i], (index){
                                  
                                  if(list_counter<getCartHistoryList.length){
                                    list_counter++;
                                   
                                  }
                                  return index<=2?Container(
                                    height: Dimensions.height20*4,
                                    width: Dimensions.width20*4,
                                    margin: EdgeInsets.only(right: Dimensions.width10),
                                    decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(Dimensions.radius20/2), 
                                     image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(AppConstants.BASE_URL+AppConstants.UPLOAD_URL+getCartHistoryList[list_counter-1].img!))),
                                  ):Container();
                                })
                               ),
                               Container(
                                height: Dimensions.height20*4,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                  SmallText(text: "Total",color: AppColors.textColor,),
                                  BigText(text: "${itemsPerOrder[i]} Items",
                                  color: AppColors.textColor,),
                                  GestureDetector(
                                    onTap: (){
                                        var orderTime=cartOrderTimeToList();
                                        Map<int,CartModel> moreOrder={};
                                        for(int j=0;j<getCartHistoryList.length;j++){
                                          if(getCartHistoryList[j].time==orderTime[i]){
                                            moreOrder.putIfAbsent(getCartHistoryList[j].id!, () => 
                                            CartModel.fromJson(jsonDecode(jsonEncode(getCartHistoryList[j]))));
                                          }
                                        }
                                        Get.find<CartController>().setItems=moreOrder;
                                        Get.find<CartController>().addToCartList();
                                        Get.toNamed(RouteHelper.getCartPage());
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: Dimensions.width10,vertical: Dimensions.height10/2),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(Dimensions.radius30/6),
                                        border: Border.all(width: 1,color: AppColors.mainColor)),
                                        child: SmallText(text: "One More",color: AppColors.mainColor,),
                                    ),
                                  )
                                ]),
                               )
                            ],)
                          ]),
                        )
                      ],
                    ),
                  ),
                  ),
               ):Container(
                height: MediaQuery.of(context).size.height/1.5,
                 child: const Center(
                   child: NoDataPage(text: "You didn't buy anything so far!!",
                   imgPath: "assets/images/FO3.jpg",),
                 ),
               );
             }
           )
          ],
        ),
    
    );
  }
}