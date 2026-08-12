# Configuración base de informes

## Workflows

1. Importar `tictac-router-informes.json`.
2. Importar `tictac-generador-informe-base.json`.
3. Abrir `gateway-whatsapp.json` en n8n y, en **Ejecutar Router de Informes**, seleccionar el workflow importado **Tic Tac - Router de Informes**.
4. En **Tic Tac - Router de Informes**, comprobar que **Ejecutar Generador en Segundo Plano** apunta a **Tic Tac - Generador Base de Informe**.
5. Mantener ese nodo con `Wait for Sub-Workflow Completion = false` y enviar:
   - `customerPhone`
   - `clientId`
   - `clientName`

Los IDs internos de workflows los asigna cada instancia de n8n al importarlos, por eso estas dos selecciones se realizan desde la interfaz.

## Datos ya configurados

- Usuarios autorizados: Nicolás, `+573222046768`, y número temporal de pruebas, `+573027697381`.
- Cliente inicial: `CLI-001`, Proyecto Pekín.
- Alias: `Proyecto Pekín`, `Proyecto Kinku`, `Pekín`, `Kinku` y `1`.
- Los textos se comparan sin distinguir mayúsculas ni tildes.

## Estado de las integraciones

El generador combina fuentes reales y simuladas. Cada salida conserva el campo
`dataSources` para que el informe identifique el origen de los datos:

| Flujo o nodo | Estado |
| --- | --- |
| Cargar Configuración Temporal | Google Sheets / tabla maestra |
| Recolectar Datos Simulados | Conserva configuración temporal y CRM simulado |
| Consultar Insights Meta Kinku → Consultar Presupuestos Meta Kinku → Incorporar Meta Ads Real | Producción: Meta Ads real para Reconocimiento, Inversionistas, Vivienda y Apartaestudios |
| Consultar Google Ads Kinku → Incorporar Google Ads Real | Producción: Google Ads real para la PMAX de Kinku |
| Preparar Solicitud Gemini → Generar Analisis con Gemini → Validar Analisis Gemini | Configurado con Gemini 3.5 Flash, salida JSON validada y hasta 3 intentos ante fallos temporales |
| Copiar y completar Google Slides | Configurado con la credencial `Google Drive account`; usa el conjunto mixto de datos |
| Preparar Notificación Final | Configurado para enviar por YCloud/WhatsApp |

## Variables pendientes

- ID de empresa o filtros de HubSpot.
- ID de carpeta de Google Drive.
- Metas mensuales o metas del periodo acumulado.
- Credencial de HubSpot en n8n.

## Contrato temporal compartido

Todos los conectores del informe deben aplicar el mismo contrato temporal:

- modo: `MONTH_TO_DATE`;
- cadencia operativa: un corte cada 7 días, solicitado bajo demanda al bot;
- inicio: día 1 del mes a las 00:00 en `America/Bogota`;
- fin: fecha y hora exactas en que se genera el informe;
- estrategia: `SOURCE_REQUERY_NO_ROLLUP`.

Cada corte vuelve a consultar las fuentes desde el día 1. No suma el informe
anterior ni conserva una ventana móvil de siete días. El cambio de mes reinicia
automáticamente el periodo. Los campos canónicos son `periodStartDate`,
`periodEndDate`, `periodStart`, `periodEnd`, `periodDaysElapsed`, `periodLabel` y
`reportingContract`.

Este contrato es obligatorio para Google Ads y para las próximas integraciones
de Meta Ads, HubSpot y Excel/Google Sheets. La cadencia de siete días indica
cuándo revisar; no modifica los límites del periodo consultado.

## Google Ads: Kinku

- Cuenta administradora: `658-489-2239`.
- Cuenta cliente: `924-069-6515`.
- Campaña: `23823733646`, `TIC TAC| CAMPAÑA PMAX| KINKU`.
- Credencial cifrada en n8n: `Google Ads - Tic Tac` (`googleAdsOAuth2Api`).
- Rango del nodo: `THIS_MONTH`, equivalente al acumulado del mes en curso.
- Solo se consultan campañas habilitadas y el nodo de normalización selecciona la campaña por ID.
- El costo, presupuesto y CPA se convierten de micros a COP.
- El presupuesto del periodo se calcula como presupuesto diario por
  `periodDaysElapsed`.
- Los resultados de `metrics.conversions` se usan como leads del objetivo principal. Para la validación inicial, las 29 conversiones coincidieron con el objetivo visible en Google Ads **Enviar formulario de clientes potenciales**.
- El objeto `pmax` alimenta los placeholders de Slides y el objeto `googleAds` conserva el detalle técnico para auditoría.

La especificación completa, el mapeo de campos, el procedimiento de prueba y el
rollback están en `GOOGLE_ADS_INTEGRATION.md`.

## Configuración de Gemini

1. En Google AI Studio, crear una API key para Gemini desde una cuenta autorizada.
2. No pegar la clave en el workflow, en Git ni en este documento.
3. En n8n, crear una credencial Header Auth llamada `Gemini API - Tic Tac` con encabezado `x-goog-api-key`.
4. Importar o actualizar `tictac-generador-informe-base.json` y seleccionar esa credencial en el nodo de Gemini.
6. Ejecutar una prueba controlada y revisar los nodos:
   - `Preparar Solicitud Gemini`
   - `Generar Analisis con Gemini`
   - `Validar Analisis Gemini`
7. Confirmar que la salida contiene `aiSource: gemini-3.5-flash` y los tres textos de `strategicCopy`.

El workflow usa una credencial cifrada para el encabezado `x-goog-api-key`, respuesta JSON estructurada y validación obligatoria antes de crear la presentación. Google Ads y Meta Ads usan datos reales; CRM continúa simulado.

## Prueba real de Google Slides

- Plantilla nativa configurada: `16SvDTUUF9q7VspDWbX8Zr4YTU6QJi__L3oh5qvJYtq0`.
- Credencial de n8n configurada por ID interno; el Client Secret no se guarda en este repositorio.
- El envío final usa la credencial cifrada de n8n `YCloud API - Tic Tac`; la API key no queda escrita dentro del workflow.
- Cada solicitud crea una copia nueva en Mi unidad, ejecuta 40 solicitudes de
  reemplazo y envía el enlace al mismo número de WhatsApp que pidió el informe.
- Las diapositivas 15 y 16 usan texto dinámico de Google Ads; la plantilla no
  conserva capturas históricas con métricas que puedan contradecir el periodo.
- Cada copia recibe el permiso `cualquier persona con el enlace: lector`, sin permitir edición ni aparecer en búsquedas públicas.
- Mientras no exista una carpeta final compartida, las copias quedan en la raíz de Mi unidad de la cuenta conectada.
- Después del mensaje de confirmación, Meta muestra el indicador de escritura durante el procesamiento; se apaga con la respuesta final o a los 25 segundos.
- La notificación final declara explícitamente: `Google Ads y Meta Ads: datos reales. CRM: datos simulados.`

La aceptación definitiva del 12 de agosto de 2026 corresponde a la ejecución
`2681`: 16 nodos exitosos, 47 ocurrencias reemplazadas, ningún placeholder
residual y WhatsApp aceptado. El informe validado es:
`https://docs.google.com/presentation/d/1BZz_ZsYiOOiD1LJLhN4T8HA3WrRd-KtFVAjpa5-ZmVQ/edit`.

El contrato `MONTH_TO_DATE` se validó posteriormente en la ejecución aislada
`2684`: periodo del 1 al 12 de agosto de 2026, 12 días transcurridos, rango
`THIS_MONTH`, presupuesto acumulado COP 240.000 sobre COP 20.000 diarios y cinco
nodos exitosos. El workflow temporal se eliminó al finalizar.

## Meta Ads: Kinku

- Business Manager: `355936969704127`.
- Cuenta publicitaria: `act_302924541795503`.
- Credencial cifrada en n8n: `Meta Ads - Kinku` (`httpHeaderAuth`).
- Moneda y zona horaria confirmadas por API: `COP`, `America/Bogota`.
- Rango: `periodStartDate` a `periodEndDate`, bajo el contrato `MONTH_TO_DATE`.
- Leads: acción `lead`; Reconocimiento: acción `post_engagement`.
- La integración selecciona cuatro campañas por ID y detiene el informe si falta un insight o presupuesto esperado.
- El presupuesto acumulado usa el presupuesto diario vigente por `periodDaysElapsed`; Meta no devuelve en esta consulta el historial de cambios de presupuesto.

La aceptación definitiva corresponde a la ejecución `2711`: 19 nodos exitosos,
40 solicitudes, 47 ocurrencias reemplazadas, cero placeholders residuales y
WhatsApp aceptado. El informe validado es:
`https://docs.google.com/presentation/d/1aVOc9xQ2VpHdTwqH5SWO62AvP6vk5_M3-OxP0lZgDbs/edit`.

La plantilla eliminó dos gráficas históricas de julio en las diapositivas 5 y
6. Su respaldo previo es `1p91OxRg2AAJ6o0abMbmMITiwlI9o0SbMY0nv49CIOl4`.
La especificación completa está en `META_ADS_INTEGRATION.md`.

## Pruebas mínimas

Desde el número autorizado:

- `#estado` debe continuar en el control administrativo.
- `Hola` debe mostrar el menú de informes.
- `1`, `Pekín`, `Kinku` o `genera el informe de Proyecto Pekín` deben confirmar el inicio.

Desde otro número:

- Ningún alias debe iniciar un informe.
