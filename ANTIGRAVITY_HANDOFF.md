# Handoff para Antigravity — dashboards y análisis del informe Tic Tac

Actualizado: 13 de agosto de 2026

Responsable de la automatización fuente: Codex / Santi

Responsable de esta fase: Antigravity

## 1. Objetivo

Convertir el informe fuente de 29 diapositivas en una presentación ejecutiva
con dashboards y análisis, conservando exactamente los datos suministrados por
n8n. El resultado debe ser una **copia editable**; el informe fuente, la
plantilla y el workflow productivo no se modifican.

Definición de terminado:

- todas las páginas analíticas contienen un dashboard legible y un análisis
  breve derivado de su tabla fuente;
- las cifras graficadas coinciden exactamente con las tablas del informe;
- no se inventan datos de HubSpot, creativos, subasta, ubicación ni históricos;
- se mantienen las 29 diapositivas, la identidad gráfica y el periodo;
- se entrega enlace a la copia, registro tabla→dashboard y evidencia de revisión
  visual de las 29 páginas.

## 2. Fuente de verdad y recursos

### Entrada obligatoria

- Enlace del Google Slides que el usuario adjuntará o pegará manualmente en la
  conversación actual con Antigravity.
- El enlace válido es exclusivamente el que el usuario identifique como
  `INFORME FUENTE DE ESTA EJECUCIÓN` en su mensaje. No reutilizar enlaces que
  aparezcan en documentación, conversaciones anteriores o ejemplos.
- El usuario obtiene este enlace por WhatsApp después de solicitar a n8n la
  generación del informe. WhatsApp y n8n no intervienen en el trabajo de
  Antigravity.
- Si el usuario no adjunta o pega un enlace de Google Slides en la conversación
  actual, detenerse y pedirlo antes de crear o modificar cualquier archivo.

Flujo correcto:

```text
Usuario solicita informe por WhatsApp
  → n8n genera el Slides con datos reales
  → WhatsApp entrega el enlace al usuario
  → el usuario pega manualmente ese enlace en Antigravity
  → Antigravity duplica el Slides y edita únicamente la copia
```

### Evidencia técnica

- workflow: `xK8GPmsUphKV2B2Q`;
- versión publicada: `9cfffeb3-0e24-443c-8e51-344bb1efe2a7`;
- implementación en Git: `7225e7f`;
- plantilla productiva vigente:
  `1cPlo9OeUWpfW7H1ACnbwpT59MSR_yruErFkVhc7jHOo`;
- plantilla anterior conservada como rollback:
  `16SvDTUUF9q7VspDWbX8Zr4YTU6QJi__L3oh5qvJYtq0`;
- la ejecución `2746` y los artefactos históricos sirven únicamente como
  evidencia del desarrollo; no determinan qué informe debe editarse en una
  conversación nueva.

El informe entregado manualmente por el usuario debe tener 29 diapositivas, 20
tablas creadas por API y una tabla preexistente. No debe contener dashboards
automáticos ni placeholders `{{...}}` pendientes. Si no cumple este contrato,
informar la diferencia y esperar instrucciones antes de editarlo.

## 3. Reglas no negociables

1. Crear una copia del informe que el usuario adjuntó manualmente en la
   conversación actual y nombrarla de forma que indique
   `DASHBOARDS + ANÁLISIS`. No editar el original.
2. Usar únicamente las tablas y etiquetas visibles del Slides. No consultar
   Google Ads, Meta Ads, Sheets, HubSpot ni otras fuentes.
3. No cambiar, redondear de manera engañosa, completar ni reinterpretar valores
   faltantes. Mantener `0`, `N/D` y `Meta no definida` cuando aparezcan.
4. Mantener el contrato `MONTH_TO_DATE`, zona `America/Bogota`, estrategia
   `SOURCE_REQUERY_NO_ROLLUP` y metas mensuales completas
   (`MONTHLY_FULL_TARGET`).
5. La meta total de Skala es 150 y corresponde a 70 + 50 + 30. No introducir
   ninguna referencia a 80.
6. No crear cifras para HubSpot ni para creativos. Tampoco añadir análisis de
   subasta de Google Ads, ubicaciones o rendimiento por anuncio.
7. Distinguir hechos observables de inferencias. No atribuir causalidad a una
   campaña, audiencia o plataforma sin evidencia en la tabla.
8. Mantener COP, porcentajes y nombres de campaña. Los gráficos deben mostrar
   la unidad en títulos, ejes o etiquetas.
9. Preservar fondos, logotipos, títulos, numeración, portada y cierre.
10. No modificar n8n, Git, permisos de Drive ni envíos por WhatsApp.

## 4. Cómo leer cada página analítica

Cada página analítica contiene tres componentes:

1. una tabla visible con los datos reales;
2. una etiqueta `DASHBOARD A GENERAR`, que define fuente, campaña/proyecto,
   tipo de visualización y periodo;
3. una etiqueta `ANÁLISIS A GENERAR`, que define los criterios de redacción.

La tabla manda si existe cualquier diferencia con la etiqueta. Si una etiqueta
es ambigua, elegir la visualización más simple que represente fielmente la
tabla, registrar la decisión y no cambiar los datos.

## 5. Mapa de las 29 diapositivas

| Diapositiva | Contenido fuente | Acción de Antigravity |
| ---: | --- | --- |
| 1–2 | Portada e identidad | Conservar; ajustar solo si un elemento nuevo invade el diseño |
| 3 | Resumen general de Pekín | Dashboard ejecutivo de KPIs/resultados, metas, inversión y eficiencia |
| 4 | Rendimiento por campaña de Pekín | Comparativo por campaña; barras o matriz ejecutiva según la tabla |
| 5 | Pekín Vivienda, serie diaria | Tendencia temporal; resultado e inversión, con impresiones/alcance como contexto |
| 6 | Pekín Vivienda, edad y género | Barras agrupadas por edad para Mujeres y Hombres |
| 7 | Pekín Vivienda, plataforma | Barras horizontales o dona solo si las categorías son legibles |
| 8 | Creativos de Pekín Vivienda | Zona manual; no inventar piezas ni métricas |
| 9 | Pekín Inversionistas, serie diaria | Tendencia temporal equivalente a la diapositiva 5 |
| 10 | Pekín Inversionistas, edad y género | Barras agrupadas por edad y género |
| 11 | Pekín Inversionistas, plataforma | Comparativo por plataforma |
| 12–13 | Creativos/campaña nueva | Zonas manuales; conservar instrucciones y espacios |
| 14 | Reconocimiento o reproducción de video | Resumen de actividad y eficiencia con los campos disponibles |
| 15 | Google Ads PMAX, actividad | Dashboard general de conversiones, inversión, impresiones e interacciones disponibles |
| 16 | Google Ads PMAX, meta frente a resultado | Comparativo meta–resultado y eficiencia; sin análisis de subasta |
| 17 | HubSpot | Dos zonas manuales; no crear cifras ni embudo sintético |
| 18 | Métriku | Resumen ejecutivo de volumen, inversión y eficiencia; usar tendencia solo si existen al menos dos fechas válidas con entrega |
| 19 | Resumen general de Skala | Dashboard ejecutivo; comprobar meta total 150 |
| 20 | Rendimiento por campaña de Skala | Comparativo Inversión, Vivienda y Feria Gran Salón |
| 21 | Skala Vivienda, serie diaria | Tendencia temporal |
| 22 | Skala Vivienda, edad y género | Barras agrupadas |
| 23 | Skala Vivienda, plataforma | Comparativo por plataforma |
| 24 | Creativos de Skala Vivienda | Zona manual; no inventar piezas ni métricas |
| 25 | Skala Inversión, serie diaria | Tendencia temporal |
| 26 | Skala Inversión, edad y género | Barras agrupadas |
| 27 | Skala Inversión, plataforma | Comparativo por plataforma; conservar el título corregido de Inversión |
| 28 | Creativos de Skala Inversión | Zona manual; no inventar piezas ni métricas |
| 29 | Cierre | Conservar |

## 6. Criterios para los dashboards

- Priorizar claridad ejecutiva sobre decoración.
- Series diarias: eje X cronológico; no reordenar fechas por magnitud.
- Edad/género: barras agrupadas, no apiladas, para no ocultar diferencias.
- Plataforma: ordenar de mayor a menor solo si no rompe la relación con la
  etiqueta; mostrar valores y no depender únicamente del color.
- Meta frente a resultado: diferenciar claramente meta mensual completa y
  resultado acumulado al corte.
- Inversión y resultados tienen escalas distintas. Usar ejes separados solo si
  quedan explícitos; si generan confusión, usar dos paneles coordinados.
- Evitar gráficos 3D, velocímetros decorativos, exceso de colores y leyendas
  redundantes.
- Aplicar una convención coherente de color por fuente/campaña en todo el deck.
- No ocultar categorías con cero. Deben quedar visibles si están en la tabla.
- Si no hay datos suficientes para un gráfico útil, mostrar un estado
  `Sin entrega en el periodo` y conservar la tabla o su resumen, sin inventar
  una tendencia.

## 7. Criterios para los análisis

Redactar en español, tono ejecutivo, entre 45 y 90 palabras por página. Usar
como máximo cuatro viñetas cortas o un párrafo breve.

Cada análisis debe:

- mencionar el periodo y la fuente cuando aporte contexto;
- citar dos o más cifras exactas de la tabla cuando existan;
- comparar resultado con meta solo cuando la meta esté definida;
- señalar eficiencia mediante inversión/CPA únicamente si esos campos existen;
- identificar la campaña, segmento, fecha o plataforma dominante sin atribuir
  causalidad;
- decir explícitamente `no hay datos suficientes` cuando corresponda;
- separar una observación (`la tabla muestra`) de una hipótesis o recomendación
  (`conviene revisar`, `podría evaluarse`).

Evitar:

- afirmar que una audiencia “funciona mejor” sin considerar volumen e
  inversión disponibles;
- extrapolar el acumulado a fin de mes como si fuera una garantía;
- comparar con meses anteriores, porque el informe no contiene históricos;
- inventar calidad de lead, ventas, retorno, intención o atribución;
- repetir en prosa todos los números del dashboard.

## 8. Diseño y maquetación

- Mantener la identidad visual original: fondo, tipografía disponible,
  logotipos y paleta predominante verde/negro/blanco.
- Reutilizar el espacio ocupado por tabla y etiquetas, sin invadir títulos ni
  elementos de marca.
- La tabla puede reemplazarse en la copia una vez conciliado el gráfico. El
  informe fuente conserva la tabla para auditoría.
- Usar tamaño de texto legible en modo presentación; ninguna etiqueta, eje o
  análisis debe quedar recortado.
- Conservar márgenes y alineaciones consistentes entre páginas equivalentes.
- No añadir elementos que parezcan datos si son meramente decorativos.

## 9. Proceso obligatorio por fases

### Fase 1 — Inventario y copia

Artefacto: copia editable del informe con nombre inequívoco.

Validación antes de continuar:

- confirmar 29 diapositivas;
- verificar que el original no cambió;
- inventariar las tablas, etiquetas y zonas manuales.

### Fase 2 — Diseño de sistema visual

Artefacto: únicamente la diapositiva 3 como piloto de resumen y la diapositiva
5 como piloto de serie diaria.

Validación antes de continuar:

- cifras conciliadas con las tablas;
- tipografía, color, títulos, ejes y análisis legibles;
- miniaturas grandes de ambas páginas revisadas;
- aprobación explícita del usuario antes de iniciar la Fase 3.

Después de entregar los pilotos, detenerse. No interpretar silencio, ausencia
de errores ni acceso concedido como aprobación.

### Fase 3 — Producción del deck

Artefacto: dashboards y análisis en todas las páginas analíticas.

Validación antes de continuar:

- cada página cumple la etiqueta correspondiente;
- zonas manuales permanecen sin cifras inventadas;
- Skala conserva meta 150.

### Fase 4 — Auditoría

Artefactos:

- matriz de conciliación tabla→dashboard;
- registro de decisiones y limitaciones;
- revisión visual de las 29 diapositivas.

La auditoría debe comprobar categorías, valores, unidades, periodo, títulos,
leyendas, recortes, solapamientos y consistencia de análisis.

### Fase 5 — Entrega

Entregar:

1. enlace a la copia editable;
2. estado de acceso de la copia;
3. lista de diapositivas transformadas;
4. zonas que permanecieron manuales;
5. evidencia de conciliación y revisión visual;
6. riesgos o dudas pendientes;
7. siguiente acción recomendada.

No compartir externamente ni reemplazar el artefacto fuente sin aprobación de
Santi/Nicolás.

## 10. Intentos fallidos y riesgos ya conocidos

- Una primera reconstrucción dejó páginas sin el conjunto completo de tabla y
  etiquetas; se corrigió y la aceptación válida es `2744`/`2746`.
- El estado exitoso de una automatización no garantizó calidad visual. Por eso
  es obligatoria la revisión de las 29 páginas.
- Gráficos históricos de julio y textos antiguos aparecieron en versiones
  anteriores; no deben recuperarse ni usarse como contexto.
- HubSpot no tiene integración API vigente. Cualquier cifra CRM sería
  inventada.
- Meta entrega presupuesto diario vigente, no el historial de cambios del mes;
  no explicar diferencias de gasto con una historia no demostrada.
- Algunas campañas pueden tener cero entrega o meta no definida. Esto es un
  estado válido, no un error que deba rellenarse.
- El primer dashboard de Métriku priorizó `Interacción 0` y una serie diaria de
  una sola fila en cero. Aunque era fiel a la tabla, no explicaba el rendimiento
  del cliente. El patrón aprobado compara leads, inversión, CPA, participación
  y avance a meta; está documentado en
  `workflows/SLIDES_DASHBOARD_RUNBOOK.md`.
- Un primer lote de rediseño se detuvo antes de escribir por
  `ReferenceError: requiredRevisionId is not defined`. La variable de revisión
  debe capturarse en una lectura fresca y pasarse con el mismo nombre al
  control de escritura. No reintentar con una revisión antigua.
- Imprimir la estructura completa de una diapositiva generó miles de líneas y
  consumo innecesario. Usar lecturas parciales y resumir a IDs, texto, tablas y
  transformaciones relevantes.

## 11. Criterios de aceptación final

- [ ] El original no fue modificado y existe una copia editable identificable.
- [ ] Las 29 diapositivas están presentes y fueron revisadas visualmente.
- [ ] Cada dashboard coincide exactamente con su tabla fuente.
- [ ] Cada análisis se limita a los datos y criterios de su diapositiva.
- [ ] Skala muestra meta total 150 y no aparece 80.
- [ ] No hay históricos, HubSpot, creativos, subasta ni métricas inventadas.
- [ ] No hay textos cortados, solapamientos, ejes ilegibles o unidades ambiguas.
- [ ] Las páginas manuales están vacías o claramente marcadas como manuales.
- [ ] Se entregó la matriz tabla→dashboard y el listado de limitaciones.
- [ ] El resultado no fue compartido externamente sin aprobación.

## 12. Archivos relacionados

- `CODEX_HANDOFF.md`: estado técnico integral y cronología.
- `workflows/INFORMES_SETUP.md`: contrato operativo del generador.
- `workflows/PLACEHOLDERS_SLIDES.md`: estructura de tablas, etiquetas y páginas.
- `workflows/GOOGLE_ADS_INTEGRATION.md`: límites de PMAX.
- `workflows/META_ADS_INTEGRATION.md`: campañas y límites de Meta Ads.
- `PROMPT_ANTIGRAVITY_DASHBOARDS.md`: instrucción lista para ejecutar.
- `workflows/SLIDES_DASHBOARD_RUNBOOK.md`: procedimiento eficiente, fórmulas,
  patrón aprobado de Métriku e intentos fallidos.
