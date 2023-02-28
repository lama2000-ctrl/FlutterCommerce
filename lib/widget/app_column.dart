import 'package:delivery/widget/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'big_test.dart';
import 'icon_and_text_widget.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({Key? key,required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
  
              crossAxisAlignment: CrossAxisAlignment.start,
  
              children:[
  
  BigText(text: text,size: Dimensions.font26,),
  
  SizedBox(height: Dimensions.height15,),
  
  Row(children: [
  
  Wrap(
  
    children: 
  
      List.generate(5, (index) =>Icon(Icons.star,
  
      color: AppColors.mainColor,size: Dimensions.height15,)),
  
  ),
  
 SizedBox(width: Dimensions.width5,),
  SmallText(text: "4.5"),
  SizedBox(width: Dimensions.width5,),
  SmallText(text: "1287"),
   SizedBox(width: Dimensions.width5,),
  SmallText(text: "Comments")
  
  ],),
  
   SizedBox(height: Dimensions.height10,),
  
  Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
  
        IconAndTextWidget(icon: Icons.circle_sharp,
  
         iconColor: AppColors.iconColor1, 
  
         text: "Normal" ),
  
  
  
          IconAndTextWidget(icon: Icons.location_on,
  
         iconColor: AppColors.mainColor, 
  
         text: "1.7 Km" ),
  
  
  
         IconAndTextWidget(icon: Icons.access_time_rounded,
  
         iconColor: AppColors.iconColor2, 
  
         text: "32 min" ),
  
  
  
  ],)
  
  
  
            ]
  
            );
  }
}