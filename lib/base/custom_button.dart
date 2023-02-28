import 'package:delivery/utils/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key,this.onPressed,required this.buttonText,
  this.transparent=false,this.margin,this.width,this.fontSize,this.radius=5,
  this.height,this.iconData});
 final VoidCallback? onPressed;
 final bool transparent;
 final EdgeInsets? margin;
 final double? height;
 final double? width;
 final double? fontSize;
 final double? radius;
 final IconData? iconData;
 final String buttonText;

  @override
  Widget build(BuildContext context) {
   final ButtonStyle _flatButton= TextButton.styleFrom(
      backgroundColor: onPressed==null?Theme.of(context).disabledColor:
      transparent?Colors.transparent:Theme.of(context).primaryColor,
      minimumSize: Size(width!=null?width!:Dimensions.screenWidth,
      height!=null?height!:50),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius!)
      )
    );
    return Center(
      child: SizedBox(
        width: width??Dimensions.screenWidth,
        height: height ??50,
        
        child: TextButton(onPressed: onPressed, 
        style: _flatButton,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
         iconData!=null?Padding(
          padding: EdgeInsets.only(right: Dimensions.width10/2),
          child: Icon(iconData,color: transparent? Theme.of(context).primaryColor:
          Theme.of(context).cardColor
          ,),):SizedBox(),
          Text(buttonText,style: TextStyle(
            fontSize: fontSize?? Dimensions.font16,
            color: transparent? Theme.of(context).primaryColor:
          Theme.of(context).cardColor
          ),)
        ],))),
    );
  }
}