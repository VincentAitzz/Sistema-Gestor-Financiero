import { FastifyInstance } from 'fastify';
import { AuthController } from './auth.controller.js';
import { AuthService } from './auth.service.js';

export async function authRoutes(fastify: FastifyInstance) {
  // Inyectamos las dependencias
  const authService = new AuthService(fastify);
  const authController = new AuthController(authService);

  // Definimos el endpoint de autenticación
  fastify.post('/google', (req, res) => authController.googleLogin(req, res));
  fastify.post('/pair', (req, res) => authController.pairDevice(req, res));
}