```typescript
/*
 * Copyright (c) 2026 Vicente Pavez (Aitzz)
 * Licensed under the MIT License.
 */
```
# Diagrama ER — Modelo de Base de Datos

Este archivo contiene un diagrama ER en formato Mermaid pensado para documentación profesional. Incluye las entidades principales, sus campos y relaciones.

## Notas

- Tipos mostrados son orientativos y siguen la nomenclatura definida en el modelo.
- `transactions.id` se genera en el dispositivo móvil.
- `updated_at` se usa para resolución de conflictos durante sincronización.

```mermaid
erDiagram
    USERS {
        UUID id PK
        VARCHAR email "Unique"
        VARCHAR username "Unique / Nullable"
        TEXT password_hash "Nullable"
        VARCHAR google_id "Unique / Nullable"
        VARCHAR auth_provider "local | google"
        TEXT avatar_url
        TIMESTAMP created_at
    }
    DEVICES {
        UUID id PK
        UUID user_id FK
        VARCHAR device_name
        TEXT token_hash
        TIMESTAMP last_sync
    }
    CATEGORIES {
        UUID id PK
        UUID user_id FK
        VARCHAR name
        TEXT icon_data
        VARCHAR color_hex
        BOOLEAN is_deleted
        TIMESTAMP updated_at
    }
    TRANSACTIONS {
        UUID id PK "Generado en dispositivo"
        UUID user_id FK
        UUID category_id FK
        DECIMAL amount
        TEXT description
        TIMESTAMP date
        BOOLEAN is_deleted
        TIMESTAMP updated_at
    }

    USERS ||--o{ DEVICES : "asocia"
    USERS ||--o{ CATEGORIES : "posee"
    USERS ||--o{ TRANSACTIONS : "registra"
    CATEGORIES ||--o{ TRANSACTIONS : "clasifica"
```

## Leyenda

- PK: Primary Key
- FK: Foreign Key
- Tipos: `UUID`, `VARCHAR`, `TEXT`, `DECIMAL`, `TIMESTAMP`, `BOOLEAN`

---
