<img src="img/Aitzz_logo.png" alt="Sello Personal" width="120" />
<br>

# Nomenclatura — Modelo de Base de Datos

## _Convenciones generales_

- Las tablas usan nombres en plural en `snake_case`.
- Los campos usan `snake_case`.
- `UUID` para claves primarias (generados en el cliente para evitar colisiones).
- Timestamps en UTC (`TIMESTAMP`).
- Borrado lógico mediante `is_deleted BOOLEAN` para persistencia de sincronización.
- `updated_at` se utiliza para resolución de conflictos (Last Write Wins).

## Tabla: users

| Campo | Tipo | Restricciones / Notas |
|---|---|---|
| id | UUID | Primary Key |
| email | VARCHAR(255) | Único / Obligatorio (Clave para vincular identidades) |
| username | VARCHAR(50) | Único / Nullable (Opcional si se usa Google) |
| password_hash | TEXT | Nullable (Vacío si el usuario solo usa Google) |
| google_id | VARCHAR(255) | Único / Nullable (ID proveído por Google) |
| auth_provider | VARCHAR(20) | Valores: local, google |
| avatar_url | TEXT | URL de la imagen de perfil de Google |
| created_at | TIMESTAMP | Fecha de registro |

## Tabla: devices

| Campo | Tipo | Restricciones / Notas |
|---|---|---|
| id | UUID | Primary Key |
| user_id | UUID | Foreign Key → `users(id)` |
| device_name | VARCHAR(100) | Identificador legible del hardware |
| token_hash | TEXT | Hash del token de vinculación |
| last_sync | TIMESTAMP | Última sincronización exitosa (UTC) |

## Tabla: categories

| Campo | Tipo | Restricciones / Notas |
|---|---|---|
| id | UUID | Primary Key |
| user_id | UUID | Foreign Key → `users(id)` |
| name | VARCHAR(50) | Nombre de la categoría |
| icon_data | TEXT | Identificador de asset/icono para Flutter |
| color_hex | VARCHAR(7) | Código hexadecimal del color |
| is_deleted | BOOLEAN | Soporte para borrado lógico |
| updated_at | TIMESTAMP | Marca para resolución de conflictos |

## Tabla: transactions

| Campo | Tipo | Restricciones / Notas |
|---|---|---|
| id | UUID | Primary Key (Generado en el cliente) |
| user_id | UUID | Foreign Key → `users(id)` |
| category_id | UUID | Foreign Key → `categories(id)` (Nullable) |
| amount | DECIMAL(12,2) | Precisión financiera fija |
| description | TEXT | Metadatos de la transacción |
| date | TIMESTAMP | Fecha efectiva del movimiento |
| is_deleted | BOOLEAN | Soporte para borrado lógico |
| updated_at | TIMESTAMP | Marca para resolución de conflictos |