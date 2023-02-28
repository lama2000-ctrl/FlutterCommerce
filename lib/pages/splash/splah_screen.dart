import 'dart:async';

import 'package:delivery/routes/route_helper.dart';
import 'package:delivery/utils/dimensions.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';

class SplahScreen extends StatefulWidget {
  const SplahScreen({Key? key}) : super(key: key);

  @override
  State<SplahScreen> createState() => _SplahScreenState();
}

class _SplahScreenState extends State<SplahScreen> with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  @override
  void initState(){
    super.initState();
     _loadRessources();
     
    controller= AnimationController(vsync: this,duration: const Duration(seconds: 2))..forward();
    
    animation= CurvedAnimation(parent: controller, curve: Curves.easeIn);
    Timer(Duration(seconds: 3), ()=>Get.offNamed(RouteHelper.getInitial()));
  }
   Future<void> _loadRessources() async{
    print("It has been initialized .............");
   await Get.find<PopularProductController>().getPopularProductList();
   await Get.find<RecommendedProductController>().getRecommendedProductList();
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
    backgroundColor: Colors.red,
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ScaleTransition(
          scale: animation,
          child: Center(child: Image.asset("assets/images/FO3/jpg",width: Dimensions.splasScreenImg,))),
         Center(child: Image.asset("assets/images/FO3/jpg",width: Dimensions.splasScreenImg,))
      ],
    ),
   ); 
  }
}