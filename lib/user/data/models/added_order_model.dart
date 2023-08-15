import 'package:ecommerce_clean_arch/user/domain/entities/orders/added_order.dart';

class AddedOrderModel extends AddedOrder{
  AddedOrderModel(super.message, super.paymentMethod, super.id, super.status);

  factory AddedOrderModel.fromJson(Map<String,dynamic> json){
    return AddedOrderModel(json['message'], json['data']['payment_method'], json['data']['id'],json['status']);
  }

}