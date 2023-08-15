part of 'address_cubit.dart';
abstract class AddressState {}

class AddressInitial extends AddressState {}
class GetAddressInitial extends AddressState {}
class GetAddressSuccess extends AddressState {}
class GetAddressError extends AddressState {}
class PostAddressInitial extends AddressState {}
class PostAddressSuccess extends AddressState {}
class PostAddressError extends AddressState {}
class ChangeAddressDefault extends AddressState {}
class GotExactLocationSuccess extends AddressState {}
class MoveMarker extends AddressState{}

class GetAutoCompleteInitial extends AddressState {}
class GetAutoCompleteSuccess extends AddressState {
  final PlaceAutoComplete placeAutoComplete;

  GetAutoCompleteSuccess(this.placeAutoComplete);
}
class GetAutoCompleteError extends AddressState {}

class GetAddressInfoByIdInitial extends AddressState {}
class GetAddressInfoByIdSuccess extends AddressState {
  final AddressInfo addressInfo;

  GetAddressInfoByIdSuccess(this.addressInfo);
}
class GetAddressInfoByIdError extends AddressState {}


class GetLocationDetailsByLatInitial extends AddressState {}
class GetLocationDetailsByLatError extends AddressState {}
class GetLocationDetailsBySuccess extends AddressState {
  final LocationDetails locationDetails;

  GetLocationDetailsBySuccess(this.locationDetails);
}

class AddAddressInitial extends AddressState {}
class AddAddressSuccess extends AddressState {}
class AddAddressError extends AddressState {}