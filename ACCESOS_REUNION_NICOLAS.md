# Accesos y definiciones para completar el generador de informes

## 1. HubSpot

### Acceso

- [ ] Crear una Private App para la automatización.
- [ ] Entregar el access token por un canal seguro.
- [ ] Confirmar el Portal / Account ID.
- [ ] Autorizar lectura de contactos.
- [ ] Autorizar lectura de empresas.
- [ ] Autorizar lectura de negocios, si las ventas están en Deals.
- [ ] Autorizar lectura de propietarios.
- [ ] Autorizar lectura de esquemas y propiedades personalizadas.

No se requieren permisos de escritura durante la primera fase.

### Definiciones

- [ ] ID del pipeline utilizado.
- [ ] IDs y significado de las etapas.
- [ ] Propiedad que identifica el proyecto o cliente.
- [ ] Propiedad utilizada para MQL.
- [ ] Propiedad utilizada para No Nicho.
- [ ] Propiedad utilizada para Pendiente de clasificar.
- [ ] Propiedad utilizada para Venta.
- [ ] Propiedad o criterio de lead caliente.
- [ ] Regla para contar leads duplicados.
- [ ] Fecha utilizada para incluir un registro en el informe.

## 2. Meta Ads

### Acceso

- [x] Acceso al Business Manager.
- [x] ID del Business Manager: `355936969704127`.
- [x] ID de la cuenta publicitaria: `act_302924541795503`.
- [x] Token de usuario de sistema almacenado en la credencial cifrada `Meta Ads - Kinku`.
- [x] Permiso `ads_read`.
- [x] Permiso para consultar insights y campañas.
- [x] Campañas de Proyecto Pekín confirmadas por ID.

### Definiciones

- [x] Vivienda: `120238960041500774`.
- [x] Inversionistas: `120238954925180774`.
- [x] Apartaestudio: `120247687053780774`.
- [x] Reconocimiento / interacción: `120249557003280774`.
- [x] Lead: acción `lead`; Reconocimiento: `post_engagement`.
- [x] Moneda `COP` y zona horaria `America/Bogota`.
- [ ] Desgloses requeridos: fecha, edad, género, plataforma y ubicación.

## 3. Google Ads

### Acceso

- [x] Customer ID: `924-069-6515`.
- [x] Login Customer ID / MCC: `658-489-2239`.
- [x] Developer Token instalado dentro de la credencial cifrada.
- [x] OAuth conectado a una cuenta con acceso.
- [x] Campaña PMAX de Proyecto Pekín confirmada.

### Definiciones

- [x] PMAX incluida: `23823733646`.
- [x] Conversión principal validada: formulario de clientes potenciales.
- [x] Inversión, impresiones, interacciones, conversiones y costo por conversión.
- [ ] Datos de subasta requeridos.
- [x] Zona horaria y moneda validadas en la cuenta.

## 4. Google Sheets y archivos operativos

- [ ] Enlace de la hoja de metas.
- [ ] Compartir la hoja con permiso de lectura al usuario OAuth de n8n.
- [ ] Nombre de cada pestaña relevante.
- [ ] Columnas que contienen cliente, periodo, meta e inversión.
- [ ] Enlace de la carpeta de destino de informes.
- [ ] Permiso de edición sobre la carpeta de destino.
- [ ] Correo de las personas que deben poder abrir los informes.
- [ ] Ejemplos de capturas o gráficos que se actualizan en cada corte acumulado.

## 5. IA estratégica

- [x] Gemini definido.
- [x] API key guardada en la credencial cifrada `Gemini API - Tic Tac`.
- [ ] Cuenta responsable de consumo y facturación.
- [x] Modelo autorizado: `gemini-3.5-flash`.
- [ ] Límite mensual de uso.
- [ ] Ejemplos de redacción aprobada por Nicolás.
- [ ] Palabras, afirmaciones o recomendaciones que deben evitarse.

## 6. Reglas del informe

- [ ] Día y hora de la revisión operativa cada siete días.
- [x] Zona horaria oficial: `America/Bogota`.
- [x] Periodo exacto: desde el día 1 del mes hasta la fecha y hora de generación.
- [x] Cliente inicial y aliases configurados para Proyecto Pekín/Kinku.
- [ ] Metas por cliente y campaña.
- [ ] Convención del nombre del archivo.
- [ ] Carpeta de destino por cliente.
- [x] Entrega como enlace de Google Slides con permiso de lector.
- [x] Destinatarios autorizados por WhatsApp configurados.
- [ ] Tratamiento cuando falten datos.
- [ ] Persona que aprueba el informe antes de enviarlo al cliente.

## 7. Seguridad

- [x] No compartir contraseñas personales.
- [x] Usar OAuth, Private Apps, usuarios de sistema o tokens revocables.
- [x] Aplicar permisos mínimos de lectura.
- [ ] Definir responsable de rotar tokens.
- [x] Guardar secretos únicamente en credenciales de n8n o variables de Render.
- [x] No subir secretos al repositorio.
