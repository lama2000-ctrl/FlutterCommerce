import 'package:delivery/utils/colors.dart';
import 'package:delivery/widget/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../utils/dimensions.dart';

class ExpandableText extends StatefulWidget {
  const ExpandableText({Key? key,required this.text}) : super(key: key);
 final String text;
  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstHalf;
  late String secondHalf;
  bool hiddenText=true;
  double textHeight=Dimensions.screenHeight/5.8;
  @override
  void initState(){
  super.initState();
  if(widget.text.length > textHeight){
    firstHalf=widget.text.substring(0,textHeight.toInt());
    secondHalf=widget.text.substring(textHeight.toInt()+1,widget.text.length);

  }
  else{
    firstHalf=widget.text;
    secondHalf="";
  }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
child: secondHalf.isEmpty?SmallText(color: AppColors.paraColor,size: Dimensions.font16,text: firstHalf):Column(
  children: [
    SmallText(height: 1.8,color: AppColors.paraColor,size: Dimensions.font16,text: hiddenText?(firstHalf+" ......"):(firstHalf+secondHalf)),
    InkWell(
      onTap: (){
setState(() {
  hiddenText=!hiddenText;
});
      },
      child: Row(
        children: [
          SmallText( text:hiddenText? "Show More":"Show Less",color: AppColors.mainColor,),
          Icon(hiddenText?Icons.arrow_drop_down:Icons.arrow_drop_up,color: AppColors.mainColor,)
        ],
      ),
    )
  ],
),
    );
  }
}