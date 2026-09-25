# Guía de Restauración de la Base de Datos

Este documento explica paso a paso cómo restaurar la estructura y los datos iniciales de la base de datos PostgreSQL utilizando los archivos `estructura_bd.sql` e `Inserts.sql`.

La base de datos cuenta con una arquitectura segmentada en tres esquemas principales:
* **`auth`**: Gestión de usuarios y tipos de documento.
* **`catalogo`**: Información de medicamentos disponibles.
* **`transacciones`**: Registro y control de solicitudes de medicamentos.

---

## 🛠️ Prerrequisitos

Antes de comenzar, asegúrate de cumplir con lo siguiente:
* Tener instalado **PostgreSQL** (versión 13 o superior; el script fue generado en la versión 18.6).
* Tener acceso a la terminal de comandos de tu sistema o a **pgAdmin 4**.
* Contar con los archivos `estructura_bd.sql` e `Inserts.sql` en tu directorio local.

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

## 💻 Paso 2: Ejecutar el Script de Estructura

Una vez creada la base de datos limpia, importa la estructura mediante el método de tu preferencia:

### Opción 1: Desde la Terminal (Recomendado)
Abre la consola del sistema en la misma carpeta donde se encuentra tu archivo `.sql` y ejecuta:

```bash
psql -U tu_usuario -h localhost -p 5432 -d nuevaeps -f estructura_bd.sql
```

### Opción 2: Desde pgAdmin 4 (Query Tool)
1. En el panel izquierdo, despliega las bases de datos y selecciona **nuevaeps**.
2. En el menú superior o haciendo clic derecho, abre la herramienta **Query Tool**.
3. Carga tu archivo `estructura_bd.sql` y presiona la tecla **F5** (o haz clic en el botón **Play**).

---

## 📥 Paso 3: Cargar Datos Iniciales (Semillas / Seeds)

Para que el sistema funcione correctamente, es necesario poblar las tablas maestras con los tipos de documentos y medicamentos requeridos por la lógica de negocio. 

Ejecuta el archivo **`Inserts.sql`** (o copia y ejecuta el siguiente bloque SQL directamente en tu base de datos):

```sql
INSERT INTO auth.tipos_documento (codigo, descripcion) 
VALUES ('CC', 'Cédula de Ciudadanía'),
       ('CE', 'Cédula de Extranjería'),
       ('TI', 'Tarjeta de Identidad');
	   
INSERT INTO catalogo.medicamentos (nombre, presentacion, es_pos) VALUES
('Acetaminofén', 'Tabletas 500 mg', TRUE),
('Ibuprofeno', 'Tabletas 400 mg', TRUE),
('Losartán', 'Tabletas 500 mg', TRUE),
('Amoxicilina', 'Cápsulas 500 mg', TRUE),
('Metformina', 'Tabletas 850 mg', TRUE),
('Minoxidil', 'Solución tópica 5%', FALSE),
('Erlotinib', 'Tabletas 150 mg', FALSE),
('Infliximab', 'Solución inyectable 100 mg', FALSE),
('Acetaminofén + Hidrocodona', 'Tabletas 325 mg / 5 mg', FALSE),
('Suplemento Multivitamínico', 'Cápsulas', FALSE);
```

### Para ejecutarlo desde la terminal:
```bash
psql -U tu_usuario -h localhost -p 5432 -d nuevaeps -f Inserts.sql
```

---

## ✅ Paso 4: Verificar la Restauración

Para confirmar que los esquemas, las tablas y los datos se cargaron de forma correcta, puedes ejecutar la siguiente consulta:

```sql
SELECT table_schema, table_name, 
       (xpath('/row/cnt/text()', xmlget(xmlfoo, 'row')))[1]::text::int AS total_registros
FROM (
  SELECT table_schema, table_name, 
         query_to_xml(format('select count(*) as cnt from %I.%I', table_schema, table_name), false, true, '') as xmlfoo
  FROM information_schema.tables 
  WHERE table_schema IN ('auth', 'catalogo', 'transacciones')
) sub
ORDER BY table_schema;
```

**Resultado esperado:**
* `auth.tipos_documento`: 3 registros.
* `catalogo.medicamentos`: 10 registros.
* `auth.usuarios`: 0 registros.
* `transacciones.solicitudes`: 0 registros.
