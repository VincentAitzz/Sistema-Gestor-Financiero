FROM node:20-alpine

WORKDIR /app

# Copiamos archivos de configuración de dependencias
COPY package*.json ./

# Instalamos las librerías directamente en el entorno Linux del contenedor
RUN npm install

# Copiamos el resto del código fuente
COPY . .

EXPOSE 3000

CMD ["npm", "run", "dev"]