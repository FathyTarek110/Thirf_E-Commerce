import 'package:bloc/bloc.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/orders/orders.dart';
import 'package:ecommerce_clean_arch/user/domain/usecase/get_orders.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit(this.getOrders) : super(OrdersInitial());
  final GetOrders getOrders;
  Orders? orders;
  static OrdersCubit get(context)=>BlocProvider.of(context);

  getAllOrders()async{
    emit(GetOrdersSuccess());
    final result = await getOrders.execute();
    result.fold((l) {
      emit(GetOrdersError());
    }, (r) {
      orders = r;
      print(r.orders);
      emit(GetOrdersSuccess());
      print(state);
    });
}

}
