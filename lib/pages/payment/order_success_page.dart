import 'package:delivery/base/custom_button.dart';
import 'package:delivery/routes/route_helper.dart';
import 'package:delivery/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class OrderSuccessPage extends StatelessWidget {
  final String orderId;
  final int status;
   OrderSuccessPage({super.key,required this.orderId,required this.status});
  @override
  Widget build(BuildContext context) {
   if(status==0){
    Future.delayed(
      Duration(seconds: 1),
      (){

      }
    );
   }
   return Scaffold(
    body: Center(child: SizedBox(width: Dimensions.screenWidth,
    child: Column(mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset("",width: 100,height: 100,),
      SizedBox(height: Dimensions.height45,),
      Text(
        status==1?'You placed the order successfully':'Your ORDER FAILED',
        style: TextStyle(
          fontSize: Dimensions.font16,
        ),
      ),
      SizedBox(height: Dimensions.height20,),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.height20,vertical: Dimensions.height20),
        child:  Text(
        status==1?'successful order':'FAILED order',
        style: TextStyle(
          fontSize: Dimensions.font20,
          color: Theme.of(context).disabledColor,
        ),
        textAlign: TextAlign.center,
      ),
        ),
        SizedBox(height: 30,),
        Padding(
          padding: EdgeInsets.all(Dimensions.height20),
          child: CustomButton(
            buttonText: "Back To Home",
            onPressed: ()=> Get.offAllNamed(RouteHelper.getInitial()), transparent: false,
          ),
          )
    ],),
    ),
  
    ),
   );
  }
}