import 'package:delivery/data/api/api_client.dart';
import 'package:delivery/models/place_order_model.dart';
import 'package:delivery/utils/app_constants.dart';
import 'package:get/get.dart';
class OrderRepo{
  final ApiClient apiClient;
  OrderRepo({required this.apiClient});
    Future<Response> placeOrder(PlaceOrderBody placeOrderBody){
  return apiClient.postData(AppConstants.PLACE_ORDER_URI,placeOrderBody.toJson());  }
}