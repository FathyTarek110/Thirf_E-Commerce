import 'package:ecommerce_clean_arch/user/domain/entities/orders/estimate_order.dart';

class EstimateOrderModel extends EstimateOrder{
  EstimateOrderModel(super.total, super.subTotal, super.discount, super.points);

  factory EstimateOrderModel.fromJson(Map<String,dynamic> json){
    return EstimateOrderModel(json['data']['total'], json['data']['sub_total'], json['data']['discount'], json['data']['points']);
  }

}