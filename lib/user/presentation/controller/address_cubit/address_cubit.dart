import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_clean_arch/core/resources/color_manger/color_manager.dart';
import 'package:ecommerce_clean_arch/core/resources/reusable_comp/reusable_comp.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/addresses/Adresses.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/addresses/add_address.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/addresses/address_info.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/addresses/location_details.dart';
import 'package:ecommerce_clean_arch/user/domain/usecase/getAutoComplete.dart';
import 'package:ecommerce_clean_arch/user/domain/usecase/get_address_info_by_id.dart';
import 'package:ecommerce_clean_arch/user/domain/usecase/get_addresses.dart';
import 'package:ecommerce_clean_arch/user/domain/usecase/get_location_details.dart';
import 'package:ecommerce_clean_arch/user/domain/usecase/post_address.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../domain/entities/addresses/autocomplete.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit(this.getAddresses, this.postAddress, this.getAutoComplete, this.getAddressInfoById, this.getLocationDetailsByLatAndLng) : super(AddressInitial());
  static  AddressCubit get(context)=>BlocProvider.of(context);
  final GetAddresses getAddresses;
  Addresses? addresses;
  final PostAddress postAddress;
  final GetAutoComplete getAutoComplete;
  AddAddress? addAddress;
  final GetAddressInfoById getAddressInfoById;
  AddressInfo? addressInfo;
  final GetLocationDetailsByLatAndLng getLocationDetailsByLatAndLng;
  LocationDetails? locationDetails;
  var formKey = GlobalKey<FormState>();
  PlaceAutoComplete? placeAutoComplete;
  TextEditingController searchTextEditingController= TextEditingController();
  TextEditingController nameTextEditingController= TextEditingController();
  TextEditingController cityTextEditingController= TextEditingController();
  TextEditingController regionTextEditingController= TextEditingController();
  TextEditingController detailsTextEditingController= TextEditingController();
  TextEditingController notesTextEditingController= TextEditingController();
  LatLng currentPosition = LatLng(30.0444, 31.2357) ;
   Completer<GoogleMapController> controllerMap = Completer<GoogleMapController>();
  CameraPosition initialPosition = const CameraPosition(
    target: LatLng(30.0444, 31.2357),
    zoom: 14,
  );


   getCurrentLocation() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final GoogleMapController controller = await controllerMap.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        zoom: 17,
        target: LatLng( position.latitude, position.longitude))));
    emit(GotExactLocationSuccess());
  }


  moveMarker(LatLng position){
    currentPosition = position;
    print(currentPosition);
    emit(MoveMarker());
    print(state);
  }


geTAllAddresses()async{
  emit(GetAddressInitial());
  final result = await getAddresses.execute();
  result.fold((l) {
    emit(GetAddressError());
  }, (r) {
    addresses =r;
    emit(GetAddressSuccess());
  });


}
  postAnAddress(String name ,String city,String details,String note,double latitude,double longitude) async {
    emit(PostAddressInitial());
    final result = await postAddress.execute(name,city, '.', details, note, latitude, longitude);
    result.fold((l) {
      emit(PostAddressError());
    }, (r) {
      addAddress =r;
      print(r.message);
      emit(PostAddressSuccess());
      print(state);
    });
  }

  changeDefaultAddress(int newAddressId){
    //todo save it to device
    emit(ChangeAddressDefault());
  }


  loadAutoComplete(String search) async {
    emit(GetAutoCompleteInitial());
    final result = await getAutoComplete.execute(search);
    result.fold((l) {
      emit(GetAutoCompleteError());
    }, (r) {
      placeAutoComplete = r;
      emit(GetAutoCompleteSuccess(placeAutoComplete!));
    });

  }

  userGetAddressInfoByIdU(String id)async{
    emit(GetAddressInitial());
    final result = await  getAddressInfoById.execute(id);
    result.fold((l) {
      emit(GetAddressInfoByIdError());
    }, (r) async {
      addressInfo =r;
      print(r.location['lng']);
      print(r.location['lat']);
      final GoogleMapController controller = await controllerMap.future;
      await controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          zoom: 17,
          target: LatLng(r.location['lat'], r.location['lng']))));
      emit(GetAddressInfoByIdSuccess(addressInfo!));
    });
  }




 getLocationDetailsByLat(LatLng position)async{
     emit(GetLocationDetailsByLatInitial());
     final result = await getLocationDetailsByLatAndLng.execute(position);
     result.fold((l) {
      emit(GetLocationDetailsByLatError());
     }, (r) {
       locationDetails =r;
       emit(GetLocationDetailsBySuccess(r));
       print(state);
     });
 }



addAddressFinal()async{
     print(nameTextEditingController.value.text);
     print(locationDetails!.compoundCode);
     print(locationDetails!.formattedAddress);
     print(currentPosition.latitude);
     print(currentPosition.longitude);
   await  postAnAddress(nameTextEditingController.value.text, locationDetails!.compoundCode, locationDetails!.formattedAddress, notesTextEditingController.value.text, currentPosition.latitude, currentPosition.longitude);
     return myToast(addAddress!.message, ColorManager.green);

}



}
