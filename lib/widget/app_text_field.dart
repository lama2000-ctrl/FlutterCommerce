import 'package:flutter/material.dart';
import 'package:delivery/utils/colors.dart';
import 'package:delivery/utils/dimensions.dart';

class AppTextField extends StatelessWidget {
 AppTextField({super.key,required this.iconData,
  required this.text,
  required this.textEditingController,this.isObscure=false});
final TextEditingController textEditingController;
final String text;
final IconData iconData;
 bool isObscure;
  @override
  Widget build(BuildContext context) {
    return Container(
            margin: EdgeInsets.only(left: Dimensions.height20,right: Dimensions.height20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Dimensions.radius30/2),
              boxShadow: [
                BoxShadow(
                  blurRadius: 3,
                  spreadRadius: 1,
                  offset: Offset(1,1),
                  color: Colors.grey.withOpacity(0.2)
                )
              ]
            ),
            child: TextField(
             obscureText: isObscure?true:false,
controller: textEditingController,
decoration: InputDecoration(hintText: text,prefixIcon: Icon(iconData,color: AppColors.yellowColor,),
focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(Dimensions.radius30/2),
borderSide: BorderSide(width: 1.0,color: Colors.white))
,enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(Dimensions.radius30/2),
borderSide: BorderSide(width: 1.0,color: Colors.white)),
border:  OutlineInputBorder(borderRadius: BorderRadius.circular(Dimensions.radius30/2),),),
            ),
          );
  }
}

