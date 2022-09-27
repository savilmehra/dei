
import '../../../universal/graphql/graph_ql_service.dart';
import '../../../utilities/string_constatnts.dart';
import '../model/products_response.dart';
import 'product_quries.dart';

class ProductService extends GraphQlService< ProductResponse> {
  final RequestType type;
  final Map<String, String>? header;
  final String? token;
  final String query;
  ProductService({required this.type,this.header,this.token,required this.query})
      : super(
      baseUrl: '${DOMAIN_NAME_GQL}/graphql',
      header: header,
      token: token,
      query:query,
      requestType: type);

  @override
  ProductResponse parseResponse(Map<String, dynamic> jsonResponse,bool hasError,String? errorMessage) {
    return ProductResponse.fromJson(jsonResponse);
  }
}
