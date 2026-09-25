# Guía de Restauración de la Base de Datos

Este documento explica paso a paso cómo restaurar la estructura de la base de datos PostgreSQL utilizando el archivo `estructura_bd.sql`. 

La base de datos cuenta con una arquitectura segmentada en tres esquemas principales:
* **`auth`**: Gestión de usuarios y tipos de documento.
* **`catalogo`**: Información de medicamentos disponibles.
* **`transacciones`**: Registro y control de solicitudes de medicamentos.

---

## 🛠️ Prerrequisitos

Antes de comenzar, asegúrate de cumplir con lo siguiente:
* Tener instalado **PostgreSQL** (versión 13 o superior; el script fue generado en la versión 18.6).
* Tener acceso a la terminal de comandos de tu sistema o a **pgAdmin 4**.
* Contar con el archivo `estructura_bd.sql` en tu directorio local.

---

## 🚀 Paso 1: Crear la nueva Base de Datos

El script requiere una base de datos vacía. El nombre sugerido y preconfigurado para este proyecto es **`nuevaeps`**.

### Opción A: Desde la Terminal (psql)
Conéctate a tu servidor de PostgreSQL y ejecuta:
```sql
CREATE DATABASE nuevaeps;
```

### Opción B: Desde pgAdmin 4
1. Haz clic derecho sobre el nodo **Databases** en el panel izquierdo.
2. Selecciona **Create** > **Database...**
3. Asígnale el nombre `nuevaeps` y haz clic en **Save**.

> ⚠️ **¡Atención si cambias el nombre!**
> Si por alguna razón decides utilizar un nombre diferente a `nuevaeps`, es obligatorio que vayas a los archivos de configuración **`.yml`** de las siguientes APIs y actualices la propiedad de conexión a la base de datos:
> * **`api-auth`**
> * **`api-solicitudes`**

---

## 💻 Paso 2: Ejecutar el Script de Restauración

Una vez creada la base de datos limpia, importa la estructura mediante el método de tu preferencia:

### Opción 1: Desde la Terminal (Recomendado)
Abre la consola del sistema en la misma carpeta donde se encuentra tu archivo `.sql` y ejecuta:

```bash
psql -U tu_usuario -h localhost -p 5432 -d nuevaeps -f estructura_bd.sql
```

* **`-U tu_usuario`**: Tu usuario administrador de Postgres (ej. `postgres`).
* **`-d nuevaeps`**: El nombre de la base de datos que creaste en el Paso 1.
* **`-f estructura_bd.sql`**: El nombre exacto de tu archivo de script.

*(Nota: El sistema te solicitará la contraseña de tu usuario de PostgreSQL).*

### Opción 2: Desde pgAdmin 4 (Query Tool)
1. En el panel izquierdo, despliega la sección de bases de datos y selecciona **nuevaeps**.
2. En el menú superior o haciendo clic derecho, abre la herramienta **Query Tool**.
3. Haz clic en el icono de **Abrir archivo** (carpeta) en la barra de herramientas y carga tu archivo `estructura_bd.sql`.
4. Presiona la tecla **F5** o haz clic en el botón de **Ejecutar (Play)**.

---

## ✅ Paso 3: Verificar la Estructura Importada

Para confirmar que los esquemas y las tablas se crearon correctamente, puedes ejecutar la siguiente consulta en tu editor SQL para listar los objetos del sistema:

```sql
SELECT table_schema, table_name 
FROM information_schema.tables 
WHERE table_schema IN ('auth', 'catalogo', 'transacciones')
ORDER BY table_schema;
```

Deberías ver listadas las siguientes tablas:
* `auth.tipos_documento`
* `auth.usuarios`
* `catalogo.medicamentos`
* `transacciones.solicitudes`
