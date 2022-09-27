
import '../../../universal/graphql/graph_ql_service.dart';
import '../../../universal/graphql/graph_ql_service_adapter.dart';
import '../model/products_response.dart';

import '../api/product_service.dart';
import '../model/product_entity.dart';

class ProductAdapter extends ServiceAdapterGraphQl<ProductEntity,
   ProductResponse, ProductService> {
  final Map<String, String>? header;
  final String? token;
  final RequestType requestType;
  final String queryString;
  ProductAdapter(this.token,this.header, {required this.queryString,required this.requestType,}) : super(ProductService(type: requestType,token: token,header: header,query: queryString));

  @override
  ProductEntity createEntity(
      ProductEntity initialEntity, ProductResponse responseModel) {
    return initialEntity.merge(
      d: responseModel,
    );
  }
}
