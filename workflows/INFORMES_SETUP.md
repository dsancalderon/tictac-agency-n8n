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

El generador combina fuentes reales con metas mensuales de Google Sheets. Cada salida conserva el campo
`dataSources` para que el informe identifique el origen de los datos:

| Flujo o nodo | Estado |
| --- | --- |
| Cargar Configuración Temporal → Leer Metas Google Sheets → Aplicar Metas Google Sheets | Producción: selecciona la pestaña del mes y carga las metas mensuales completas de Proyecto Pekín, Skala y Métriku |
| Recolectar Datos Simulados | Conserva el contrato entre nodos; las métricas CRM simuladas ya no se publican en Slides ni WhatsApp |
| Consultar Insights Meta Kinku → Consultar Presupuestos Meta Kinku → Incorporar Meta Ads Real | Producción: Meta Ads real para Kinku, Skala y Métriku, incluyendo campañas sin entrega en el corte |
| Consultar Google Ads Kinku → Incorporar Google Ads Real | Producción: Google Ads real para la PMAX de Kinku |
| Consultar Tendencia/Demografia/Plataformas Meta → Preparar Datos del Informe | Contrato local validado: construye `reportDataV1` con resúmenes y series fuente de Pekín, Skala y Métriku |
| Preparar Datos del Informe → Preparar Batch Update | Contrato local validado: reemplaza escalares, crea tablas visibles y escribe etiquetas para una IA posterior; no crea gráficos |
| Copiar y completar Google Slides | Producción usa la nueva plantilla mediante la credencial `Google Drive account`; aceptación `2746` completada |
| Preparar Notificación Final | Producción validada por YCloud/WhatsApp; mensaje final `6a7d73a4e3c0d81f9b263c81` aceptado |

## Variables pendientes

- HubSpot: automatización diferida hasta disponer de una Private App de solo
  lectura; mientras tanto los dos dashboards se insertan manualmente.
- ID de carpeta de Google Drive.
- Credencial de HubSpot en n8n.

## HubSpot: inserción manual vigente

La inspección manual del 12 de agosto de 2026 confirmó:

| Concepto | Objeto | Propiedad/valor interno |
| --- | --- | --- |
| Proyecto Pekín | Contacto | `proyecto = Pekín` |
| MQL | Contacto | `lifecyclestage = marketingqualifiedlead` |
| Fecha inicial propuesta | Contacto | `createdate` |
| Estado estándar | Contacto | `hs_lead_status` (sin uso suficiente) |
| Razón de descalificación | Lead | `hs_lead_disqualification_reason` |

El pipeline del objeto Lead contiene `New`, `Attempting`, `Connected`,
`Qualified` y `Disqualified`, pero sus etapas calificadas no contienen datos
suficientes para reconstruir el embudo. La opción `NOT_A_GOOD_FIT` existe como
razón de descalificación, pero no se debe mapear a `No Nicho` sin aprobación de
Nicolás.

Nicolás confirmó que `No Nicho` era una categoría inventada y que el informe
debe basarse en los dashboards reales de etapa del ciclo de vida y estado del
contacto. Como el usuario actual no puede crear una Private App, la diapositiva
17 quedó destinada a inserción manual de ambos dashboards. El generador no
reemplaza ni publica cifras CRM simuladas y la notificación final identifica
HubSpot como inserción manual.

Cuando exista acceso API, la futura automatización debe aplicar
`proyecto = Pekín`, `hubspot_owner_id = 90633401`, fecha desde el día 1 hasta la
generación y deduplicación por ID de contacto. La propiedad operativa es
`estado_del_contacto`; los valores observados incluyen `Agendado`,
`Marcar de nuevo`, `No útil`, `Seguimiento`, `Lead Caliente` y `Desistimiento`.

## Google Sheets: metas mensuales en producción

- Hoja nativa: `1amDTwQEPHhBfM47T80O3KAxQ7FGY1gonGzXhXuAnkSU`.
- Pestañas disponibles: `GENERAL`, `ENERO` a `AGOSTO`; el nodo selecciona el
  mes vigente usando `America/Bogota`.
- Sección inicial: `FLOW PROYECTO PEKIN`; columnas `FECHA`, `MEDIO`,
  `OBJETIVO`, `CAMPAÑA`, `KPI`, `COSTO POR RESULTADO` e `INVERSIÓN`.
- Credencial reutilizada: `Google Drive account`; Google Sheets API habilitada
  en el proyecto OAuth `706849453819`.
- Política: `MONTHLY_FULL_TARGET`. KPI e inversión son metas mensuales
  completas y no se prorratean por los días transcurridos.
- Reconocimiento, Inversión, Apartaestudios y Google PMAX son obligatorios. Si
  Vivienda no tiene fila, se conservan sus resultados reales de Meta Ads y se
  muestran `Meta no definida` y cumplimiento `N/D`.
- La salida conserva `reportingContract`, `periodStartDate`, `periodEndDate`,
  `periodDaysElapsed` y `periodLabel`.
- La misma lectura procesa `FLOW PROYECTO SKALA` y `FLOW METRIKU`. Para Skala,
  las filas de Inversión, Vivienda y Feria suman una meta mensual de 150 leads.
  El flujo lee también la fila total de la hoja y detiene el informe si esa
  cifra no coincide con la suma detallada.

La validación aislada del 12 de agosto de 2026 leyó `AGOSTO!A1:J200`, combinó
Sheets, Meta Ads y Google Ads reales, y no creó Slides ni envió WhatsApp. Obtuvo
97,5 leads de meta, COP 2.000.000 de inversión planeada y 139 leads reales. El
generador productivo quedó activo con 21 nodos y versión
`96fd31ec-5346-43ba-b576-0d352eff7c6f`.

El 13 de agosto de 2026 se publicó el generador reconstruido para retirar la
rama de dashboards y producir tablas fuente más etiquetas. Skala y Métriku
continúan conectados a Meta Ads y Google Sheets. La versión productiva activa,
con 22 nodos, es `9cfffeb3-0e24-443c-8e51-344bb1efe2a7`.

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

## Datos y etiquetas para IA externa

Gemini no forma parte del generador. El nodo `Preparar Datos del Informe`
produce el contrato `reportDataV1` con periodo, procedencia, resúmenes por
campaña y series diarias, demográficas y de plataforma.

La rama `Actualizar Datos Dashboards`, el ID de la hoja técnica y las
operaciones `createSheetsChart`/`NOT_LINKED_IMAGE` fueron retiradas del JSON
local. `Preparar Batch Update` crea tablas con IDs estables y escribe dos
etiquetas por página analítica:

- `DASHBOARD A GENERAR`, con fuente, campaña/proyecto, tipo y periodo;
- `ANÁLISIS A GENERAR`, con fuente, campaña/proyecto, criterios y periodo.

HubSpot y creativos permanecen como zonas manuales. La IA que genere después
los dashboards y análisis es externa al workflow y recibe el Google Slides
editable.

### Contrato de consumo para Antigravity

1. El usuario debe pegar manualmente en la conversación el enlace recibido por
   WhatsApp para esa ejecución. Antigravity no ejecuta n8n ni obtiene el enlace
   por su cuenta.
2. Usar como entrada una copia de ese informe, nunca la plantilla ni el
   artefacto fuente de producción. Si falta el enlace en la conversación
   actual, detenerse y solicitarlo.
3. Derivar cada gráfico exclusivamente de la tabla visible de su diapositiva.
4. Mantener `MONTH_TO_DATE`, `America/Bogota`, `MONTHLY_FULL_TARGET` y las
   fuentes declaradas.
5. No inventar HubSpot, creativos, análisis de subasta, históricos ni métricas
   no incluidas en las tablas.
6. Entregar una copia editable, un registro tabla→dashboard y evidencia de la
   revisión visual de las 29 diapositivas.

Las instrucciones completas están en `../ANTIGRAVITY_HANDOFF.md` y el prompt
de ejecución en `../PROMPT_ANTIGRAVITY_DASHBOARDS.md`.

## Prueba privada de Google Slides

- Plantilla productiva/rollback: `16SvDTUUF9q7VspDWbX8Zr4YTU6QJi__L3oh5qvJYtq0`.
- Nueva plantilla privada: `1cPlo9OeUWpfW7H1ACnbwpT59MSR_yruErFkVhc7jHOo`.
- Credencial de n8n configurada por ID interno; el Client Secret no se guarda en este repositorio.
- El envío final usa la credencial cifrada de n8n `YCloud API - Tic Tac`; la API key no queda escrita dentro del workflow.
- Cada solicitud crea una copia, reemplaza escalares y añade 20 tablas fuente.
- El informe conserva 29 diapositivas y cero gráficos automáticos.
- La validación privada `2744` se detuvo antes de permisos y WhatsApp. Después
  de su aprobación, la ejecución productiva `2746` otorgó permiso de lector y
  envió el enlace por WhatsApp al destinatario expresamente autorizado.
- Mientras no exista una carpeta final compartida, las copias quedan en la raíz de Mi unidad de la cuenta conectada.
- Después del mensaje de confirmación, Meta muestra el indicador de escritura durante el procesamiento; se apaga con la respuesta final o a los 25 segundos.
- La notificación final declara que Google Ads, Meta Ads y las metas de Sheets
  son datos reales; los dashboards/análisis quedan para una IA externa y
  HubSpot/creativos permanecen manuales.

La aceptación definitiva del 12 de agosto de 2026 corresponde a la ejecución
`2681`: 16 nodos exitosos, 47 ocurrencias reemplazadas, ningún placeholder
residual y WhatsApp aceptado. El informe validado es:
`https://docs.google.com/presentation/d/1BZz_ZsYiOOiD1LJLhN4T8HA3WrRd-KtFVAjpa5-ZmVQ/edit`.

La validación privada vigente del 13 de agosto de 2026 no publicó permisos ni
envió WhatsApp. La ejecución `2744` creó 20 tablas, aplicó 1.141 solicitudes,
dejó cero placeholders y cero gráficos, y fue conciliada contra 129 filas de
`reportDataV1`. Se revisaron visualmente las 29 diapositivas. Presentación:
`https://docs.google.com/presentation/d/1GAnmA_kJ0ebIlzOt3L3CcE_wx1OrFfqKsGgjScSxYuo/edit`.

La aceptación productiva `2746` completó los 22 nodos, publicó el informe como
lector mediante enlace y envió WhatsApp al número de pruebas autorizado. El
mensaje `6a7d73a4e3c0d81f9b263c81` fue aceptado. Informe:
`https://docs.google.com/presentation/d/1jUwCYjpmA6kgCRsDS58gWPSkYXUrPKwlv3DzcexWpJk/edit`.
La auditoría confirmó 29 diapositivas, 20 tablas nuevas, cero gráficos, cero
placeholders y meta total Skala 150.

La próxima fase ya no modifica n8n: Antigravity generará dashboards y análisis
sobre una copia del informe `2746`. La versión fuente debe conservarse para
conciliar cifras y permitir rollback visual.

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

## Próxima aceptación: salida de Antigravity

- abrir y revisar las 29 diapositivas, no solo confirmar que la tarea terminó;
- conciliar cada valor graficado con la tabla fuente correspondiente;
- comprobar títulos, leyendas, unidades COP, porcentajes y periodo;
- confirmar que las zonas manuales 8, 12, 13, 17, 24 y 28 no contienen cifras
  inventadas;
- conservar una copia intacta del informe fuente y no modificar producción;
- compartir el resultado solo después de aprobación humana.
