// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiStatus {
  static isRequestSuccessful(int statusCode) {
    return statusCode >= 200 && statusCode < 300;
  }

  static handleError(http.Response response) {
    switch (response.statusCode) {
      case 400:
        throw ('${jsonDecode(response.body)['detail'] ?? 'Unknown Error'}');

      case 401:
        throw 'Unauthorized request - ${jsonDecode(response.body)['errors']}';

      case 403:
        throw 'Forbidden Error - ${jsonDecode(response.body)['message']}';

      case 422:
        throw 'Unable to process - ${jsonDecode(response.body)['message']}';

      case 500:
        throw 'Our system just hit a snag, kindly try again as we keep looking into it';

      default:
        throw 'Our system just hit a snag, kindly try again as we keep looking into it';
    }
  }
}
