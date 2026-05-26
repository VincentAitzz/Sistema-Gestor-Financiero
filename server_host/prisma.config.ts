import { defineConfig } from '@prisma/config';
import * as dotenv from 'dotenv';

dotenv.config();

export default defineConfig({
  datasource: {
    // Usamos el operador de aserción (!) porque sabemos que existe en el .env
    url: process.env.DATABASE_URL!,
  }
});