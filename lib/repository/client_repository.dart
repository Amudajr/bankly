// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ClientRepository {
  static makePostRequest({apiUrl, data, token}) async {
    final uri = Uri.parse(apiUrl);
    final jsonString = json.encode(data);

    if (token == null) {
      var headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
      };
      return await http.post(uri, body: jsonString, headers: headers);
    } else {
      var headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      };
      if (data == null) {
        return await http.post(uri, headers: headers);
      } else {
        return await http.post(uri, body: jsonString, headers: headers);
      }
    }
  }

  static makeDeleteRequest({apiUrl, token}) async {
    // print(apiUrl);

    final uri = Uri.parse(apiUrl);

    if (token == null) {
      var headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
      };
      return await http.delete(uri, headers: headers);
    } else {
      var headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      };
      return await http.delete(uri, headers: headers);
    }
  }

  static makePutRequest({apiUrl, data, token}) async {
    // print(apiUrl);
    final uri = Uri.parse(apiUrl);
    final jsonString = json.encode(data);
    var headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };
    if (token == null) {
      return await http.put(
        uri,
        body: jsonString,
      );
    } else {
      return await http.put(uri, body: jsonString, headers: headers);
    }
  }

  static makeGetRequest({apiUrl, token}) async {
    // print(apiUrl);

    var uri = Uri.parse(apiUrl);
    var headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };
    if (token == null) {
      return await http.get(uri);
    } else {
      return await http.get(uri, headers: headers);
    }
  }
}
