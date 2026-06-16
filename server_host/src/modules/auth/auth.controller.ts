import { FastifyReply, FastifyRequest } from 'fastify';
import { AuthService } from './auth.service.js';
import { z } from 'zod';

export class AuthController {
  private authService: AuthService;

  constructor(authService: AuthService) {
    this.authService = authService;
  }

  async googleLogin(request: FastifyRequest, reply: FastifyReply) {
    const googleAuthSchema = z.object({
      idToken: z.string().min(1, 'El idToken es requerido'),
    });

    try {
      const { idToken } = googleAuthSchema.parse(request.body);

      // Ahora el servicio debe devolver tanto el usuario como el token generado por nuestro servidor
      const { user, token } = await this.authService.verifyGoogleToken(idToken);

      return reply.code(200).send({
        message: 'Autenticación exitosa',
        token, // <--- Este es el token de Exclusive que Flutter guardará
        user: {
          id: user.id,
          email: user.email,
          username: user.username,
          avatarUrl: user.avatarUrl,
        },
      });
    } catch (error) {
      if (error instanceof z.ZodError) {
        return reply.code(400).send({ message: 'Datos inválidos', errors: error.errors });
      }
      
      // Es vital loguear el error real en consola para debuggear si Google falla
      request.log.error(error); 
      return reply.code(401).send({ message: 'Fallo en la autenticación con Google' });
    }
  }
  async pairDevice(request: FastifyRequest, reply: FastifyReply) {
    // 1. Esquema de validación para el handshake
    const pairSchema = z.object({
      otpCode: z.string().length(6, 'El código debe tener 6 dígitos'),
      deviceId: z.string().min(1, 'El deviceId es requerido'),
    });

    try {
      // 2. Validamos el input
      const { otpCode, deviceId } = pairSchema.parse(request.body);

      // 3. Llamamos al servicio (que aún debemos implementar en AuthService)
      const { token, message } = await this.authService.validatePairing(otpCode, deviceId);

      return reply.code(200).send({
        status: 'success',
        message,
        token, // Este es el token JWT que el flutter guardará en SecureStorage
      });
    } catch (error) {
      if (error instanceof z.ZodError) {
        return reply.code(400).send({ message: 'Datos de emparejamiento inválidos', errors: error.errors });
      }

      // Manejo de error de validación (ej: código incorrecto)
      request.log.error(error);
      return reply.code(401).send({ message: 'No se pudo vincular el dispositivo' });
    }
  }
}