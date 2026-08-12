# Integración de Google Ads para informes de Kinku

## Alcance

Esta integración incorpora métricas reales de la campaña Performance Max de
Kinku al generador de informes. Meta Ads también está conectado en producción;
HubSpot y la tabla maestra de metas continúan pendientes.

## Recursos de producción

| Recurso | Identificador |
| --- | --- |
| Workflow generador | `xK8GPmsUphKV2B2Q` |
| Cuenta administradora de Google Ads | `658-489-2239` |
| Cuenta cliente de Kinku | `924-069-6515` |
| Campaña PMAX | `23823733646` |
| Nombre de campaña | `TIC TAC| CAMPAÑA PMAX| KINKU` |
| Credencial cifrada de n8n | `Google Ads - Tic Tac` |

No se almacenan Client Secret, refresh token ni token de desarrollador en los
archivos del repositorio. Esos valores permanecen dentro de la credencial
cifrada de n8n.

## Nodos y recorrido

```text
Incorporar Meta Ads Real
  -> Consultar Google Ads Kinku
  -> Incorporar Google Ads Real
  -> Preparar Solicitud Gemini
```

`Consultar Google Ads Kinku` usa el nodo oficial de Google Ads de n8n:

- recurso: `campaign`;
- operación: obtener varias;
- estado: `ENABLED`;
- rango: `THIS_MONTH`;
- cuenta administradora y cuenta cliente indicadas arriba.

`Incorporar Google Ads Real` selecciona exclusivamente la campaña
`23823733646`. Si no está presente, detiene el informe con un error explícito en
vez de reemplazar silenciosamente los datos con valores simulados.

## Mapeo de métricas

| Respuesta de Google Ads | Salida normalizada | Uso |
| --- | --- | --- |
| `conversions` | `pmax.leads` | Leads de formulario |
| `costMicros / 1_000_000` | `pmax.investment` | Inversión en COP |
| `amountMicros / 1_000_000` | `googleAds.dailyBudget` | Presupuesto diario en COP |
| `dailyBudget * periodDaysElapsed` | `pmax.budget` | Presupuesto acumulado del periodo |
| `investment / leads` | `pmax.cpa` | CPA calculado |
| `leads / kpi * 100` | `pmax.performance` | Cumplimiento de la meta |
| `impressions` | `googleAds.impressions` | Auditoría |
| `interactions` | `googleAds.interactions` | Auditoría |
| `videoTrueviewViews` | Respuesta del nodo oficial | Diagnóstico de video |

El KPI de PMAX sigue siendo una meta de configuración temporal. Debe migrarse a
la tabla maestra cuando se implemente Google Sheets.

## Contrato temporal del informe

El generador publica `reportingContract.version = 1.0` con estas reglas:

| Campo | Regla |
| --- | --- |
| `mode` | `MONTH_TO_DATE` |
| `cadenceDays` | `7`; expresa la frecuencia de revisión, no una ventana móvil |
| `timezone` | `America/Bogota` |
| `periodStartDate` | Primer día del mes de generación |
| `periodEndDate` | Día de generación |
| `periodStart` | Inicio exacto del primer día, convertido a ISO |
| `periodEnd` | Instante exacto de generación |
| `daysElapsed` | Días calendario incluidos, contando ambos extremos |
| `accumulationStrategy` | `SOURCE_REQUERY_NO_ROLLUP` |

Cada solicitud vuelve a consultar Google Ads desde el primer día del mes. No
suma resultados guardados de cortes anteriores. En el próximo mes, el inicio se
desplaza automáticamente al nuevo día 1. Meta Ads ya consume estos mismos
límites; HubSpot y Excel/Google Sheets deberán hacerlo cuando se conecten.

## Contrato de procedencia

La salida del nodo de normalización contiene:

```json
{
  "dataSource": "mixed",
  "dataSources": {
    "googleAds": "live",
    "metaAds": "live",
    "crm": "mock"
  }
}
```

La presentación y el mensaje final no deben describir el conjunto completo como
real mientras existan fuentes con valor `mock`.

## Validación previa a producción

La prueba aislada inicial confirmó, bajo el contrato histórico de los últimos
siete días:

- 29 conversiones asociadas en la interfaz al objetivo **Enviar formulario de clientes potenciales**;
- COP 176.731,75 de inversión;
- COP 20.000 de presupuesto diario;
- COP 140.000 de presupuesto para siete días;
- COP 6.094 de CPA calculado;
- 96,67 % de cumplimiento sobre KPI 30;
- 4.255 impresiones y 340 interacciones.

Estos valores son evidencia de la prueba, no constantes del workflow.

La ejecución aislada `2684` validó el contrato vigente el 12 de agosto de 2026:

- `periodMode = MONTH_TO_DATE` y `dateRange = THIS_MONTH`;
- periodo del 1 al 12 de agosto, con 12 días incluidos;
- COP 20.000 de presupuesto diario y COP 240.000 de presupuesto acumulado;
- 34 conversiones, COP 205.138,90 de inversión, 4.581 impresiones y 371
  interacciones provenientes de Google Ads;
- cinco nodos exitosos, sin crear Slides ni enviar WhatsApp.

El workflow temporal de esta validación fue desactivado y eliminado.

## Prueba completa

1. Confirmar que el generador productivo está activo y contiene exactamente un
   nodo `Consultar Google Ads Kinku` y un nodo `Incorporar Google Ads Real`.
2. Ejecutar el generador con `clientId`, `clientName` y un `customerPhone`
   autorizado.
3. Revisar en la ejecución los nodos de Google Ads, normalización, Gemini,
   Drive, Slides, permiso de lector y YCloud.
4. Comprobar que los cinco placeholders PMAX coinciden con la salida
   normalizada.
5. Confirmar que las 40 solicitudes de reemplazo incluyen
   `ANALISIS_TENDENCIA_VIVIENDA`, `RECOMENDACION_AGENCIA_VIVIENDA`,
   `GOOGLE_ADS_ANALISIS`, `GOOGLE_ADS_RECOMENDACION` y
   `SINTESIS_EMBUDO`.
6. Abrir la presentación final y verificar visualmente los valores y el texto de
   procedencia.
7. Confirmar una sola notificación de WhatsApp con un enlace válido.

## Incidencias detectadas durante aceptación

- La primera ejecución completa (`2655`) validó Google Ads, normalización,
  Gemini y los placeholders PMAX, pero se detuvo en Google Drive porque la
  credencial `Google Drive account` requería reconexión.
- La misma ejecución reveló que Gemini producía tres textos y solo
  `SINTESIS_EMBUDO` estaba mapeado. Se agregaron los dos placeholders narrativos
  faltantes y el total pasó de 36 a 38 reemplazos.
- Las ejecuciones `2670` y `2674` fallaron por cambios de versión de Google
  Ads: n8n 2.32.6 llamaba a v21 y el primer ajuste a v25 todavía solicitaba
  `metrics.video_views`, campo retirado en v25.
- La imagen Docker mantiene n8n 2.32.6, cambia únicamente las rutas del nodo de
  Google Ads de v21 a v25 y sustituye `metrics.video_views` por
  `metrics.video_trueview_views`. La consulta aislada `2675` confirmó el
  funcionamiento de v25 y devolvió 40 vistas TrueView.
- La primera aceptación completa posterior al ajuste (`2676`/`2677`) mostró
  mojibake en dos textos publicados desde PowerShell. Se republicó el código
  leyendo el JSON explícitamente en UTF-8.
- La inspección visual encontró capturas históricas contradictorias en las
  diapositivas 15 y 16. Se eliminaron de la plantilla y del informe definitivo;
  esas páginas ahora dependen de `GOOGLE_ADS_ANALISIS` y
  `GOOGLE_ADS_RECOMENDACION`. El total pasó de 38 a 40 reemplazos.

## Aceptación de producción del 12 de agosto de 2026

- Consulta aislada: ejecución `2675`, estado `success`.
- Prueba completa definitiva: ejecución del generador `2681`, estado
  `success`, 16 de 16 nodos ejecutados.
- Presentación:
  `1BZz_ZsYiOOiD1LJLhN4T8HA3WrRd-KtFVAjpa5-ZmVQ`.
- Resultado de Slides: 40 solicitudes, 47 ocurrencias reemplazadas, cero
  placeholders residuales y cero caracteres dañados.
- Validación visual: tabla PMAX y diapositivas 5, 6, 15, 16 y 17 sin recortes;
  las diapositivas de Google Ads no conservan capturas históricas.
- WhatsApp: mensaje `6a7bfd776ea9423da69d432e`, estado `accepted`, costo
  USD 0, categoría `service`.
- Desde la aceptación de Meta Ads `2711`, la notificación identifica Google Ads
  y Meta Ads como fuentes reales y CRM como fuente simulada.
- La versión de producción `9cf08ff0-36fa-481c-92d1-9f0892dff35b` aplica el
  contrato `MONTH_TO_DATE`; su consulta aislada posterior es la ejecución
  `2684`, estado `success`.

## Limpieza posterior a la aceptación

Se eliminaron los siete workflows temporales usados para respaldo, sondeo y
pruebas. La instancia conserva únicamente los cuatro workflows productivos,
todos activos: gateway, control administrativo, router y generador.

## Rollback

El respaldo temporal de n8n se eliminó al finalizar la aceptación para mantener
limpia la instancia. Para revertir:

1. recuperar la versión anterior desde Git;
2. importar o actualizar `workflows/tictac-generador-informe-base.json`;
3. reasignar las credenciales cifradas sin incluir secretos en el JSON;
4. comprobar los IDs de subworkflow y activar `xK8GPmsUphKV2B2Q`.

La plantilla de Slides sí conserva una copia independiente previa a los cambios:
`1x22kouOKfSPGCJM1Rg3n-9Q6f5bTsOuEQZPFBbB_b8w`.
