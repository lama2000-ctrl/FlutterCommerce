import 'package:delivery/controllers/popular_product_controller.dart';
import 'package:delivery/controllers/recommended_product_controller.dart';
import 'package:delivery/routes/route_helper.dart';
import 'package:delivery/utils/app_constants.dart';
import 'package:delivery/utils/colors.dart';
import 'package:delivery/utils/dimensions.dart';
import 'package:delivery/widget/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../widget/big_test.dart';
import '../../widget/expandable_text.dart';
import '../cart/cart_page.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const RecommendedFoodDetail({Key? key,required this.pageId,required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product=Get.find<RecommendedProductController>().RecommendedProductList[pageId];
      Get.find<PopularProductController>().initProduct( product,Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
          automaticallyImplyLeading: false,
           expandedHeight: 300,
            title: Row(
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
                child: AppIcon(icon: Icons.clear)
                ),
              //AppIcon(icon: Icons.shopping_cart_outlined)
              GetBuilder<PopularProductController>(
                builder: (controller) {
                  return Stack(
                    children: [
                      AppIcon(icon: Icons.shopping_cart_outlined),
                      Get.find<PopularProductController>().totalItems>=1? 
                      Positioned(
                        right: 0,top: 0,
                        child: GestureDetector(
                          onTap: (){
                            Get.toNamed(RouteHelper.getCartPage());
                          },
                          child: AppIcon(icon: Icons.circle,size: 20,iconColor: Colors.transparent,
                          backgroundColor: AppColors.mainColor,),
                        ),
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
                  );
                }
              )
            ]),
            bottom: PreferredSize(preferredSize: const Size.fromHeight(20) ,
            child: Container(
             
              width: double.maxFinite,
              padding: const EdgeInsets.only(top: 5,bottom: 10),
             // margin: EdgeInsets.only(left: Dimensions.width10,right: Dimensions.width10),
              child: Center(child: BigText(text: product.name!,size: Dimensions.font26,)),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius20),
                topRight: Radius.circular(Dimensions.radius20)
              )),
              ),),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            flexibleSpace: FlexibleSpaceBar(
             // expandedTitleScale: 300,
              background: Image.network(AppConstants.BASE_URL+AppConstants.UPLOAD_URL+product.img!,width: double.maxFinite,
            fit: BoxFit.cover,),),
          ),
          SliverToBoxAdapter(
            child: Column(
        
              children: [
            Container(child: ExpandableText(text: product.description!)
            ,margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
            
            ),
             
              ]

            ),
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (controller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.only(
                  left: Dimensions.width20*2.5,
                  right: Dimensions.width20*2.5,
                  top: Dimensions.height10,
                  bottom: Dimensions.height10
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
GestureDetector(
  onTap: (){
    controller.setQuantity(false);
  },
  child:   AppIcon(iconColor: Colors.white,backgroundColor: AppColors.mainColor,
  
  icon: Icons.remove,
  
  iconSize: Dimensions.iconSize24 ,),
),

BigText(text: "\$ ${product.price!} X  ${controller.inCartItems} ",color: AppColors.mainBlackColor,size: Dimensions.font26,),
GestureDetector(
  onTap: (){
controller.setQuantity(true);
  },
  child:   AppIcon(iconColor: Colors.white,
  
  iconSize: Dimensions.iconSize24 ,
  
  backgroundColor: AppColors.mainColor,
  
  icon: Icons.add),
),
                  ],
                ),
              ),
              Container(
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
                child: Icon(
                  Icons.favorite,color: AppColors.mainColor,)
                ),
                GestureDetector(
                  onTap: (){
                    controller.addItem(product);
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,
                  left: Dimensions.width20,right: Dimensions.width20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.mainColor
                    ),
                    child: BigText(text: "\$ ${product.price} Add To Cart"),
                  ),
                )
              ],
            ),
          ),
            ],
          );
        }
      ),
    );
  }
}