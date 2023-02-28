import 'package:delivery/base/custom_button.dart';
import 'package:delivery/base/custom_loader.dart';
import 'package:delivery/controllers/location_controller.dart';
import 'package:delivery/pages/address/widgets/search_location_page.dart';
import 'package:delivery/routes/route_helper.dart';
import 'package:delivery/utils/colors.dart';
import 'package:delivery/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickAddressMap extends StatefulWidget {
  final bool fromSignUp;
  final bool fromAddress;
  final GoogleMapController googleMapController;
  const PickAddressMap({super.key,required this.fromAddress,
  required this.fromSignUp,
  required this.googleMapController});

  @override
  State<PickAddressMap> createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {
  late LatLng _initialPosition;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;
  @override
  void initState(){
    super.initState();
    if(Get.find<LocationController>().addressList.isEmpty){
      _initialPosition=LatLng(3.8480, 11.5021);
      _cameraPosition=CameraPosition(target: _initialPosition,zoom: 17);
    }
    else{
   if(Get.find<LocationController>().addressList.isNotEmpty){
  print(Get.find<LocationController>().
    getAddress["latitude"].toString());
    _initialPosition=LatLng(double.parse(Get.find<LocationController>().
    getAddress["latitude"]),
    
     double.parse(Get.find<LocationController>().getAddress["longitude"]));
     _cameraPosition=CameraPosition(target: _initialPosition,zoom: 17);
   }
    }
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
      builder: (locationController) {
        return Scaffold(
          body: SafeArea(child: Center(child: 
          SizedBox(width: double.maxFinite,
          child: Stack(
            children: [
              GoogleMap(initialCameraPosition: CameraPosition(target: _initialPosition,
              zoom: 17          
              ),
              zoomControlsEnabled: false,
              onCameraMove: ((position) {
                _cameraPosition=position;
              }
              ),
              onCameraIdle: () {
                Get.find<LocationController>().updatePosition(_cameraPosition, false);
              },
              onMapCreated: ((controller) {
                _mapController=controller;
                if(!widget.fromAddress){

                }
              }),
              ),
              Center(
                child: (!locationController.loading)? Image.asset("",height: 50,width: 50,):
                const Center(child: CircularProgressIndicator(),),
              ),
              Positioned(
                top: Dimensions.height45,
                left: Dimensions.width20,
                right: Dimensions.width20,
                child: InkWell(
                  onTap: ()=> Get.dialog(LocationDialogue(mapController: _mapController)),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(Dimensions.radius20/2)
                    ),
                    child: Row(children: [
                      Icon(Icons.location_on,size: 25,color: Colors.pink[90]),
                      Expanded(child: Text(
                        locationController.pickPlacemark.name?? '',
                        style: TextStyle(color: Colors.white,fontSize: Dimensions.font16),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        )),
                        SizedBox(width: Dimensions.width10,),
                        Icon(Icons.search,size: 25,color: AppColors.yellowColor,),
                    ]),),
                )
              ),
              Positioned(
                bottom: 80,
                child:(locationController.isLoading)?Center(child: CircularProgressIndicator(),):CustomButton(
                  
                  buttonText:!locationController.inZone?(widget.fromAddress? "Pick  Address": "Pick Location"):
                  "Service is not available in your zone",
                  onPressed: (locationController.buttonDisabled ||locationController.loading)? null:(){
               if(locationController.pickPosition.latitude!=0 && 
               locationController.pickPlacemark.name!=null){
                if(widget.fromAddress){
                  if(widget.googleMapController!=null){
                  widget.googleMapController.moveCamera(CameraUpdate.newCameraPosition(
                    CameraPosition(target: 
                    LatLng(
                    locationController.pickPosition.latitude,locationController.pickPosition.longitude
                  ))));
                  locationController.setAddressData();
                  }
                  Get.toNamed(RouteHelper.getAddressPage());
                }
               }
                  }
                  ) 
                )
            ],
          ),),),
          
          ),
        );
      }
    );
  }
}