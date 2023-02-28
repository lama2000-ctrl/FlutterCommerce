import 'package:delivery/data/repository/order_repo.dart';
import 'package:get/get.dart';

import '../models/place_order_model.dart';

class OrderController extends GetxController implements GetxService{
 OrderRepo orderRepo;
 OrderController({required this.orderRepo});
  bool _isLoading=false;
  bool get isLoading => _isLoading;
  Future<void> placeOrder(PlaceOrderBody placeOrder,Function callback) async{
Response response=await orderRepo.placeOrder(placeOrder);
if(response.statusCode==200){
  _isLoading=false;
  String mess=response.body["message"];
  String OrderId=response.body["order_id"];
callback(true,mess,OrderId);
}
else{
  callback(false,response.statusText!,'-1');
}
  }
}