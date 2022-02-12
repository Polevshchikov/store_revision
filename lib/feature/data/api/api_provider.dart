// import 'dart:developer';

// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';


// import 'api_client.dart';

// @singleton
// class ApiProvider {
//   final ServerSettings _serverSettings;
//   final SecurityTokenHandler _tokenHandler;

//   ApiProvider(
//     this._tokenHandler,
//     this._serverSettings,
//   );

//   Future<ApiService> getApiClientInterface({
//     bool useToken = false,
//     bool content = false,
//     bool addApiPrefix = true,
//     bool addDouMonitorPrefix = false,
//   }) async {
//     final serverType = _serverSettings.getServerType();
//     final dio = Dio();
//     dio.interceptors.add(
//       InterceptorsWrapper(onRequest: (RequestOptions options) async {
//         final headers = <String, dynamic>{};
//         //if (content) headers.putIfAbsent('Content-Type', () => 'application/json;  charset=utf-8');
//         if (useToken) {
//           final token = await _tokenHandler.getToken();
//           headers.putIfAbsent(
//               'Authorization',
//               () =>
//                   '${toBeginningOfSentenceCase(token.tokenType)} ${token.accessToken}');
//         }
//         options.headers.addAll(headers);
//         return options;
//       }, onError: (error) {
//         if (error.response?.statusCode == 401 ||
//             error.error is TokenInvalidException) {
//           _authWrapperBloc.add(LogoutEvent());
//           // throw TokenInvalidException();
//         }
//       }),
//     );
//     if (!kReleaseMode) {
//       // dio.interceptors.add(LogInterceptor(
//       //   request: true,
//       //   requestHeader: true,
//       //   responseHeader: true,
//       //   requestBody: true,
//       //   responseBody: true,
//       //   logPrint: logPrint,
//       // ));
//     }
//     return ApiService(dio,
//         baseUrl: serverType.url +
//             (addDouMonitorPrefix ? 'dou-monitor/' : '') +
//             (addApiPrefix ? 'api/' : ''));
//   }

//   // for printing full logs into console
//   static void logPrint(Object object) async {
//     log(object.toString());
//   }
// }
