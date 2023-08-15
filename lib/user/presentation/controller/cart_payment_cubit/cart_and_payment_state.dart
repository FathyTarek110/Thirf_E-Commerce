part of 'cart_and_payment_cubit.dart';
abstract class CartAndPaymentState {}

class CartAndPaymentInitial extends CartAndPaymentState {}
class CartAndPaymentGetCartInitial extends CartAndPaymentState {}
class CartAndPaymentGetCartSuccess extends CartAndPaymentState {}
class CartAndPaymentGetCartError extends CartAndPaymentState {}
class CartAndPaymentDeleteFromCartInitial extends CartAndPaymentState {}
class CartAndPaymentDeleteFromCartSuccess extends CartAndPaymentState {}
class CartAndPaymentDeleteFromCartError extends CartAndPaymentState {}
class CartAndPaymentUpdateCartSuccess extends CartAndPaymentState {}
class GetAddressesInitial extends CartAndPaymentState{}
class GetAddressesError extends CartAndPaymentState{}
class GetAddressesSuccess extends CartAndPaymentState{

}

class ChangeDropDownValue extends CartAndPaymentState{}

class AddOrderInitial extends CartAndPaymentState{}
class AddOrderError extends CartAndPaymentState{}
class AddOrderSuccess extends CartAndPaymentState{}

class EstimateOrderInitial extends CartAndPaymentState{}
class EstimateOrderError extends CartAndPaymentState{}
class EstimateOrderSuccess extends CartAndPaymentState{}
class UseCode extends CartAndPaymentState{}