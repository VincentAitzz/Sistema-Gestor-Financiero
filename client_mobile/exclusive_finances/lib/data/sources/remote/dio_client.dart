import 'package:dio/dio.dart';
import 'package:exclusive_finances/data/sources/remote/discovery_service.dart';
import '../../../core/security/secure_storage_service.dart';

class DioClient {
  final Dio _dio = Dio();
  final SecureStorageService _storage;
  final NetworkDiscoveryService _discoveryService;

  DioClient(this._discoveryService) {
    _initialize();
  }
  Future<void> _initialize() async {
    final baseUrl = await _discoveryService.discoverHost();
    if (baseUrl != null) {
      _dio.options.baseUrl = baseUrl;
    }
  }

  Dio get dio => _dio;
}