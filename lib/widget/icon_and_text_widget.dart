import 'package:delivery/utils/dimensions.dart';
import 'package:delivery/widget/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class IconAndTextWidget extends StatelessWidget {
  const IconAndTextWidget({Key? key, required this.icon,
  required this.iconColor,required this.text}) : super(key: key);
final IconData icon;
final String text;
final Color iconColor;
  @override
  Widget build(BuildContext context) {
    return Container(
child: Row(children: [
  Icon(icon,color: iconColor,size: Dimensions.iconSize24,),
  const SizedBox(width: 5.0,),
  SmallText(text: text),
],)
    );
  }
}