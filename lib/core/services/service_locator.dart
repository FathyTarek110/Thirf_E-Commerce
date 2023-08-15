import 'package:ecommerce_clean_arch/authentication/data/data_source/remote_data_source/login_data_source/login_data_source.dart';
import 'package:ecommerce_clean_arch/authentication/data/data_source/remote_data_source/signup_data_source/signup_data_source.dart';
import 'package:ecommerce_clean_arch/authentication/data/repository/login_repository.dart';
import 'package:ecommerce_clean_arch/authentication/data/repository/signup_repository.dart';
import 'package:ecommerce_clean_arch/authentication/domain/repository/base_login_repository.dart';
import 'package:ecommerce_clean_arch/authentication/domain/repository/base_sign_up_repository.dart';
import 'package:ecommerce_clean_arch/authentication/domain/usecase/get_login_response.dart';
import 'package:ecommerce_clean_arch/authentication/domain/usecase/get_signup_response.dart';
import 'package:ecommerce_clean_arch/user/data/data_source/remote_data_source/address_data_source.dart';
import 'package:ecommerce_clean_arch/user/data/data_source/remote_data_source/cart_data_source.dart';
import 'package:ecommerce_clean_arch/user/data/data_source/remote_data_source/category_data_source.dart';
import 'package:ecommerce_clean_arch/user/data/data_source/remote_data_source/favourite_data_source.dart';
import 'package:ecommerce_clean_arch/user/data/data_source/remote_data_source/orders_data_source.dart';
import 'package:ecommerce_clean_arch/user/data/data_source/remote_data_source/product_data_source.dart';
import 'package:ecommerce_clean_arch/user/data/data_source/remote_data_source/profile_data_source.dart';
import 'package:ecommerce_clean_arch/user/data/repository/address_repository.dart';
import 'package:ecommerce_clean_arch/user/data/repository/category_repository.dart';
import 'package:ecommerce_clean_arch/user/data/repository/favourite_repository.dart';
import 'package:ecommerce_clean_arch/user/data/repository/order_repository.dart';
import 'package:ecommerce_clean_arch/user/data/repository/product_repository.dart';
import 'package:ecommerce_clean_arch/user/data/repository/profile_repository.dart';
import 'package:ecommerce_clean_arch/user/domain/repository/base-product-repository.dart';
import 'package:ecommerce_clean_arch/user/domain/repository/base_address_repository.dart';
import 'package:ecommerce_clean_arch/user/domain/repository/base_cart_repository.dart';
import 'package:ecommerce_clean_arch/user/domain/repository/base_category_repository.dart';
import 'package:ecommerce_clean_arch/user/domain/repository/base_favourite_repository.dart';
import 'package:ecommerce_clean_arch/user/domain/repository/base_order_repository.dart';
import 'package:ecommerce_clean_arch/user/domain/repository/base_profile_repository.dart';
import 'package:ecommerce_clean_arch/user/domain/usecase/estimate_order_costs.dart';
import 'package:ecommerce_clean_arch/user/domain/usecase/getAutoComplete.dart';
import 'package:ecommerce_clean_arch/user/domain/usecase/get_address_info_by_id.dart';
import 'package:ecommerce_clean_arch/user/domain/usecase/get_addresses.dart';
import 'package:ecommerce_clean_arch/user/domain/usecase/get_all_products_response.dart';
import 'package:ecommerce_clean_arch/user/domain/usecase/get_cart.dart';
import 'package:ecommerce_clean_arch/user/domain/usecase/get_category_info_response.dart';
import 'package:ecommerce_clean_arch/user/domain/usecase/get_category_response.dart';
import 'package:ecommerce_clean_arch/user/domain/usecase/get_favourites.dart';
import 'package:ecommerce_clean_arch/user/domain/usecase/get_location_details.dart';
import 'package:ecommerce_clean_arch/user/domain/usecase/get_orders.dart';
import 'package:ecommerce_clean_arch/user/domain/usecase/get_product_response.dart';
import 'package:ecommerce_clean_arch/user/domain/usecase/get_profile_data.dart';
import 'package:ecommerce_clean_arch/user/domain/usecase/post_address.dart';
import 'package:ecommerce_clean_arch/user/domain/usecase/post_favourite_by_id.dart';
import 'package:ecommerce_clean_arch/user/domain/usecase/post_or_delete_cart_item.dart';
import 'package:get_it/get_it.dart';

import '../../user/data/repository/cart_repository.dart';
import '../../user/domain/usecase/post_order.dart';
import '../../user/domain/usecase/product_search.dart';
final sl = GetIt.instance;

class ServiceLocator{

 void init(){
      //use cases
        sl.registerLazySingleton(() => GetLoginResponse(sl()));
        sl.registerLazySingleton(() => GetSignUpResponse(sl()));
        sl.registerLazySingleton(() => GetCategoryResponse(sl()));
        sl.registerLazySingleton(() => GetProductResponse(sl()));
        sl.registerLazySingleton(() => GetCategoryInfoResponse(sl()));
        sl.registerLazySingleton(() => GetAllProductsResponse(sl()));
        sl.registerLazySingleton(() => PostFavouriteProductById(sl()));
        sl.registerLazySingleton(() => GetFavourites(sl()));
        sl.registerLazySingleton(() => GetProfileData(sl()));
        sl.registerLazySingleton(() => PostOrDeleteCartItem(sl()));
        sl.registerLazySingleton(() => GetCart(sl()));
        sl.registerLazySingleton(() => GetOrders(sl()));
        sl.registerLazySingleton(() => PostOrder(sl()));
        sl.registerLazySingleton(() => GetAddresses(sl()));
        sl.registerLazySingleton(() => PostAddress(sl()));
        sl.registerLazySingleton(() => GetAutoComplete(sl()));
        sl.registerLazySingleton(() => GetAddressInfoById(sl()));
        sl.registerLazySingleton(() => GetLocationDetailsByLatAndLng(sl()));
        sl.registerLazySingleton(() => EstimateOrderCost(sl()));
        sl.registerLazySingleton(() => GetProductSearch(sl()));




        //repository
        sl.registerLazySingleton<BaseLoginRepository>(() => LogInRepository(sl()));
        sl.registerLazySingleton<BaseSignupRepository>(() => SignUpRepository(sl()));
        sl.registerLazySingleton<BaseCategoryRepository>(() => CategoryRepository(sl()));
        sl.registerLazySingleton<BaseProductRepository>(() => ProductRepository(sl()));
        sl.registerLazySingleton<BaseFavouriteRepository>(() => FavouriteRepository(sl()));
        sl.registerLazySingleton<BaseProfileRepository>(() => ProfileRepository(sl()));
        sl.registerLazySingleton<BaseCartRepository>(() => CartRepository(sl()));
        sl.registerLazySingleton<BaseOrderRepository>(() => OrderRepository(sl()));
        sl.registerLazySingleton<BaseAddressRepository>(() => AddressRepository(sl()));
      //data source
        sl.registerLazySingleton<BaseLoginRemoteDataSource>(() => LoginRemoteDataSource());
        sl.registerLazySingleton<BaseSignUpDataSource>(() => SignUpDataSource());
        sl.registerLazySingleton<BaseCategoriesDataSource>(() => CategoryDataSource());
        sl.registerLazySingleton<BaseProductDataSource>(() => ProductDataSource());
        sl.registerLazySingleton<BaseFavouriteDataSource>(() => FavouriteDataSource());
        sl.registerLazySingleton<BaseProfileDataSource>(() => ProfileDataSource());
        sl.registerLazySingleton<BaseCartDataSource>(() => CartDataSource());
        sl.registerLazySingleton<BaseOrdersDataSource>(() => OrdersDataSource());
        sl.registerLazySingleton<BaseAddressDatasource>(() => AddressDatasource());


  }
}