import Fastify from 'fastify';

const fastify = Fastify({
  logger: true // Activa logs automáticos en consola estilo profesional
});

fastify.get('/health', async () => {
  return { status: 'OK', service: 'Exclusive Host' };
});

const start = async () => {
  try {
    // Escuchamos en el puerto 3000 y en todas las interfaces de red (0.0.0.0)
    // Esto es CRÍTICO para que el celular Android pueda conectarse al notebook
    await fastify.listen({ port: 3000, host: '0.0.0.0' });
    console.log('Servidor Exclusive operativo en el puerto 3000');
  } catch (err) {
    fastify.log.error(err);
    process.exit(1);
  }
};

start();