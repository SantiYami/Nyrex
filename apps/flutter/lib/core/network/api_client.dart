// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami
library;

import 'package:dio/dio.dart';
import 'package:nyrex/core/constants/api_constants.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_client.g.dart';

class ApiClient {
  final Dio dio;

  ApiClient(this.dio);

  // Future helpers (get, post, delete) can be added here
}

@riverpod
Dio dioClient(Ref ref) {
  final options = BaseOptions(
    baseUrl: ApiConstants.baseUrl,
    connectTimeout: ApiConstants.connectTimeout,
    receiveTimeout: ApiConstants.receiveTimeout,
    contentType: 'application/json',
  );

  final dio = Dio(options);
  dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

  return dio;
}

@riverpod
ApiClient apiClient(Ref ref) {
  final dio = ref.watch(dioClientProvider);
  return ApiClient(dio);
}
