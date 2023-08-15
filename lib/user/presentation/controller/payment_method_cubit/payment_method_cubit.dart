import 'package:bloc/bloc.dart';
import 'package:ecommerce_clean_arch/core/resources/color_manger/color_manager.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'payment_method_state.dart';

class PaymentMethodCubit extends Cubit<PaymentMethodState> {
  PaymentMethodCubit() : super(PaymentMethodInitial());
  static PaymentMethodCubit get(context)=>BlocProvider.of(context);
  final TextEditingController name = TextEditingController();
  final TextEditingController num = TextEditingController();
  final TextEditingController expDate = TextEditingController();
  final TextEditingController cvv = TextEditingController();


  List credits = [
    [
      'Bruce Thomas Wayne ',
      '**** **** **** 2123',
      '10/23',
      ColorManager.primary
    ],
    [
      'Bruce Thomas Wayne ',
      '**** **** **** 5674',
      '05/25',
      Colors.blueAccent
    ],
    [
      'Bruce Thomas Wayne ',
      '**** **** **** 9575',
      '7/26',
      Colors.amber
    ],
    [
      'Bruce Thomas Wayne ',
      '**** **** **** 8247',
      '3/25',
      Colors.redAccent
    ],
  ];
}
