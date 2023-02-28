import 'dart:convert';

import 'package:delivery/controllers/cart_controller.dart';
import 'package:delivery/data/repository/popular_product_repo.dart';
import 'package:delivery/models/product_models.dart';
import 'package:delivery/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/cart_model.dart';

class PopularProductController extends GetxController{
final PopularProductRepo popularProductRepo;
PopularProductController({required this.popularProductRepo});
List<dynamic> _popularProductList=[];
List<dynamic> get PopularProductList => _popularProductList;
int get quantity => _quantity;
bool _isLoaded=false;
bool get isLoaded=> _isLoaded;
int _quantity=0;
int _inCartItems=0;
late CartController _cart;
int get inCartItems=> _inCartItems+_quantity;

Future<void> getPopularProductList() async{
  print("startring.......");
Response response= await popularProductRepo.getPopularProductList();

 if(response.statusCode==200){
   print("good");
_popularProductList=[];
_popularProductList.addAll(Product.fromJson(response.body).products);
_isLoaded=true;
update();
 }
 else{
  print("nooooooooooooooooooooooo");
print(response.bodyString);
 }
}
void setQuantity(bool isIncrement){
if(isIncrement){
_quantity=checkQuantity(_quantity+1);
}
else{
  _quantity=checkQuantity(_quantity-1);
}
update();
}
int checkQuantity(int q){
if(_inCartItems +q<0){
  Get.snackbar("Item Count", "You can't reduce further",backgroundColor: AppColors.mainColor,
  colorText: Colors.white);
  if(_inCartItems>0){
    _quantity=-_inCartItems;
    return _quantity;
  }
  return 0;
}
else if(_inCartItems +q>20){
  Get.snackbar("Item Count", "You can't add more",backgroundColor: AppColors.mainColor,
  colorText: Colors.white);
  return 20;
}
else{
  return q;
}
}
void initProduct(ProductModel product,CartController cart){
  _quantity=0;
  _inCartItems=0;
  //get from storage
_cart=cart;
var _exist=false;
_exist=_cart.existInCart(product);
if(_exist){
  _inCartItems=_cart.getQuantity(product);
}
}
void addItem(ProductModel product){
  //if(_quantity>0){
_cart.addItem(product, _quantity);
_quantity=0;
_inCartItems=_cart.getQuantity(product);
_cart.getItems().forEach((key, value) { 

});
update();
  }
  /*else{
    Get.snackbar("Item count", "You should add at least one item",backgroundColor: AppColors.mainColor,
  colorText: Colors.white);
  }*/
  int get totalItems{
    return _cart.totalItems;
}

List<CartModel> get_Items(){
return _cart.get_Items();
}
}
