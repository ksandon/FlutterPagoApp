import 'dart:io';
import 'package:flutter_pago_app/model/niubiz_query_response.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_pago_app/constants.dart' as Constants;

class ApiRepository {
  Future<String> getToken() async {
    // Z2lhbmNhZ2FsbGFyZG9AZ21haWwuY29tOkF2MyR0cnV6 => convert user and pass to base64
    final response = await http.get(
      '${Constants.NIUBIZ_ENDPOINT_BASE}${Constants.NIUBIZ_ENDPOINT_SECURITY}',
      headers: {
        HttpHeaders.authorizationHeader: "Basic Z2lhbmNhZ2FsbGFyZG9AZ21haWwuY29tOkF2MyR0cnV6"
      }
    );
    return response.body;
  }

  Future<NiubizQueryResponse> getPurchaseInformation(String token, String purchase) async {
    final response = await http.get(
      '${Constants.NIUBIZ_ENDPOINT_BASE}${Constants.NIUBIZ_ENDPOINT_QUERY}${Constants.NIUBIZ_MERCHANT_ID}/$purchase',
      headers: {
        HttpHeaders.authorizationHeader: token
      },
    );
    return niubizQueryResponseFromJson(response.body);
  }

}