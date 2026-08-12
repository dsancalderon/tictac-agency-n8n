# Integración de Meta Ads para informes de Kinku

## Alcance

Esta integración incorpora métricas reales acumuladas del mes desde Meta Ads al
generador `xK8GPmsUphKV2B2Q`. Google Ads también es real; CRM y las metas
continúan temporales hasta conectar sus fuentes autoritativas.

## Recursos de producción

| Recurso | Identificador |
| --- | --- |
| Business Manager Kinku | `355936969704127` |
| Cuenta publicitaria | `act_302924541795503` |
| Credencial cifrada de n8n | `Meta Ads - Kinku` |
| Workflow generador | `xK8GPmsUphKV2B2Q` |
| Versión publicada | `4fc4febe-e8e7-410f-a61f-180f67e9fd19` |

El token de usuario del sistema no se almacena en Git ni en el JSON del
workflow. La credencial usa `Authorization: Bearer ...` dentro del almacén
cifrado de n8n y tiene permisos de lectura.

## Campañas y métricas

| Bloque | Campaña | ID | Acción |
| --- | --- | --- | --- |
| Reconocimiento | CAMPAÑA AWARENNES - INTERACCION AGOSTO | `120249557003280774` | `post_engagement` |
| Inversionistas | KINKU - PEKÍN - INVERSIONISTAS | `120238954925180774` | `lead` |
| Vivienda | KINKU - PEKÍN - VIVIENDA FAMILIAR | `120238960041500774` | `lead` |
| Apartaestudios | KINKU - PEKÍN - APARTAESTUDIOS | `120247687053780774` | `lead` |

La API confirmó moneda `COP` y zona horaria `America/Bogota`.

## Recorrido del generador

```text
Recolectar Datos Simulados
  -> Consultar Insights Meta Kinku
  -> Consultar Presupuestos Meta Kinku
  -> Incorporar Meta Ads Real
  -> Consultar Google Ads Kinku
  -> Incorporar Google Ads Real
```

Los insights usan nivel `campaign`, fechas dinámicas `periodStartDate` y
`periodEndDate`, y los campos `campaign_id`, `campaign_name`, `objective`,
`spend`, `impressions`, `reach` y `actions`.

La consulta de campañas obtiene `daily_budget`, `lifetime_budget`, estado y
presupuesto restante. Para estas cuatro campañas el presupuesto está a nivel de
campaña, no de conjunto de anuncios.

## Normalización

- Inversión: `spend`, ya expresado en COP.
- Leads: valor de `actions[action_type=lead]`.
- Reconocimiento: valor de `actions[action_type=post_engagement]`.
- CPA: inversión dividida por leads.
- Performance: resultado dividido por KPI temporal por 100.
- Presupuesto del periodo: `daily_budget * periodDaysElapsed`.
- Procedencia: `googleAds=live`, `metaAds=live`, `crm=mock`.

El nodo detiene el informe si falta cualquiera de las cuatro campañas en los
insights o en la consulta de presupuestos. No sustituye silenciosamente una
campaña ausente por datos simulados.

## Limitación de presupuesto

Meta devuelve el presupuesto diario vigente, no el historial de cambios dentro
del mes. Si una campaña cambió su presupuesto, el presupuesto acumulado
calculado puede ser inferior o superior al gasto real. Esto se observó en
Reconocimiento: el presupuesto vigente fue COP 3.400 diarios, mientras el gasto
acumulado reflejaba una configuración histórica mayor.

## Aceptación de producción del 12 de agosto de 2026

- Ejecución aislada de conexión: `2700`, exitosa.
- Ejecución aislada de normalización: `2703`, exitosa.
- Ejecución definitiva del generador: `2711`, exitosa, 19 de 19 nodos.
- Periodo: 1 al 12 de agosto de 2026.
- Meta Ads: 102 leads y COP 279.329 de inversión en las campañas de leads al instante de la prueba.
- Reconocimiento: 52.187 interacciones.
- Google Ads PMAX: 34 conversiones.
- Slides: 40 solicitudes, 47 ocurrencias reemplazadas y cero placeholders residuales.
- Presentación: `1aVOc9xQ2VpHdTwqH5SWO62AvP6vk5_M3-OxP0lZgDbs`.
- WhatsApp: mensaje `6a7cb99c9cd1175b867075b7`, aceptado, categoría `service`, costo USD 0.
- Validación visual: diapositivas 3, 4, 5, 6, 15, 16 y 17 sin recortes ni caracteres dañados.

Las gráficas históricas de julio fueron eliminadas de las diapositivas 5 y 6
porque contradecían el corte mensual real. Respaldo de la plantilla previo al
cambio: `1p91OxRg2AAJ6o0abMbmMITiwlI9o0SbMY0nv49CIOl4`.

## Rollback

1. Restaurar la plantilla desde el respaldo indicado si se requieren las imágenes anteriores.
2. Recuperar la versión anterior del generador desde Git.
3. Reasignar las credenciales cifradas sin copiar tokens al JSON.
4. Publicar y comprobar que `xK8GPmsUphKV2B2Q` continúe activo.
