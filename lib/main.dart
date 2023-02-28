import 'package:delivery/controllers/cart_controller.dart';
import 'package:delivery/controllers/popular_product_controller.dart';
import 'package:delivery/controllers/recommended_product_controller.dart';
import 'package:delivery/pages/cart/cart_page.dart';
import 'package:delivery/pages/home/food_page_body.dart';
import 'package:delivery/pages/items/popular_items_detail.dart';
import 'package:delivery/pages/items/recommended_food_detail.dart';
import 'package:delivery/routes/route_helper.dart';
import 'package:delivery/tesst.dart';
import 'package:delivery/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:delivery/pages/home/main_food_page.dart';
import 'package:get/get.dart';
import 'package:delivery/helper/dependecies.dart' as dep;

/*void main() {
  w
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState(){
    super.initState();
   _configureAmplify();
  }
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(
      builder: (_) {
        return GetBuilder<RecommendedProductController>(
          builder: (_) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              
              home: MyWidget(),
              initialRoute: RouteHelper.getInitial(),
              getPages: RouteHelper.routes,
            );
          }
        );
      }
    );
  }
   Future<void> _configureAmplify() async{
   try{
    await dep.init();
   }
   catch(e){
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
   }
   }
}*/
Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
  Get.find<CartController>().getCartData();
  Get.find<PopularProductController>().getPopularProductList();
  Get.find<RecommendedProductController>().getRecommendedProductList();
    return GetBuilder<PopularProductController>(
      builder: (_) {
        return GetBuilder<RecommendedProductController>(
          builder: (_) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                primaryColor: AppColors.mainColor
              ),
              //home: MainFoodPage(),
              initialRoute: RouteHelper.getSplahPage(),
              getPages: RouteHelper.routes,
            );
          }
        );
      }
    );
  }
}

