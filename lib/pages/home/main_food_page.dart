import 'package:delivery/pages/home/food_page_body.dart';
import 'package:delivery/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:delivery/utils/colors.dart';
import 'package:get/get.dart';

import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../widget/big_test.dart';
import '../../widget/small_text.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
   Future<void>_loadRessources() async{
    print("It has veen initialized .............");
    await Get.find<PopularProductController>().getPopularProductList();
   await Get.find<RecommendedProductController>().getRecommendedProductList();
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _loadRessources ,
      child: Scaffold(
        body: Column(
          children: [
            Container(
              child: Container(
                margin:  EdgeInsets.only(top: Dimensions.height45,bottom: Dimensions.height45),
                padding:  EdgeInsets.only(right: Dimensions.width20,left: Dimensions.width20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Column(
                    children:  [
      BigText(text:"Cameroon",color: AppColors.mainColor,size: Dimensions.iconSize30,),
      Row(
        children: [
          SmallText(text: "Yaounde",color: Colors.black54,),
          const Icon( Icons.arrow_drop_down_rounded,)
        ],
      ),
                    ],
                  ),
                  Center(
                    child: Container(
                      width: Dimensions.height45,
                      height: Dimensions.height45 ,
                      child:  Icon(Icons.search,color: Colors.white,size: Dimensions.iconSize24,),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.height15),
                      color: AppColors.mainColor),
                    ),
                  )
                ]),
              ),
            ),
            Expanded(child: 
            SingleChildScrollView (
              child: FoodPageBody()
              )),
          ],
    
        ),
      ),
    );
  }
}