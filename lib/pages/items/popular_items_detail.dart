

import 'package:delivery/controllers/cart_controller.dart';
import 'package:delivery/pages/cart/cart_page.dart';
import 'package:delivery/pages/home/main_food_page.dart';
import 'package:delivery/utils/app_constants.dart';
import 'package:delivery/utils/dimensions.dart';
import 'package:delivery/widget/app_column.dart';
import 'package:delivery/widget/app_icon.dart';
import 'package:delivery/widget/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/popular_product_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../widget/big_test.dart';


class PopularItemsDetail extends StatelessWidget {
 final int pageId;
 final String page;
const PopularItemsDetail({Key? key,required this.pageId,required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product=Get.find<PopularProductController>().PopularProductList[pageId];
    Get.find<PopularProductController>().initProduct(product,Get.find<CartController>());
    print("THE page id is "+pageId.toString());
    print(product.name.toString());
    return Scaffold(
      body: Stack(
      children: [
        Positioned(
          left: 0,
          right: 0,
          child:  Container(
            width: double.maxFinite,
            height: Dimensions.popularImgSize,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(AppConstants.BASE_URL+AppConstants.UPLOAD_URL+product.img),
                ),
                color: Colors.grey
            ),
          )
        ),
        Positioned(
          top: Dimensions.height30,
          left: Dimensions.width20,
          right: Dimensions.width20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: (){
                  if(page=="cartpage"){
                    Get.toNamed(RouteHelper.getCartPage());
                  }
                  else{
                 Get.toNamed(RouteHelper.getInitial());
                  }
                },
                child: AppIcon(icon: Icons.arrow_back)),
              GetBuilder<PopularProductController>(
                builder: (controller) {
                  return GestureDetector(
                          onTap: (){
                           Get.toNamed(RouteHelper.getCartPage());
                          },
                    child: Stack(
                      children: [
                        AppIcon(icon: Icons.shopping_cart_outlined),
                        Get.find<PopularProductController>().totalItems>=1? 
                        Positioned(
                          right: 0,top: 0,
                         
                            child: AppIcon(icon: Icons.circle,size: 20,iconColor: Colors.transparent,
                            backgroundColor: AppColors.mainColor,),
                          
                        ):
                        Container(),
                         Get.find<PopularProductController>().totalItems>=1? 
                        Positioned(
                          right: 4,top: 4,
                          child: BigText(text:Get.find<PopularProductController>().totalItems.toString(),
                          size: 12,color: Colors.white, ),
                        ):
                        Container()
                      ],
                    ),
                  );
                }
              )
            ],
          )),
          Positioned(
            left: 0,
            right: 0,
            top: Dimensions.popularImgSize-20,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20,
              top: Dimensions.width20),
              decoration: BoxDecoration(borderRadius: BorderRadius.only(
                topRight:Radius.circular(Dimensions.radius20) ,topLeft: Radius.circular(Dimensions.radius20),),
              color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppColumn(text: product.name,),
                  SizedBox(height: Dimensions.height20,),
                  BigText(text: "Introduce"),
                   SizedBox(height: Dimensions.height20,),
                  Expanded(child: SingleChildScrollView(child: ExpandableText(text: product.description)))
                ],
              )
            ),
            
          ),
      ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (popularProducts) {
          return Container(
            height: Dimensions.height120,
            padding: EdgeInsets.only(top: Dimensions.height30,bottom: Dimensions.height30,
            left: Dimensions.width20,right: Dimensions.width20),
            decoration: BoxDecoration(borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.radius20*2),
              topRight: Radius.circular(Dimensions.radius20*2)
            ),
            color: AppColors.buttonBackgroundColor),
            child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               Container(
                padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,
                left: Dimensions.width20,right: Dimensions.width20),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.white),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        popularProducts.setQuantity(false);
                      },
                      child: Icon(Icons.remove,color: AppColors.signColor,)
                      ),
                    SizedBox(width: Dimensions.width10/2,),
                    BigText(text: popularProducts.inCartItems.toString()),
                     SizedBox(width: Dimensions.width10/2,),
                    GestureDetector(
                      onTap: (){
                    popularProducts.setQuantity(true);
                      },
                      child: Icon(Icons.add,color: AppColors.signColor,)
                    )
                  ],
                ),
                ),
                GestureDetector(
                    onTap: (){
                      popularProducts.addItem(product);
                    },
                  child: Container(
                    padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,
                  left: Dimensions.width20,right: Dimensions.width20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.mainColor
                    ),
                   
                      child: BigText(text: "\$ ${product.price} Add To Cart")),
                ),
                
              ],
            ),
          );
        }
      ),
      backgroundColor: Colors.white,
    );
  }
}