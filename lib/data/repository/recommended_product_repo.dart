import 'package:delivery/data/api/api_client.dart';
import 'package:delivery/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
class RecommendedProductRepo extends GetxService{
  final ApiClient apiClient;

  RecommendedProductRepo({required this.apiClient});
  Future<Response> getRecommendedProductList() async{
return await apiClient.getData(AppConstants.RECOMMENDED_PRODUCT_URI);
  }
}