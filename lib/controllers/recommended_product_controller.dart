import 'dart:convert';

import 'package:delivery/data/repository/recommended_product_repo.dart';
import 'package:delivery/models/product_models.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
class RecommendedProductController extends GetxController{
final RecommendedProductRepo recommendedProductRepo;
RecommendedProductController({required this.recommendedProductRepo});
List<dynamic> _recommendedProductList=[];
List<dynamic> get RecommendedProductList => _recommendedProductList;
bool _isLoaded=false;
bool get isLoaded=> _isLoaded;
Future<void> getRecommendedProductList() async{
 Response response= await recommendedProductRepo.getRecommendedProductList() ;
 if(response.statusCode==200){
_recommendedProductList=[];
_recommendedProductList.addAll(Product.fromJson(response.body).products);
_isLoaded=true;
update();
 }
 else{
print("Errorrrrrr");
 }
}


}