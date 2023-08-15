import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce_clean_arch/user/presentation/controller/address_cubit/address_cubit.dart';
import 'package:ecommerce_clean_arch/user/presentation/screens/profile_view/adress/address_screen.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../core/resources/color_manger/color_manager.dart';
import '../../../../../core/resources/reusable_comp/reusable_comp.dart';
import '../../../../../core/resources/values_manager/values_manger.dart';
import '../../../../../core/services/service_locator.dart';

class AddAddress extends StatelessWidget {
  const AddAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddressCubit(sl(), sl(),sl(),sl(),sl())..getCurrentLocation(),
      child: BlocConsumer<AddressCubit, AddressState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          AddressCubit cubit = AddressCubit.get(context);
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              leading: IconButton(onPressed: (){
                Navigator.pop(context,true);
              }, icon: Icon(Icons.arrow_back,color: ColorManager.white,),splashColor: Colors.transparent,),
              backgroundColor: Colors.transparent,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent
              ),
            ),
            resizeToAvoidBottomInset: false,
            body: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius:  const BorderRadius.vertical(top: Radius.circular(AppSize.s20)),
              ),
              child: Column(
                children: [

                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          GoogleMap(
                            myLocationButtonEnabled: true,
                            gestureRecognizers: Set()..add(Factory<EagerGestureRecognizer>(() => EagerGestureRecognizer())),
                            markers: const {},
                            onCameraMove: (position){
                              cubit.moveMarker(position.target);
                              print(position.target);
                            },

                            mapType: MapType.hybrid,
                            initialCameraPosition: cubit.initialPosition,
                            onMapCreated: (GoogleMapController controller) {
                              cubit.controllerMap.complete(controller);
                            },),
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Padding(
                              padding: const EdgeInsets.all(60.0),
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [

                                    const SizedBox(
                                      height: AppSize.s16,
                                    ),
                                    mySearchTextFormField(context: context,textInputType: TextInputType.text ,controller: cubit.searchTextEditingController, label: 'search for location', obscure: false, enableSuggestions: true, autoCorrect: false,
                                        onChanged: (value){
                                      cubit.loadAutoComplete(value);
                                        },
                                        validate: (value){
                                      if(value.isEmpty){
                                        return 'please location name';
                                      }
                                    }),
                                    BlocBuilder<AddressCubit, AddressState>(
                                      builder: (context, state) {
                                         if(state is GetAutoCompleteInitial){
                                           return  Center(child: Center(child: CircularProgressIndicator(color: ColorManager.primary,)));
                                         } else if(state is GetAutoCompleteSuccess){
                                           return Container(
                                             margin: const EdgeInsets.all(AppSize.s8),
                                             height: MediaQuery.of(context).size.height/3,
                                             color: state.placeAutoComplete.predictions.isNotEmpty ?Colors.black.withOpacity(0.6):Colors.transparent,
                                             child: ListView.builder(
                                                 itemCount: state.placeAutoComplete.predictions.length,
                                                 itemBuilder: (context,index){
                                                   return GestureDetector(
                                                     onTap: (){
                                                       cubit.userGetAddressInfoByIdU(state.placeAutoComplete.predictions[index]['place_id']);
                                                     },
                                                     child: ListTile(
                                                       title: Text(state.placeAutoComplete.predictions[index]['description'],style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ColorManager.white),),
                                                     ),
                                                   );
                                                 }),
                                           );
                                         }
                                         else {
                                           return Text('',style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ColorManager.white),);
                                         }

                                         },
                                    )

                                  ]
                              ),
                            ),
                          ),
                           Align(
                            alignment: Alignment.center,
                            child: CircleAvatar(
                              radius: MediaQuery.of(context).size.width/34,
                              backgroundColor: ColorManager.white,
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: CircleAvatar(
                                  radius: MediaQuery.of(context).size.width/35,
                                  backgroundColor: ColorManager.primary,
                                ),
                              ),
                            )
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ConditionalBuilder(
                                  condition: State is! GetLocationDetailsByLatInitial,
                                  builder:(_)=> buildMyButton(context, 'save this location', (){
                                    cubit.getLocationDetailsByLat(cubit.currentPosition);
                                    showModalBottomSheet(context: context,isScrollControlled: true,
                                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(AppSize.s30)))
                                        ,builder: (_){
                                          return Padding(
                                            padding:  EdgeInsets.only(
                                                bottom: MediaQuery.of(context).viewInsets.bottom),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Center(
                                                    child: Form(
                                                      key: cubit.formKey,
                                                      child: Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          const SizedBox(height: AppSize.s20,),
                                                          myTextFormField(context: context,textInputType: TextInputType.text ,controller: cubit.nameTextEditingController, label: 'location name', obscure: false, enableSuggestions: true, autoCorrect: false,
                                                              validate: (value){
                                                                if(value.isEmpty){
                                                                  return 'please location name';
                                                                }
                                                              }),
                                                          const SizedBox(height: AppSize.s20,),
                                                          myTextFormField(context: context,textInputType: TextInputType.text ,controller: cubit.notesTextEditingController, label: 'notes', obscure: false, enableSuggestions: true, autoCorrect: false,
                                                          ),
                                                          const SizedBox(height: AppSize.s20,),
                                                          Row(
                                                            children: [
                                                              buildMyButton(context, 'Cancel', () {Navigator.pop(context); }),
                                                              const Spacer(),
                                                              ConditionalBuilder(
                                                                condition: state is! PostAddressInitial,
                                                                builder:(_)=>buildMyButton(context,'Add Address',(){
                                                                  if(cubit.formKey.currentState!.validate()){
                                                                    cubit.addAddressFinal();
                                                                    Navigator.pop(context);
                                                                  }
                                                                }) ,
                                                                fallback:  (BuildContext context) {
                                                                  return Center(child: CircularProgressIndicator(color: ColorManager.primary,),);
                                                                },
                                                              ),
                                                            ],
                                                          )

                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        });

                                  }),
                                  fallback: (BuildContext context) {
                                    return Center(child: CircularProgressIndicator(color: ColorManager.primary,),);
                                  })
                            )
                            ,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),),
          );
        },
      ),
    );
  }
}
