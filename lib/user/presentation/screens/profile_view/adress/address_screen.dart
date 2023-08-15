import 'dart:ffi';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce_clean_arch/core/resources/values_manager/values_manger.dart';
import 'package:ecommerce_clean_arch/user/domain/entities/addresses/Adresses.dart';
import 'package:ecommerce_clean_arch/user/presentation/controller/address_cubit/address_cubit.dart';
import 'package:ecommerce_clean_arch/user/presentation/screens/profile_view/adress/add_address.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../core/resources/color_manger/color_manager.dart';
import '../../../../../core/resources/reusable_comp/reusable_comp.dart';
import '../../../../../core/services/service_locator.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key,});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddressCubit(sl(), sl(),sl(),sl(),sl())..geTAllAddresses(),
      child: BlocConsumer<AddressCubit, AddressState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          AddressCubit cubit = AddressCubit.get(context);
          return Scaffold(
            resizeToAvoidBottomInset: true,
            floatingActionButton: FloatingActionButton(
                backgroundColor: ColorManager.primary,
                onPressed: ()async{
                    bool refresh =await Navigator.push(context, MaterialPageRoute(builder: (_)=>const AddAddress()));
                    if(refresh == true){
                      cubit.geTAllAddresses();
                    }
                },
                child: Icon(Icons.add),
            ),
            
            appBar: AppBar(
                title: const Text('My Addresses'),
                leading: IconButton(onPressed: () async{
                  Navigator.pop(context,true);
                }, icon: Icon(Icons.arrow_back, color: ColorManager.primary,)),

            ),
            body: ConditionalBuilder(
              condition: state is! GetAddressInitial,
              builder: (BuildContext context) {
                if(cubit.addresses!.addresses.isNotEmpty ){
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: cubit.addresses?.addresses.length,
                    itemBuilder: (context,index)=>AddressCard(addresses: cubit.addresses!, index: index, ),);
                }
                else{
                  return Center(
                    child: Column(
                      children: [
                        Image.asset('assets/images/Delivery address.gif'),
                        const SizedBox(height: AppSize.s10,),
                        const Text('please add an address')
                      ],
                    ),
                  );
                }
              },
              fallback: (BuildContext context) {
                return Center(
                  child: CircularProgressIndicator(color: ColorManager.primary,),
                );
              },

            )
          );
        },
      ),
    );
  }
}

class AddressCard extends StatelessWidget {
  const AddressCard({
    super.key, required this.addresses, required this.index,
  });
  final Addresses addresses;
  final int index;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: Column(
          children: [

            Container(
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(AppSize.s30),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(AppPadding.p8),
                      child: Text(addresses.addresses[index]['name'],style: Theme.of(context).textTheme.bodyMedium,),
                    ),
                    const MySpacer(),
                    Text('G-Code :${addresses.addresses[index]['city']}',style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ColorManager.gray),),
                    Text('detailed Address :${addresses.addresses[index]['details']}',style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ColorManager.gray),),
                    const SizedBox(height: AppSize.s10,),
                    Text(addresses.addresses[index]['notes'] ?? '' ,style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ColorManager.gray),),




                  ],
                ),
              ),
            ),
          ],
      ),
    );
  }
}
