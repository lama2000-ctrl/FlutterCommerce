import 'package:delivery/controllers/auth_controller.dart';
import 'package:delivery/controllers/location_controller.dart';
import 'package:delivery/controllers/user_controller.dart';
import 'package:delivery/models/address_model.dart';
import 'package:delivery/pages/address/pick_address_map.dart';
import 'package:delivery/routes/route_helper.dart';
import 'package:delivery/utils/colors.dart';
import 'package:delivery/utils/dimensions.dart';
import 'package:delivery/widget/app_text_field.dart';
import 'package:delivery/widget/big_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  TextEditingController _addressController=TextEditingController();
  TextEditingController _contactPersonName=TextEditingController();
  TextEditingController _contactPersonNumber=TextEditingController();
  late bool  _isLogged;
  CameraPosition _cameraPosition=CameraPosition(target: LatLng(3.8480,11.5021),
  zoom: 17);
   LatLng _initialPosition=LatLng(3.8480,11.5021);
  @override
  void initState(){
    super.initState();
    _isLogged=Get.find<AuthController>().UserLoggedIn();
   
    if(_isLogged && Get.find<UserController>().userModel==null){
      Get.find<UserController>().getUserInfo();
    }
    if(Get.find<LocationController>().addressList.isNotEmpty){
    if(Get.find<LocationController>().getUserAddressFromLocalStorage()==""){
      Get.find<LocationController>().saveUserAddress(
        Get.find<LocationController>().addressList.last
      );
       print(Get.find<LocationController>().addressList.last.toString());
    print("-----------------------");
    }
      Get.find<LocationController>().getUserAddress();
      print("\\\\\\\\ "+Get.find<LocationController>().getAddress["address"].toString());
      _cameraPosition=CameraPosition(target: LatLng(
       double.parse(Get.find<LocationController>().getAddress["latitude"]),
       double.parse(Get.find<LocationController>().getAddress["longitude"]),
      ));
      _initialPosition=LatLng(
       double.parse(Get.find<LocationController>().getAddress["latitude"]),
       double.parse(Get.find<LocationController>().getAddress["longitude"]),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
            title: Text("Address Page"),
            backgroundColor: AppColors.mainColor,
          ) ,
      body: GetBuilder<UserController>(
        builder: (userController) {
          if(userController.userModel!=null && _contactPersonName.text.isEmpty){
            _contactPersonName.text='${userController.userModel.name}';
            _contactPersonNumber.text='${userController.userModel.phone}';
          }
          if(Get.find<LocationController>().addressList.isNotEmpty){
            _addressController.text= Get.find<LocationController>().getUserAddress().address;
          }
          return GetBuilder<LocationController>(
            builder: (locationController) {
              _addressController.text='${locationController.placemark.name?? ''}'
              '${locationController.placemark.locality??''}'
              '${locationController.placemark.postalCode??''}'
              '${locationController.placemark.country??''}';
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Container(
                    height: 140,
                    margin: EdgeInsets.only(left: 5.0,right: 5.0,top: 5.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(width: 2,color: AppColors.mainColor)
                    ),
                    child: Stack(
                      children: [
                        GoogleMap(initialCameraPosition: CameraPosition(target: _initialPosition,
                        zoom: 17),
                        myLocationEnabled: true,
                        zoomControlsEnabled: false,
                        zoomGesturesEnabled: false,
                       indoorViewEnabled: true,
                       mapToolbarEnabled: false,
                       onTap: (latLng){
                    Get.toNamed(RouteHelper.getPickAddressPage(),
                    arguments: PickAddressMap(
                      fromAddress: true,
                      fromSignUp: false,
                      googleMapController: locationController.mapController,
                    ));
                       },
                       onCameraIdle: (){
                   locationController.updatePosition(_cameraPosition,true);
                       },
                       onCameraMove: ((position)=> _cameraPosition=position),
                       onMapCreated: (GoogleMapController controller){
                        locationController.setMapController(controller);
                        if(Get.find<LocationController>().addressList.isEmpty){

                        }
                       } ,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: Dimensions.width20,top: Dimensions.height20),
                    child: SizedBox(height: 50,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: locationController.addressTypeList.length ,
                      itemBuilder: (context,index){
                     return  InkWell(
                        onTap: (){
                          locationController.setAddressTypeIndex(index);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.height20,
                          vertical: Dimensions.height20),
                          margin: EdgeInsets.only(right: Dimensions.width20),
                       decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20/4),
                        color: Theme.of(context).cardColor,
                        boxShadow: [BoxShadow(
                          color: Colors.grey[400]!,
                          spreadRadius: 1,
                          blurRadius: 6
              
                        )
                        ]
                       ),
                       child: 
                        Icon(index==0?Icons.home_filled:index==1?Icons.work:Icons.location_on,
                        color: locationController.addressTypeIndex==index?AppColors.mainColor:
                        Theme.of(context).disabledColor,)
                  
                        ),
                      );
                    }),),
                  ),
                  SizedBox(height: Dimensions.height20,),
                  Padding(
                    padding:  EdgeInsets.only(left: Dimensions.height20),
                    child: BigText(text: "Delivery address"),
                  ),
                  SizedBox(height: Dimensions.height10,),
                 AppTextField(iconData: Icons.map, text: "Your Address",
                 textEditingController: _addressController),
                  
                   SizedBox(height: Dimensions.height20,),
                  Padding(
                    padding:  EdgeInsets.only(left: Dimensions.height20),
                    child: BigText(text: "Contact name"),
                  ),
                  SizedBox(height: Dimensions.height10,),
              
                 AppTextField(iconData: Icons.person, text: "Your Name",
                 textEditingController: _contactPersonName),
                  SizedBox(height: Dimensions.height20,),
                  Padding(
                    padding:  EdgeInsets.only(left: Dimensions.height20),
                    child: BigText(text: "Your Number"),
                  ),
                   SizedBox(height: Dimensions.height20,),
                 AppTextField(iconData: Icons.phone, text: "Your Number",
                 textEditingController: _contactPersonNumber),
                 
                  ],
                ),
              );
            }
          );
        }
      ),
      bottomNavigationBar: GetBuilder<LocationController>(
        builder: (locationcontroller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              
              Container(
            height: Dimensions.height30*8,
            padding: EdgeInsets.only(top: Dimensions.height30,bottom: Dimensions.height30,
            left: Dimensions.width20,right: Dimensions.width20),
            decoration: BoxDecoration(borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.radius20*2),
              topRight: Radius.circular(Dimensions.radius20*2)
            ),
            color: AppColors.buttonBackgroundColor),
            child: Row( mainAxisAlignment: MainAxisAlignment.center,
              children: [
          
                GestureDetector(
                  onTap: (){
                   // controller.addItem(product);
                   AddressModel _addressModel= AddressModel(addressType: 
                    locationcontroller.addressTypeList[locationcontroller.addressTypeIndex], 
                    contactPersonName: _contactPersonName.text,
                    contactPersonNumber: _contactPersonNumber.text,
                   address: _addressController.text,
                    latitude: locationcontroller.position.latitude.toString(),
                     longitude: locationcontroller.position.longitude.toString());
                     locationcontroller.addAddress(_addressModel).then((response) {
                      if(response.isSuccess){
                        Get.toNamed(RouteHelper.getInitial());
                        Get.snackbar("Address","Added Successfully");
                      }
                      else{
                        Get.snackbar("Address", "Couldn't save address");
                      }
                     });
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,
                  left: Dimensions.width20,right: Dimensions.width20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.mainColor
                    ),
                    child: BigText(text: "Save address",size: 26,),
                  ),
                )
              ],
            ),
          ),
            ],
          );
        }
      ), 
    );
  }
}