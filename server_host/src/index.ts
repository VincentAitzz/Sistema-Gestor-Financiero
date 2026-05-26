import Fastify from 'fastify';
import prismaPlugin from './plugins/prisma.js';

const fastify = Fastify({ logger: true });

// Registramos el plugin de Prisma
fastify.register(prismaPlugin);

fastify.get('/health', async () => {
  // Verificamos si podemos contar los usuarios (prueba de conexión real)
  const userCount = await fastify.prisma.user.count();
  return { 
    status: 'OK', 
    service: 'Exclusive Host',
    db_connected: true,
    users_in_db: userCount
  };
});

const start = async () => {
  try {
    await fastify.listen({ port: 3000, host: '0.0.0.0' });
    console.log('Servidor Exclusive operativo en el puerto 3000');
  } catch (err) {
    fastify.log.error(err);
    process.exit(1);
  }
};

start();