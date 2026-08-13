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

- [x] Pipeline Lead identificado: `Lead pipeline`.
- [x] Etapas visibles: `New`, `Attempting`, `Connected`, `Qualified` y
  `Disqualified`; todavía no equivalen por sí solas a las métricas del informe.
- [x] Propiedad que identifica el proyecto: contacto `proyecto`, valor interno
  `Pekín`.
- [x] Propiedad utilizada para MQL: contacto `lifecyclestage`, valor
  `marketingqualifiedlead`.
- [x] `No Nicho` no aplica: Nicolás confirmó que era una categoría inventada.
- [x] Pendientes, ventas y lead caliente no se automatizan en esta fase; se
  mostrarán mediante los dashboards manuales aprobados.
- [ ] Regla para contar contactos duplicados cuando HubSpot se automatice.
- [ ] Confirmar la fecha aplicable a cada dashboard cuando HubSpot se automatice.

Hallazgos que no deben convertirse en reglas sin confirmación:

- Lead `hs_lead_disqualification_reason = NOT_A_GOOD_FIT` es solo una posible
  aproximación a `No Nicho`.
- Contacto `hs_lead_status` casi no tiene registros y no representa el embudo.
- No asumir `Pendientes = New + Attempting`.
- No asumir `Ventas = lifecyclestage:customer`; confirmar si se usan Deals
  cerrados ganados.

Decisión vigente del 12 de agosto de 2026:

- [x] Nicolás confirmó que `No Nicho` era una categoría inventada.
- [x] El informe usará manualmente los dashboards de etapa del ciclo de vida y
  estado del contacto mientras no exista acceso para crear la Private App.
- [x] Filtro confirmado: `proyecto = Pekín`, propietario Sofia Prias
  (`hubspot_owner_id = 90633401`) y acumulado desde el día 1 hasta la generación.

## 2. Meta Ads

### Acceso

- [x] Acceso al Business Manager.
- [x] ID del Business Manager: `355936969704127`.
- [x] ID de la cuenta publicitaria: `act_302924541795503`.
- [x] Token de usuario de sistema almacenado en la credencial cifrada `Meta Ads - Kinku`.
- [x] Permiso `ads_read`.
- [x] Permiso para consultar insights y campañas.
- [x] Campañas de Proyecto Pekín confirmadas por ID.
- [x] Campañas de Skala identificadas y aprobadas para la futura integración.

### Definiciones

- [x] Vivienda: `120238960041500774`.
- [x] Inversionistas: `120238954925180774`.
- [x] Apartaestudio: `120247687053780774`.
- [x] Reconocimiento / interacción: `120249557003280774`.
- [x] Lead: acción `lead`; Reconocimiento: `post_engagement`.
- [x] Moneda `COP` y zona horaria `America/Bogota`.
- [x] Skala Inversión: `120248650813200774`.
- [x] Skala Vivienda: `120248651700020774`.
- [x] Skala Feria Gran Salón: `120249270128040774`.
- [x] Primero se conectará Sheets; luego las metas y presupuestos de Skala se
  tomarán de la hoja.
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
