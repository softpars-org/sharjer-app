import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:http_interceptor/http/http.dart';
import 'package:http_interceptor/models/request_data.dart';
import 'package:http_interceptor/models/response_data.dart';
import 'package:mojtama/exceptions/app_exceptions.dart';
import 'package:mojtama/services/app_services/connectivity_service.dart';

import 'app_services/snackbar_service.dart';

abstract class BaseService {
  final SnackbarService snackbarService;
  final box = Hive.box("auth");
  late InterceptedClient client;
  BaseService({
    required this.snackbarService,
  }) {
    client = InterceptedClient.build(interceptors: [
      HttpInterceptor(
        snackbarService: snackbarService,
      ),
    ]);
  }
}

class HttpInterceptor implements InterceptorContract {
  final SnackbarService snackbarService;
  final ConnectivityService connectivityService = ConnectivityService();
  HttpInterceptor({
    required this.snackbarService,
  });

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    if (!await connectivityService.checkInternetConnection()) {
      snackbarService.showSnackbar(message: "اینترنت شما فعال نیست");
      throw NoInternetException();
    }
    final accessToken = Hive.box("auth").get("access_token") ?? "";
    //data.headers['Authorization'] = accessToken;
    data.headers['Content-Type'] = "application/json";
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    try {
      final decodedBody = jsonDecode(data.body!);
      final isTokenAvailable = data.headers?['Authorization']?.isEmpty ?? false;
      if (isTokenAvailable &&
          data.statusCode == 401 &&
          decodedBody['detail'] ==
              "No active account found with the given credentials") {
        snackbarService.showSnackbar(message: "توکن شما منقضی شده است");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return data;
  }
}
