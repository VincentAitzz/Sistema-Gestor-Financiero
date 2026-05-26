import { OAuth2Client } from 'google-auth-library';
import { FastifyInstance } from 'fastify';

// Sustituye esto con tu Client ID de Google Cloud Console más adelante
const CLIENT_ID = process.env.GOOGLE_CLIENT_ID;
const client = new OAuth2Client(CLIENT_ID);

export class AuthService {
    constructor(private fastify: FastifyInstance) { }

    async verifyGoogleToken(idToken: string) {
        try {
            const ticket = await client.verifyIdToken({
                idToken,
                audience: CLIENT_ID,
            });

            const payload = ticket.getPayload();
            if (!payload) throw new Error('Invalid Google payload');

            // Extraemos la información del usuario de Google
            const { sub: googleId, email, name, picture: avatarUrl } = payload;

            if (!email) throw new Error('Email not provided by Google');

            // Lógica de "Upsert": Si existe lo busca, si no, lo crea
            const user = await this.fastify.prisma.user.upsert({
                where: { email },
                update: {
                    googleId,
                    avatarUrl,
                },
                create: {
                    email,
                    googleId,
                    username: name,
                    avatarUrl,
                    authProvider: 'google',
                },
            });
            // Dentro de verifyGoogleToken, después de crear/actualizar el usuario:
            const sessionToken = this.fastify.jwt.sign({
                id: user.id,
                email: user.email
            }, { expiresIn: '7d' }); // Sesión de 7 días

            return { user, token: sessionToken };

        } catch (error) {
            this.fastify.log.error(error);
            throw new Error('Authentication failed');
        }
    }
}