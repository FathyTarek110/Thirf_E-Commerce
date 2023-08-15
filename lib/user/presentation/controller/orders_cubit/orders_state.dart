part of 'orders_cubit.dart';

@immutable
abstract class OrdersState {}

class OrdersInitial extends OrdersState {}
class GetOrdersInitial extends OrdersState {}
class GetOrdersSuccess extends OrdersState {}
class GetOrdersError extends OrdersState {}
