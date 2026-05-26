import fp from 'fastify-plugin';
import { FastifyPluginAsync } from 'fastify';
import { PrismaClient } from '@prisma/client';

declare module 'fastify' {
  interface FastifyInstance {
    prisma: PrismaClient;
  }
}

const prismaPlugin: FastifyPluginAsync = fp(async (server) => {
  // Prisma 6 lee automáticamente el .env
  const prisma = new PrismaClient();

  try {
    await prisma.$connect();
    server.log.info('Prisma: Conexión establecida (Versión Estable 6.4.1)');
    server.decorate('prisma', prisma);
  } catch (err) {
    server.log.error({ err }, 'Error al conectar con PostgreSQL');
    process.exit(1);
  }

  server.addHook('onClose', async (instance) => {
    await instance.prisma.$disconnect();
  });
});

export default prismaPlugin;