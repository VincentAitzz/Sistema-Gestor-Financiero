```typescript
/*
 * Copyright (c) 2026 Vicente Pavez (Aitzz)
 * Licensed under the MIT License.
 */
```
# Especificaciones Técnicas del Sistema

## Gestión del Host (Desktop Manager)

Para garantizar una experiencia de usuario fluida en Windows, la administración del host se realiza mediante una interfaz de escritorio nativa que interactúa con el motor de Docker:

1. **Ciclo de Vida:** La aplicación se inicia junto con el sistema operativo, alojándose en la bandeja de sistema (System Tray). Desde este menú, el usuario puede iniciar o detener los servicios de base de datos de manera intuitiva.
2. **Orquestación Silenciosa:** El software utiliza comandos desacoplados para gestionar los contenedores, evitando la apertura de terminales de comandos visibles para el usuario.
3. **Monitoreo de Recursos:** La aplicación de escritorio muestra el estado de salud de los servicios y el consumo de recursos en tiempo real.

## Protocolo de Instalación

El proyecto incluye un script de despliegue inicial que automatiza las siguientes tareas:
* Verificación de prerrequisitos (Docker Engine).
* Construcción de imágenes locales mediante Docker Build.
* Configuración de variables de entorno seguras (.env).
* Registro de la aplicación en el inicio de Windows.

## Definiciones Técnicas

* **Offline-First:** Estrategia de diseño donde la aplicación es plenamente funcional sin conexión a internet, tratando la sincronización como un proceso asíncrono posterior.
* **ACID (Atomicity, Consistency, Isolation, Durability):** Conjunto de propiedades que garantizan que las transacciones en la base de datos se procesen de manera fiable.
* **Docker Container:** Unidad de software estándar que empaqueta el código y todas sus dependencias para que la aplicación se ejecute de forma rápida y confiable en cualquier entorno.
* **mDNS (Multicast DNS):** Protocolo que utiliza paquetes UDP para resolver nombres de host en direcciones IP dentro de redes locales sin un servidor DNS dedicado.