import 'package:delivery/controllers/recommended_product_controller.dart';
import 'package:delivery/pages/items/popular_items_detail.dart';
import 'package:delivery/routes/route_helper.dart';
import 'package:delivery/utils/app_constants.dart';
import 'package:delivery/utils/colors.dart';
import 'package:delivery/utils/dimensions.dart';
import 'package:delivery/widget/app_column.dart';
import 'package:delivery/widget/big_test.dart';
import 'package:delivery/widget/icon_and_text_widget.dart';
import 'package:delivery/widget/small_text.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../controllers/popular_product_controller.dart';
import '../../models/product_models.dart';
import '../../widget/expandable_text.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController=PageController(
    viewportFraction: 0.85
  );

  var _currPageValue=0.0;
  var _scaleFactor=0.8;
  double _height=Dimensions.pageViewContainer;
  @override
  void initState(){
    super.initState();
    pageController.addListener(() {
    setState(() {
        _currPageValue=pageController.page!;
    });
    });
  }
  @override
  Widget build(BuildContext context) {
  
    return Column(
      children: [
        GetBuilder<PopularProductController>(
          builder: (PopularProducts) {
            return (PopularProducts.isLoaded)?Container(

              height: Dimensions.ViewContainer,
              child: 
             PageView.builder(
                  controller: pageController,
                  itemCount: PopularProducts.PopularProductList.length,
                  itemBuilder:(context, index){
                  return _buildPageItem(index,PopularProducts.PopularProductList[index]);
                } ),
              ): CircularProgressIndicator(color: AppColors.mainColor,);
          }
        ),
          GetBuilder<PopularProductController>(
            builder: (PopularProducts) {
              return DotsIndicator(
  dotsCount: PopularProducts.PopularProductList.isEmpty?1:PopularProducts.PopularProductList.length,
  position: _currPageValue,
  decorator: DotsDecorator(
    activeColor: AppColors.mainColor,
    size: const Size.square(9.0),
    activeSize: const Size(18.0, 9.0),
    activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
  ),
);
            }
          ),
//Popular Text
  SizedBox(height: Dimensions.height30,),
  Container(
    margin: EdgeInsets.only(left: Dimensions.width30),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
      BigText(text: "Recommended"),
      SizedBox(width: Dimensions.width10,),
      Container(
        margin: const EdgeInsets.only(bottom: 3),
        child: BigText(text: ".",color: Colors.black26,),
      ),
      SizedBox(width: Dimensions.width10,),
      Container(
        margin: const EdgeInsets.only(bottom: 2),
        child: SmallText(text: "Food Pairing"),
      )
    ]),
  ),
 GetBuilder<RecommendedProductController>(
   builder: (RecommendedProducts) {
     return (RecommendedProducts.isLoaded)?ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: RecommendedProducts.RecommendedProductList.length,
          itemBuilder: ((context, index) {
          return GestureDetector(
            onTap: (){
              Get.toNamed(RouteHelper.getRecommendedFood(index,"home"));
            },
            child: Container(
              margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20,bottom: Dimensions.height10),
              child: Row(
                children: [
                  Container(
                   width: Dimensions.listViewImage,
                   height: Dimensions.listViewImage, 
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20,),
                  color: Colors.grey,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(AppConstants.BASE_URL+ AppConstants.UPLOAD_URL+ RecommendedProducts.RecommendedProductList[index].img!)
                  )),),
                  Expanded(
                    child: Container(
                     height: Dimensions.listViewContSize,
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(Dimensions.radius20),
                      bottomRight: Radius.circular(Dimensions.radius20)
                      ),
                      color: Colors.white),
                      child: Padding(padding: EdgeInsets.only(left: Dimensions.width10,right: Dimensions.width10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BigText(text: RecommendedProducts.RecommendedProductList[index].name!),
                          SizedBox(height: Dimensions.height10,),
                          Flexible(
                            child: SmallText(text:RecommendedProducts.
                            RecommendedProductList[index].description!)),
                          SizedBox(height: Dimensions.height10,),
                          Row(children: [
                
                Wrap(
                
                  children: 
                
            List.generate(5, (index) =>Icon(Icons.star,
                
            color: AppColors.mainColor,size: 15,)),
                
                ),
                
                 SizedBox(width: Dimensions.width5,),
                SmallText(text: "4.5"),
                 SizedBox(width: Dimensions.width5,),
                SmallText(text: "1287"),
                SizedBox(width: Dimensions.width5,),
                SmallText(text: "Comments")
                
                ],),
                        ],
                      ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        })):CircularProgressIndicator(color: AppColors.mainColor,);
   }
 ),
  
      ],
    );
    
    
  }

@override
  void dispose(){
    pageController.dispose();
    super.dispose();
    
  }
  Widget _buildPageItem(int index,ProductModel PopularProducts){
    Matrix4 matrix =new Matrix4.identity();
    if(index==_currPageValue.floor()){
    var currScale=1-(_currPageValue-index)*(1-_scaleFactor);
    var currTrans= _height*(1-currScale)/2;
     //matrix=Matrix4.diagonal3Values(1, currScale, 1);
      matrix=Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }
    else if(index==_currPageValue.floor()+1){
var currScale=_scaleFactor+(_currPageValue-index+1)*(1- _scaleFactor);
 var currTrans= _height*(1-currScale)/2;
 matrix=Matrix4.diagonal3Values(1, currScale, 1);
matrix=Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }
    else if(index==_currPageValue.floor()-1){
   
var currScale=1-(_currPageValue-index)*(1- _scaleFactor);
 var currTrans= _height*(1-currScale)/2;
 matrix=Matrix4.diagonal3Values(1, currScale, 1);
matrix=Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }
    else{
      var currScale=0.8;
      matrix=Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, _height*(1-_scaleFactor)/2, 1);
    }
return Transform(
  transform: matrix,
  child:   Stack(
  
    children: [
  
          GestureDetector(
               onTap: (){
                Get.toNamed(RouteHelper.getPopularFood(index,"home"));
              
                },
            child: Container(
                height: Dimensions.pageViewContainer,
                  margin:  EdgeInsets.only(left: Dimensions.width10,right: Dimensions.width10),
                  decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radius30),
            
                color: index.isEven? AppColors.paraColor:const Color(0xFF9294cc),
            
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(AppConstants.BASE_URL+ AppConstants.UPLOAD_URL+ PopularProducts.img!))
            
                  ),
            
                ),
          ),
  
       Align(
  
        alignment: Alignment.bottomCenter,
  
         child: Container(
  
          height: Dimensions.pageViewTextContaiber,
  
          margin:  EdgeInsets.only(left: Dimensions.width45,right: Dimensions.width45,
          bottom: Dimensions.height15),
  
          decoration: BoxDecoration(
  
            borderRadius: BorderRadius.circular(Dimensions.radius30),
  
      color: Colors.white,
  boxShadow: const [
    BoxShadow(color: Color(0xFFe8e8e8),blurRadius: 5.0,offset:Offset(0,5)),
    BoxShadow(color: Colors.white,offset: Offset(-5, 0)),
    BoxShadow(color: Colors.white,offset: Offset(5, 0))
  ],
     image: DecorationImage(image: AssetImage(""))
  
          ),
  
          child: Container(
  
            padding: EdgeInsets.only(top: Dimensions.height15,left: Dimensions.width15,right: Dimensions.width15),
  
            child: AppColumn(text:PopularProducts.name!,)
  
          ),
  
      ),
  
       ),
  
    ],
  
  ),
);
  }
}