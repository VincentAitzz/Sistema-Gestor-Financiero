abstract class AuthService {
  // 1. Validar con Google
  Future<String> authenticateWithGoogle();
  
  // 2. Handshake con el Host vía OTP
  Future<bool> pairWithHost(String otpCode);
  
  // 3. Logout estructural
  Future<void> logout();
}