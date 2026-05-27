class ApiConstants {
  // Cambia esta IP por la IP local de tu PC (usa ipconfig en CMD)
  static const String baseUrl = 'http://172.31.96.1:3000'; 
  
  // Endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String googleLogin = '/auth/google';
  static const String transactions = '/transactions';

  // Tiempos de espera
  static const int connectTimeout = 5000;
  static const int receiveTimeout = 3000;
}