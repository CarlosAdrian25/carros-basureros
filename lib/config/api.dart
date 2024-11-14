// lib/config/api.dart

const String baseUrl = 'http://192.168.24.196:5000/api';

String getApiUrl(String endpoint) {
  return '$baseUrl$endpoint';
}
