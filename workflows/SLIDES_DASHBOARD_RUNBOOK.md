# Runbook eficiente para dashboards en Google Slides

Actualizado: 13 de agosto de 2026

Este documento complementa `ANTIGRAVITY_HANDOFF.md` y
`PROMPT_ANTIGRAVITY_DASHBOARDS.md`. Su objetivo es repetir el resultado visual
aprobado con menos llamadas, menos contexto y menor riesgo de modificar el
original.

## 1. Secuencia mínima obligatoria

1. Recibir en la conversación actual el enlace marcado como
   `INFORME FUENTE DE ESTA EJECUCIÓN`.
2. Abrir ese enlace, crear una copia completa y confirmar que toda edición se
   realizará sobre la copia. No editar ni renombrar el original.
3. Leer una sola vez el inventario compacto de la presentación: ID, título,
   revisión, tamaño y orden/ID de las diapositivas.
4. Durante el piloto, leer en detalle solo las diapositivas 3 y 5 y sus tablas.
   No cargar repetidamente el contenido completo de las 29 páginas.
5. Conciliar los valores fuente y preparar una ficha breve por diapositiva:
   periodo, unidad, categorías, resultado, meta, inversión, CPA y datos
   faltantes.
6. Crear únicamente los pilotos 3 y 5 en una operación por diapositiva o en un
   lote controlado. Obtener una miniatura grande de cada piloto, revisar el
   render real y detenerse para esperar aprobación explícita.
7. Después de la aprobación, producir las páginas restantes por bloques de
   campaña. Mantener una convención de IDs para los objetos generados, por
   ejemplo `d03_`, `d05_`, `m18_`, para poder sustituir solo esos objetos.
8. Verificar cada bloque con lectura de texto y miniaturas. Al final auditar las
   29 páginas y entregar la matriz tabla→dashboard.

## 2. Lectura y escritura con bajo consumo

- Preferir respuestas parciales: metadatos de presentación, una diapositiva o
  sus tablas. Evitar descargar o imprimir el JSON completo del deck cuando no
  sea necesario.
- Extraer y conservar localmente una ficha de datos normalizada. No volver a
  consultar la misma diapositiva para recordar cifras ya conciliadas.
- Crear todos los elementos de una diapositiva en un solo `batchUpdate` cuando
  el sistema lo permita. No hacer una llamada separada por cada texto, barra o
  tarjeta.
- Leer una revisión fresca justo antes de escribir y enviar
  `writeControl.requiredRevisionId`. Si la revisión cambió, releer la página y
  reconstruir el lote; no forzar una escritura sobre cambios concurrentes.
- Preservar fondo, logotipo y elementos de marca por ID. Eliminar únicamente
  la tabla/etiquetas sustituidas y los objetos generados cuyo prefijo pertenezca
  a esa diapositiva.
- Después de escribir, validar primero el texto y luego una miniatura `LARGE`.
  Una respuesta exitosa de la API no demuestra que el diseño sea legible.
- No volver a leer el deck completo después de cada cambio. Consultar solo la
  diapositiva modificada y su miniatura.

## 3. Regla para escoger el dashboard

Usar esta jerarquía, consistente con `kpi-dashboard-design`:

1. **Resumen ejecutivo:** cuatro KPI como máximo en la primera fila.
2. **Contexto:** uno o dos comparativos que expliquen qué campaña aporta el
   volumen y cuál consume la inversión.
3. **Eficiencia:** CPA, avance a meta o participación, únicamente cuando se
   puedan calcular con campos visibles.
4. **Decisión:** una lectura corta con observación, alerta y acción sugerida.

No usar una serie temporal con menos de dos fechas válidas. Si solo existe una
fila en cero, mostrar `Sin entrega` o sustituir la tendencia por un comparativo
de campañas. Los ceros y `Meta no definida` deben permanecer visibles.

## 4. Fórmulas derivadas permitidas

Las cifras derivadas se permiten solo si todos sus componentes aparecen en la
misma tabla fuente. Deben rotularse como `calculado` o explicar la fórmula.

```text
leads totales = suma de resultados cuya unidad sea Leads
inversión observada = suma de la inversión visible
CPA combinado = inversión observada / leads totales
aporte de leads campaña = leads campaña / leads totales
participación de inversión = inversión campaña / inversión observada
brecha de CPA A vs. B = CPA A / CPA B
avance a meta = resultado / meta, solo cuando la meta esté definida y sea > 0
```

Redondear porcentajes a enteros para lectura ejecutiva y COP al peso cuando el
detalle decimal no aporte valor. Conservar en la ficha de conciliación el valor
original y el resultado del cálculo. Nunca dividir por cero ni convertir
`Meta no definida` en cero.

## 5. Patrón visual aprobado para Métriku

Cuando la diapositiva de Métriku tenga campañas con leads e inversión pero su
serie diaria sea insuficiente, usar esta composición 16:9:

- Encabezado: `RENDIMIENTO MÉTRIKU`, fuente/periodo y corte acumulado.
- Fila de cuatro tarjetas: leads totales, inversión observada, CPA combinado
  calculado y brecha de CPA entre las campañas con entrega.
- Panel izquierdo `APORTE A LA CAPTACIÓN`: participación de leads por campaña,
  barras horizontales y campañas sin entrega.
- Panel central `INVERSIÓN Y EFICIENCIA`: inversión, CPA y participación del
  gasto por campaña; incluir avance a meta solo donde exista meta definida.
- Panel derecho `LECTURA PARA DECISIÓN`: mejor eficiencia, alerta y acción
  recomendada; añadir al pie la fórmula del CPA combinado.

Sistema visual aprobado:

- fondo negro/gráfico existente y paneles verde-negro oscuro;
- acento Métriku `#FA9B03`, con blanco y grises neutros;
- verde claro solo como señal secundaria de mejor eficiencia;
- títulos en Oswald y cuerpo en Arial;
- bordes redondeados, cuatro KPI, tres paneles y sin gráficos decorativos;
- títulos 12–28 pt, cuerpo aproximadamente 9–10 pt y notas 7–8 pt, siempre
  comprobados en la miniatura real.

Ejemplo conciliado que originó este patrón (no reutilizar como dato de futuras
ejecuciones): 25 leads, COP $104,189 de inversión, CPA combinado COP $4,168 y
brecha de CPA 4.58×. En cada informe nuevo se deben recalcular desde su tabla.

## 6. Intentos fallidos y correcciones

### Dashboard poco informativo

**Síntoma:** la página mostraba `Interacción 0`, una serie diaria de una sola
fecha en cero y un párrafo que repetía la tabla. No explicaba el rendimiento
global de Métriku.

**Corrección:** dejar de tratar una fila vacía como tendencia; sumar los leads y
la inversión de las campañas con entrega, calcular participaciones y CPA
combinado, comparar eficiencias y terminar con una decisión accionable.

### Lote detenido antes de escribir

**Síntoma:** el primer intento de edición terminó localmente con
`ReferenceError: requiredRevisionId is not defined`.

**Causa:** el lote construyó correctamente los elementos, pero la variable del
control de revisión no coincidía con la obtenida en la lectura previa.

**Corrección:** guardar explícitamente `revisionId` desde una lectura fresca y
enviar exactamente `write_control: { requiredRevisionId: revisionId }`. El
fallo ocurrió antes de llamar a Google y no modificó la presentación.

### Respuesta excesiva al inspeccionar una página

**Síntoma:** leer e imprimir la estructura completa de la diapositiva produjo
miles de líneas y consumió contexto sin mejorar la decisión de diseño.

**Corrección:** solicitar campos parciales cuando estén disponibles y resumir
inmediatamente a `objectId`, tipo, texto, tabla, tamaño y transformación. Para
la validación posterior, recuperar solo textos y miniatura.

### Éxito técnico sin prueba visual

**Riesgo:** una operación `batchUpdate` exitosa puede dejar recortes,
solapamientos o tipografía ilegible.

**Corrección:** obtener siempre una miniatura grande después de cada piloto o
bloque, inspeccionarla visualmente y corregir antes de continuar.

## 7. Lista de comprobación por diapositiva

- [ ] La página pertenece a la copia, no al original.
- [ ] Periodo, categorías, valores y unidades coinciden con la tabla.
- [ ] Las fórmulas derivadas están documentadas y recalculadas.
- [ ] Los ceros y metas no definidas no fueron ocultados ni rellenados.
- [ ] Fondo, logotipo y marca se conservaron.
- [ ] No hay texto cortado, solapamientos ni contraste insuficiente.
- [ ] La miniatura grande fue inspeccionada después de la escritura.
- [ ] Solo se continuó más allá de los pilotos 3 y 5 tras aprobación explícita.
