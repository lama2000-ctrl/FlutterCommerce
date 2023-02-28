import 'package:delivery/utils/dimensions.dart';
import 'package:delivery/widget/app_icon.dart';
import 'package:delivery/widget/big_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AccountWidget extends StatelessWidget {
   AccountWidget({super.key,required this.appIcon,required this.bigText});
AppIcon appIcon;
BigText bigText;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: Dimensions.width20,top: Dimensions.height10,
      bottom: Dimensions.height10),
      child: Row(
        children: [
          appIcon,
          SizedBox(width: Dimensions.width30,),
          bigText
        ],
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            offset: Offset(0,5),
            color: Colors.grey.withOpacity(0.3)
          )
        ]
      ),
    );
  }
}