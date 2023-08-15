import 'package:ecommerce_clean_arch/core/resources/reusable_comp/reusable_comp.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/addresses/Adresses.dart';
import 'package:ecommerce_clean_arch/user/domain/usecase/estimate_order_costs.dart';
import 'package:ecommerce_clean_arch/user/domain/usecase/get_addresses.dart';
import 'package:ecommerce_clean_arch/user/domain/usecase/get_cart.dart';
import 'package:ecommerce_clean_arch/user/domain/usecase/post_or_delete_cart_item.dart';
import 'package:ecommerce_clean_arch/user/domain/usecase/post_order.dart';
import 'package:ecommerce_clean_arch/user/presentation/screens/cart_and_payment/payment_success.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import '../../../../core/resources/color_manger/color_manager.dart';
import '../../../domain/entities/cart/cart.dart';
import '../../../domain/entities/orders/estimate_order.dart';
import '../../screens/home_view/home_view.dart';
part 'cart_and_payment_state.dart';

class CartAndPaymentCubit extends Cubit<CartAndPaymentState> {
  CartAndPaymentCubit(this.getCart, this.postOrDeleteCartItem, this.getAddresses, this.postOrder, this.estimateOrderCost) : super(CartAndPaymentInitial());

  static CartAndPaymentCubit get(context)=>BlocProvider.of(context);
  TextEditingController promoTextEditingController = TextEditingController();
  final GetCart getCart;
  final PostOrDeleteCartItem postOrDeleteCartItem;
  List cartItems = [ ];
  Cart? cart;
 final GetAddresses getAddresses;
 Addresses? addresses;
 bool isReload= false;
 int dropDownValue = 1;
 final PostOrder postOrder;
 final addressSwiperController  = SwiperController();
 int currentSwiperIndex = 0;
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
  final EstimateOrderCost estimateOrderCost;
  EstimateOrder? estimateOrder;
  bool usepoints = false;

  void usePointsMethod(){
    usepoints =! usepoints;
    emit(UseCode());
    getOrderCosts(usepoints, 0);
  }

swiperInit(){
    addressSwiperController.addListener(() {
      print(addressSwiperController.index);
      currentSwiperIndex = addressSwiperController.index;
    });
}
  getCartItems()async{
    emit(CartAndPaymentGetCartInitial());
    final result = await getCart.execute();
    result.fold((l) {
      emit(CartAndPaymentGetCartError());
    }, (r) {
      cart = r;
      cartItems = r.cartItems;
      print(cartItems);
      emit(CartAndPaymentGetCartSuccess());
      print(state);
    });
  }
  deleteProductfromCart(int id,index)async{
    cartItems[index]['product']['in_cart'] =! cartItems[index]['product']['in_cart'];
    cartItems.removeAt(index);
    final result = await postOrDeleteCartItem.execute(id);
    result.fold((l) {
      emit(CartAndPaymentDeleteFromCartError());
    }, (r) {
      getCartItems();
      emit(CartAndPaymentDeleteFromCartSuccess());
      print(state);
    });
  }

  updateCart(){
    emit(CartAndPaymentUpdateCartSuccess());
  }

  getAllAddresses()async{
    emit(GetAddressesInitial());
    final result = await getAddresses.execute();
    result.fold((l) {
      emit(GetAddressesError());
    }, (r) {
      addresses = r;
      print(state);
      emit(GetAddressesSuccess());
    });
  }

 changeDropDownValue(int value){
    dropDownValue =value;
    emit(ChangeDropDownValue());
 }


  addOrder(int addressId , int paymentMethod,bool usePoints,context)async{
    emit(AddOrderInitial());
    final result = await  postOrder.execute(addressId, paymentMethod, usePoints);
    result.fold((l) {
      emit(AddOrderError());
    }, (r) {
      if(r.status == true){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const PaymentSuccess()));

      }
      else{
        myToast('error occured', ColorManager.red);
      }
      emit(AddOrderSuccess());
    });
 }

 void getOrderCosts(bool usePoints,int promoCodeId) async {
    emit(EstimateOrderInitial());
    final result = await estimateOrderCost.execute(usePoints, promoCodeId);
    result.fold((l) {
      emit(EstimateOrderError());
    }, (r) {
      estimateOrder = r;
      emit(EstimateOrderSuccess());
      print(state);
    });
 }



}
