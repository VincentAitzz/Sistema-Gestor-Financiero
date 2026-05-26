import Fastify from 'fastify';
import prismaPlugin from './shared/plugins/prisma.js';
import * as dotenv from 'dotenv';
import { authRoutes } from './modules/auth/auth.routes.js';
import cors from '@fastify/cors';

// Cargar variables de entorno antes de cualquier otra cosa
dotenv.config();

const fastify = Fastify({
  logger: {
    transport: {
      target: 'pino-pretty',
      options: {
        colorize: true,
        translateTime: 'HH:MM:ss Z',
        ignore: 'pid,hostname',
      },
    },
  },
});

// --- Registro de Plugins ---
// Registramos Prisma primero para que esté disponible en toda la app
await fastify.register(prismaPlugin);
await fastify.register(authRoutes, { prefix: '/auth' });
await fastify.register(cors, { 
  origin: true // Permite peticiones desde cualquier origen (emuladores/celulares)
});

// --- Rutas Base de Infraestructura ---
fastify.get('/health', async (request, reply) => {
  try {
    // Verificamos si la base de datos responde
    await fastify.prisma.$queryRaw`SELECT 1`;
    return { 
      status: 'ok', 
      database: 'connected',
      timestamp: new Date().toISOString() 
    };
  } catch (error) {
    reply.status(500).send({ 
      status: 'error', 
      database: 'disconnected',
      message: 'Fallo en la verificación de salud del motor de datos' 
    });
  }
});

// --- Punto de Entrada Principal ---
const start = async () => {
  try {
    const port = Number(process.env.PORT) || 3000;
    
    // IMPORTANTE: host '0.0.0.0' para evitar problemas de red en Windows/Emuladores
    await fastify.listen({ 
      port: port, 
      host: '0.0.0.0' 
    });

    console.log(`
    ==================================================
     EXCLUSIVE SERVER HOST - OPERATIVO
    ==================================================
    Local:        http://localhost:${port}
    Red Privada:  http://192.168.0.4:${port} (Ejemplo)
    Estado:       Estable (LTS Mode)
    ==================================================
    `);
  } catch (err) {
    fastify.log.error(err);
    process.exit(1);
  }
};

start();