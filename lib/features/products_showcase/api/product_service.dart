
import '../../../universal/graphql/graph_ql_service.dart';
import '../../../utilities/string_constatnts.dart';

import '../../home/fielSpinResponse.dart';
import 'product_quries.dart';

class ProductService extends GraphQlService< FileSpinResponse> {
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
  FileSpinResponse parseResponse(Map<String, dynamic> jsonResponse,bool hasError,String? errorMessage) {
    return FileSpinResponse.fromJson(jsonResponse);
  }
}
