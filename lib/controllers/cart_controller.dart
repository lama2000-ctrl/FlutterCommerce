
import 'package:delivery/data/repository/cart_repo.dart';
import 'package:delivery/models/product_models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../models/cart_model.dart';
import '../utils/colors.dart';

class CartController extends GetxController{
final CartRepo cartRepo;
CartController({required this.cartRepo});
Map<int,CartModel> _items={};
Map<int,CartModel> getItems() => _items;
List<CartModel> storageItems=[];

void addItem(ProductModel product,int quantity){
  var totalQuantity=0;
if (_items.containsKey(product.id)){
_items.update(product.id!, (value){
  totalQuantity=value.quantity!+quantity;
  return CartModel(
    id: value.id!,
name: value.name,
quantity: value.quantity!+quantity,
isExist: true,
img: value.img ,
price: value.price,
time: DateTime.now().toString(),
product: product
  );
});

if(totalQuantity<=0){
  _items.remove(product.id);
}
}
else{
  if(quantity>0){
_items.putIfAbsent(product.id!, () { 
  _items.forEach((key, value) {

  },);
  return  CartModel(id: product.id!,
name: product.name,
quantity: quantity,
isExist: true,
img: product.img ,
price: product.price,
time: DateTime.now().toString(),
product: product
);});
}
else{
  Get.snackbar("Item count", "You should add at least one item",backgroundColor: AppColors.mainColor,
  colorText: Colors.white);
}
}
cartRepo.addToCartList(get_Items());
update();
}
bool existInCart(ProductModel product){
if(_items.containsKey(product.id)){
  return true;
}
return false;
}
int getQuantity(ProductModel product){

   var quantity=0;
  if(_items.containsKey(product.id)){
    _items.forEach((key, value) {
      if(key==product.id){
       quantity=value.quantity!;
      }
    });
  }
  return quantity;
}
int get totalItems{
var totalQuantity=0;
_items.forEach((key, value) {
  totalQuantity=totalQuantity+value.quantity!;
});
return totalQuantity;
}

List<CartModel> get_Items(){
return _items.entries.map((e){
return e.value;
}).toList();
}

int get totalAmount{
  var total=0;
  _items.forEach((key, value) {
    total+=value.quantity!*value.price!;
  });
  return total;
}
List<CartModel> getCartData(){
    setCart=cartRepo.getCartList();
  return storageItems;
}
set setCart(List<CartModel> items){
  storageItems=items;
  for(int i=0;i<storageItems.length;i++){
  _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
  }
}
void addToHistory(){
  cartRepo.addToCartHistoryList();
  clear();
}
void clear(){
  _items={};
  update();
}
List<CartModel> getCartHistoryList(){
return cartRepo.getHistoryList();
}
set setItems(Map<int,CartModel> setItems){
  _items={};
  _items=setItems;
}
void addToCartList(){
  cartRepo.addToCartList(get_Items());
  update();
}
void clearCartHistory(){
  cartRepo.clearCartHistory();
  update();
}
}