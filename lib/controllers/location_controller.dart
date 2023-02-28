import 'dart:convert';

import 'package:delivery/data/api/api_checker.dart';
import 'package:delivery/data/repository/location_repo.dart';
import 'package:delivery/models/response_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/src/places.dart';
import '../models/address_model.dart';

class LocationController extends GetxController implements GetxService{
  final LocationRepo locationRepo;
  LocationController({required this.locationRepo});
  bool _loading=false;
  late Position _position;
  late Position _pickPosition;
  Placemark _placemark=Placemark();
  Placemark _pickPlacemark=Placemark();
  Placemark get placemark => _placemark;
   Placemark get pickPlacemark => _pickPlacemark;
   Position get position=> _position;
  bool _isLoading=false;
  bool _inZone=false;
  bool _buttonDisabled=true;
  bool get isLoading =>_isLoading;
  bool get inZone => _inZone;
  bool get buttonDisabled => _buttonDisabled;
 
 List<Prediction> _predictionList=[];
List<Prediction> get predictionList => _predictionList;
  List<AddressModel> _addressList=[];
  List<AddressModel> get addressList => _addressList;
  late List<AddressModel> _allAddressList=[];
  List<AddressModel> get allAddressList=> _allAddressList;
  List<String> _addressTypeList=["home","office","others"];
  int _addressTypeIndex=0;
  int get addressTypeIndex => _addressTypeIndex;
 List<String> get addressTypeList => _addressTypeList;
    Position get pickPosition=> _pickPosition;
  late GoogleMapController _mapController;
  GoogleMapController get mapController=> _mapController;
  bool get loading => _loading;
  bool _updateAddressData=true;
 bool _changeAddress=true;
  void setMapController(GoogleMapController mapController){
    _mapController=mapController;
  }

  void updatePosition(CameraPosition position, bool fromAddress)async {
if(_updateAddressData){
  _loading=true;
  update();
  try{
    print(position.target.longitude.toString());
if(fromAddress){
  _position=Position(longitude: position.target.longitude, 
  latitude: position.target.latitude,
   timestamp: DateTime.now(),
    accuracy: 1, 
    altitude: 1,
     heading: 1,
      speed: 1, 
      speedAccuracy: 1);
}
else{
   _pickPosition=Position(longitude: position.target.longitude, 
  latitude: position.target.latitude,
   timestamp: DateTime.now(),
    accuracy: 1, 
    altitude: 1,
     heading: 1,
      speed: 1, 
      speedAccuracy: 1);
}
ResponseModel _responseModel=await getZone(position.target.latitude.toString(), 
position.target.longitude.toString(), false);
 _buttonDisabled= !_responseModel.isSuccess;
if(_changeAddress){
  String _address=await getAddressFromGeocode(
    LatLng(position.target.latitude, 
    position.target.longitude)
  );
  fromAddress? _placemark=Placemark(name: _address):
  _pickPlacemark=Placemark(name: _address);
}
else{
  _changeAddress=true;
    //update();
}
  }catch(e){
    throw e;
  }
  _loading=false;
  update();
}
else{
  _updateAddressData=true;

}
  }
  
 Future<String> getAddressFromGeocode(LatLng latLng) async{
String _address="Unknown Location";
Response response=await locationRepo.getAddressFromGeocode(latLng);
if(response.body["status"]=="OK"){
_address=response.body["results"][0]['formatted_address'].toString();
}
else{
print("errrror");
print(response.statusCode);
}
update();
return _address;
  }
  late Map<String,dynamic> _getAddress;
  Map get getAddress => _getAddress;
  AddressModel getUserAddress(){
    late AddressModel _addressModel;
    _getAddress=jsonDecode(locationRepo.getUserAddress());
    print("_getAddress:  "+_getAddress.toString());
try{
_addressModel=AddressModel.fromJson(jsonDecode(locationRepo.getUserAddress()));
}catch(e){
   print("0-------------------------");
  throw e;
 
} 
return _addressModel;
 }
void setAddressTypeIndex(int index){
  _addressTypeIndex=index;
  update();
}

Future<ResponseModel> addAddress(AddressModel addressModel) async {
_loading=true;
update();
Response response=await locationRepo.addAddress(addressModel);
ResponseModel responseModel;
if(response.statusCode==200){
  await getAddressList();
  String message=response.body["message"];
  responseModel=ResponseModel(true, message);
  await saveUserAddress(addressModel);
}
else{
 responseModel=ResponseModel(false, response.statusText!);
}
update();
return responseModel;
}
Future<void> getAddressList() async{
Response response=await locationRepo.getAllAddress();
if(response.statusCode==200){
_addressList=[];
_allAddressList=[];
response.body.forEach((address){
_addressList.add(AddressModel.fromJson(address));
_allAddressList.add(AddressModel.fromJson(address));
});
}
else{
  _addressList=[];
_allAddressList=[];
}
update();
}
Future<bool> saveUserAddress(AddressModel addressModel) async{
String userAddress=jsonEncode(addressModel.toJson());
print("User address is "+userAddress);
return await locationRepo.saveUserAddress(userAddress);
}
void clearAddressList(){
  _addressList=[];
  _allAddressList=[];
  update();
}

  String getUserAddressFromLocalStorage() {
    return locationRepo.getUserAddress();
  }
void setAddressData(){
  _position=_pickPosition;
  _placemark=_pickPlacemark;
  _updateAddressData=false;
  update();
}
Future<ResponseModel> getZone(String lat,String long,bool markerLoad) async{                            
late ResponseModel _responseModel;
if(markerLoad){
  _loading=true;
}
else{
  _isLoading=true;

}
update();
Response _response=await locationRepo.getZone(lat,long);
if(_response.statusCode==200){

_inZone=true;
_responseModel=ResponseModel(true,_response.body["zone_id"].toString());
print("yesssssssssss");
}
else{
_inZone=false;
_responseModel=ResponseModel(true,_response.statusText.toString());
print(_response.statusText!+"why..............");
}
if(markerLoad){
  _loading=false;
}
else{
  _isLoading=false;
}
update();
return _responseModel;
}
Future<List<Prediction>> searchLocation(BuildContext context,String text) async{
  if(text.isNotEmpty){
    Response response=await locationRepo.searchLocation(text);
  if(response.statusCode==200 && response.body["status"]=="OK"){
_predictionList=[];
response.body['predictions'].forEach((prediction)=>
 _predictionList.add(Prediction.fromJson(prediction))) ;
  }
  else{
ApiChecker.checkApi(response);
  }
  } 
return _predictionList;
}

setLocation(String placeID,String address,GoogleMapController mapController) async{
_loading=true;
update();
PlacesDetailsResponse detail;
Response response= await locationRepo.setLocation(placeID);
detail=PlacesDetailsResponse.fromJson(response.body);
 _pickPosition= Position(
  latitude: detail.result.geometry!.location.lat,
  longitude: detail.result.geometry!.location.lng,
  timestamp: DateTime.now(),
  accuracy: 1,
  altitude: 1,
  heading: 1,
  speed: 1,
  speedAccuracy: 1
);
_pickPlacemark=Placemark(name: address);
_changeAddress=false;
if(mapController.isNull){
  mapController.animateCamera(CameraUpdate.newCameraPosition(
    CameraPosition(target: LatLng(
      detail.result.geometry!.location.lat,
      detail.result.geometry!.location.lng
    ),zoom: 17)
  ));
}
_loading=false;
update();

}

}