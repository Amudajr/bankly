import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../services/api_service.dart';
import '../services/internet_utils.dart';
import 'api_response.dart';
import 'client_repository.dart';

class ApiClient {
  static Future<ApiResponse> initialisePostRequest({data, url, token}) async {
    if (await InternetUtils.checkConnectivity()) {
      try {
        debugPrint('$url');
        debugPrint('$data');
        var response = await ClientRepository.makePostRequest(
            apiUrl: url, token: token, data: data);
        debugPrint('${response.body}');
        if (ApiStatus.isRequestSuccessful(response.statusCode)) {
          var body = jsonDecode(response.body);
          return ApiResponse(isSuccessful: true, data: body);
        } else {
          return ApiResponse(
              isSuccessful: false, data: ApiStatus.handleError(response));
        }
      } catch (e) {
        return ApiResponse(isSuccessful: false, data: e.toString());
      }
    } else {
      return ApiResponse(
          isSuccessful: false, data: 'Check your internet connection');
    }
  }

  static Future<ApiResponse> initialiseDeleteRequest({data, url, token}) async {
    if (await InternetUtils.checkConnectivity()) {
      try {
        // debugPrint('$url');
        debugPrint('$data');
        var response =
            await ClientRepository.makeDeleteRequest(apiUrl: url, token: token);
        debugPrint('${response.body}');
        if (ApiStatus.isRequestSuccessful(response.statusCode)) {
          var body = jsonDecode(response.body);
          return ApiResponse(isSuccessful: true, data: body);
        } else {
          return ApiResponse(
              isSuccessful: false, data: ApiStatus.handleError(response));
        }
      } catch (e) {
        return ApiResponse(isSuccessful: false, data: e.toString());
      }
    } else {
      return ApiResponse(
          isSuccessful: false, data: 'Check your internet connection');
    }
  }

  static Future<ApiResponse> initialiseGetRequest({data, url, token}) async {
    if (await InternetUtils.checkConnectivity()) {
      try {
        debugPrint('$url');
        var response =
            await ClientRepository.makeGetRequest(apiUrl: url, token: token);
        if (ApiStatus.isRequestSuccessful(response.statusCode)) {
          var body = jsonDecode(response.body);
          debugPrint('${response.body}');
          return ApiResponse(isSuccessful: true, data: body);
        } else {
          return ApiResponse(
              isSuccessful: false, data: ApiStatus.handleError(response));
        }
      } catch (e) {
        return ApiResponse(isSuccessful: false, data: e.toString());
      }
    } else {
      return ApiResponse(
          isSuccessful: false, data: 'Check your internet connection');
    }
  }

  static Future<ApiResponse> initialisePutRequest({data, url, token}) async {
    if (await InternetUtils.checkConnectivity()) {
      try {
        debugPrint('$url');
        debugPrint('$data');
        var response = await ClientRepository.makePutRequest(
            apiUrl: url, data: data, token: token);
        debugPrint('${response.body}');
        if (ApiStatus.isRequestSuccessful(response.statusCode)) {
          var body = jsonDecode(response.body);
          return ApiResponse(isSuccessful: true, data: body);
        } else {
          return ApiResponse(
              isSuccessful: false, data: ApiStatus.handleError(response));
        }
      } catch (e) {
        return ApiResponse(isSuccessful: false, data: e.toString());
      }
    } else {
      return ApiResponse(
          isSuccessful: false, data: 'Check your internet connection');
    }
  }
}
