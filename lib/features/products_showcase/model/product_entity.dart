import 'dart:convert';

import 'package:clean_framework/clean_framework.dart';

import 'products_response.dart';


class ProductEntity extends Entity {
   final ProductResponse data;


   ProductEntity({ProductResponse? d, List<EntityFailure> errors=const[]})
       :   data = d??ProductResponse() // or here
   {
   }


  @override
  List<Object> get props => [errors, data];

  @override
  ProductEntity merge({

    List<EntityFailure>? errors,
    ProductResponse? d,
  }) {


    return ProductEntity(
      errors: errors ?? this.errors,
      d: d,
    );
  }
}
