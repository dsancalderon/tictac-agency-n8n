# Google Slides — plantilla de datos y etiquetas para IA

## Presentaciones

- Plantilla productiva anterior y rollback:
  `16SvDTUUF9q7VspDWbX8Zr4YTU6QJi__L3oh5qvJYtq0`.
- Nueva plantilla productiva de 29 diapositivas, validada primero en privado:
  `1cPlo9OeUWpfW7H1ACnbwpT59MSR_yruErFkVhc7jHOo`.
- Informe privado validado el 13 de agosto de 2026:
  `1GAnmA_kJ0ebIlzOt3L3CcE_wx1OrFfqKsGgjScSxYuo`.

La plantilla productiva anterior permanece intacta como rollback. El generador
productivo fue actualizado el 13 de agosto de 2026 para usar la nueva plantilla.
La prueba final `2746` fue autorizada para un destinatario exacto, publicó el
informe como lector y completó el envío por WhatsApp.

## Contrato del informe

El Slides generado contiene únicamente:

- métricas reales y metas mensuales;
- tablas fuente visibles;
- etiquetas que indican a una IA posterior qué dashboard y análisis producir;
- zonas manuales para HubSpot y creativos.

No contiene dashboards automáticos, análisis redactados, cifras históricas,
consultas de creativos ni datos simulados de HubSpot.

Cada página analítica incluye una tabla y estas dos etiquetas:

- `DASHBOARD A GENERAR · FUENTE · CAMPAÑA/PROYECTO · TIPO · PERIODO`;
- `ANÁLISIS A GENERAR · FUENTE · CAMPAÑA/PROYECTO · CRITERIOS · PERIODO`.

## Distribución de las 29 diapositivas

- 1–2: portada, identidad, periodo, fecha de generación y fuentes.
- 3–4: resumen general y comparativo por campaña de Pekín.
- 5–7: Pekín Vivienda — diario, edad/género y plataforma.
- 8: creativos de Pekín Vivienda, inserción manual.
- 9–11: Pekín Inversionistas — diario, edad/género y plataforma.
- 12–13: creativos y campaña nueva, inserción manual.
- 14: reconocimiento/reproducción de video.
- 15–16: Google PMAX — actividad y meta frente a resultado.
- 17: dos zonas manuales de HubSpot.
- 18: resumen de Métriku y diario de Interacción.
- 19–20: resumen y comparativo por campaña de Skala.
- 21–23: Skala Vivienda — diario, edad/género y plataforma.
- 24: creativos de Skala Vivienda, inserción manual.
- 25–27: Skala Inversión — diario, edad/género y plataforma.
- 28: creativos de Skala Inversión, inserción manual.
- 29: cierre.

## Placeholders escalares

### Generales

- `{{NOMBRE_PROYECTO_MAYUS}}`
- `{{PERIODO_INFORME}}`
- `{{FECHA_GENERACION}}`
- `{{FUENTES_DATOS}}`

### Pekín

Se conservan los placeholders `META_RECONOCIMIENTO_*`,
`META_INVERSIONISTAS_*`, `META_VIVIENDA_*`,
`META_APARTAESTUDIO_*`, `GOOGLE_PMAX_*` y `TOTAL_*`.

### Skala y Métriku

El workflow admite los prefijos:

- `SKALA_INVERSION_*`, `SKALA_VIVIENDA_*`, `SKALA_FERIA_*`;
- `METRIKU_INTERACCION_*`, `METRIKU_PROPIETARIO_*`,
  `METRIKU_ARRENDATARIO_*`, `METRIKU_FERIA_*`;
- `SKALA_TOTAL_*` y `METRIKU_TOTAL_*`.

Para una campaña, los sufijos disponibles son `KPI`, `REAL`,
`PERFORMANCE`, `PRESUPUESTO`, `INVERSION` y `CPA`.

## Tablas fuente

`Preparar Batch Update` crea 20 tablas con IDs estables, además de completar
la tabla preexistente de la diapositiva 3:

- Pekín: `data_pekin_campaigns`, seis tablas de Vivienda/Inversionistas,
  `data_recognition_summary`, `data_pmax_activity` y `data_pmax_goal`.
- Métriku: `data_metriku_summary` y `data_metriku_daily`.
- Skala: `data_skala_total`, `data_skala_campaigns` y seis tablas de
  Vivienda/Inversión.

Las series diarias contienen fecha, resultado, inversión, impresiones y alcance.
Las series demográficas contienen edad, mujeres y hombres. Las series de
plataforma contienen plataforma y resultado.

## HubSpot y creativos

La diapositiva 17 conserva dos zonas manuales sin cifras automáticas:

1. etapa del ciclo de vida;
2. estado del contacto.

Las diapositivas 8, 12, 13, 24 y 28 quedan identificadas como zonas de inserción
manual. No se inventan datos a nivel de anuncio.

## Validación privada

La ejecución aislada `2744`:

- finalizó en `Reemplazar Placeholders en Slides`;
- no incluyó nodos de permisos, notificación ni WhatsApp;
- creó 20 tablas mediante 1.141 solicitudes de Slides;
- registró `dashboardChartCount = 0`;
- mantuvo `MONTH_TO_DATE`, `America/Bogota` y
  `MONTHLY_FULL_TARGET`;
- validó Skala en 150 = 70 + 50 + 30;
- dejó cero placeholders `{{...}}` y cero `sheetsChart`;
- concilió 129 filas y seis métricas escalares con `reportDataV1`;
- se revisó visualmente en las 29 miniaturas sin recortes ni solapamientos.

El informe continúa privado, con el propietario como único permiso. Los
workflows temporales usados para la prueba fueron desactivados y eliminados.

## Aceptación productiva

La ejecución productiva `2746` completó los 22 nodos hasta WhatsApp:

- informe: `1jUwCYjpmA6kgCRsDS58gWPSkYXUrPKwlv3DzcexWpJk`;
- permiso: `anyoneWithLink`, tipo `anyone`, rol `reader`, sin descubrimiento;
- WhatsApp: `6a7d73a4e3c0d81f9b263c81`, estado `accepted`;
- 20 tablas nuevas, 1.141 solicitudes y cero dashboards automáticos;
- 29 diapositivas auditadas por API y revisadas visualmente;
- cero placeholders residuales y meta Skala 150.

## Contrato para reemplazar tablas por dashboards

Antigravity debe trabajar sobre una copia del informe productivo aceptado. Cada
tabla visible es la fuente de verdad para el dashboard de esa diapositiva y no
un dato decorativo. Antes de ocultar o reemplazar una tabla debe comprobar:

- coincidencia exacta de categorías, series, valores, unidades y periodo;
- título y leyenda coherentes con la etiqueta `DASHBOARD A GENERAR`;
- análisis limitado a las métricas disponibles y a la etiqueta
  `ANÁLISIS A GENERAR`;
- ausencia de cifras inventadas en HubSpot, creativos o análisis de subasta;
- conservación del informe fuente sin modificaciones para auditoría.

La versión enriquecida debe mantener 29 diapositivas, la identidad gráfica y
la legibilidad a tamaño de presentación. El procedimiento completo está en
`../ANTIGRAVITY_HANDOFF.md`.
