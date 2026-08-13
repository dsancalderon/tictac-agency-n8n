# Línea base de credenciales

Última revisión: 2026-08-13

## Estado confirmado

- La instancia operativa es `https://n8n-gafas-antioquia.onrender.com`.
- La instancia conserva cuatro workflows productivos y todos figuran activos.
- El repositorio ya ignora `.env`, archivos JSON de workflows y documentos `*_HANDOFF.md`.
- Los workflows locales consumen `YCLOUD_API_KEY` desde el entorno en lugar de guardar su valor literal.
- La clave de YCloud apareció en el historial Git y debe considerarse comprometida.
- Los tokens de Meta y n8n estuvieron presentes en un handoff histórico. Aunque ese archivo no está versionado, cualquier token histórico expuesto debe permanecer revocado.
- Meta Ads usa la credencial cifrada `Meta Ads - Kinku`; el token no aparece en el workflow exportado ni en la documentación versionada.
- Los webhooks actuales filtran tipos de evento, pero todavía no validan criptográficamente la firma del emisor.
- La aceptación `2746` compartió únicamente el informe final autorizado como
  `anyoneWithLink`, rol `reader` y sin descubrimiento. La plantilla productiva y
  la copia privada de validación no se hicieron públicas.

## Fuente autorizada de cada secreto

| Secreto | Almacenamiento objetivo | No debe aparecer en |
|:---|:---|:---|
| `YCLOUD_API_KEY` | Render Secret / entorno de n8n | Git, workflow exportado, documentación |
| `YCLOUD_WEBHOOK_SECRET` | Render Secret / entorno de n8n | Git, logs, documentación |
| `META_ACCESS_TOKEN` | Render Secret o credencial cifrada de n8n | Git, workflow exportado, documentación |
| `META_VERIFY_TOKEN` | Render Secret | Git, documentación pública |
| `N8N_API_KEY` | Gestor local seguro para administración | Git, Render Blueprint, documentación |
| `N8N_ENCRYPTION_KEY` | Render Secret persistente | Git; nunca regenerarla durante un redeploy |
| `OPENWA_API_KEY` | `.env` local o gestor de secretos | Compose versionado, documentación |

## Orden de rotación sin interrumpir el servicio

1. Programar una ventana controlada o usar pruebas manuales aisladas antes de modificar un workflow activo.
2. Generar una nueva clave de YCloud sin revocar todavía la anterior.
3. Guardar la nueva clave como `YCLOUD_API_KEY` en Render y desplegar.
4. Confirmar desde n8n que el nodo de salida usa la variable de entorno y realizar una prueba controlada.
5. Revocar la clave anterior de YCloud.
6. Mantener el token del usuario de sistema de Meta con privilegios mínimos (`ads_read`) dentro de la credencial cifrada de n8n.
7. Revocar cualquier token histórico de Meta que haya sido expuesto anteriormente.
8. Regenerar la API key administrativa de n8n y actualizar únicamente el almacén local autorizado.
9. Rotar el secreto del webhook de YCloud e implementar validación de firma antes de reactivar producción.
10. Activar el workflow y verificar un mensaje entrante, una confirmación de estado y un mensaje saliente.

## Criterios para considerar estable la línea base

- Ningún valor secreto aparece en archivos versionados ni exportaciones de workflows.
- El health check responde `200` en la URL canónica.
- El workflow activo utiliza secretos externos o credenciales cifradas de n8n.
- Los webhooks rechazan firmas inválidas y conservan el filtro anti-bucle.
- Una prueba controlada produce una sola respuesta y no genera ejecuciones recursivas.
- Las claves anteriores quedan revocadas después de verificar las nuevas.

## Tratamiento del informe y de la IA externa

- El Slides generado contiene información operativa de campañas. Compartir
  cada informe solo con el alcance expresamente autorizado; no ampliar permisos
  de la plantilla ni de los respaldos.
- Antigravity debe trabajar sobre una copia del informe fuente. El artefacto de
  la ejecución `2746` permanece como evidencia inmutable de los datos recibidos.
- No entregar a la IA credenciales de n8n, Meta, Google Ads, YCloud, HubSpot ni
  archivos `.env`. Para esta fase solo necesita el Slides editable y el handoff.
- No copiar tokens, IDs de credenciales cifradas ni payloads privados dentro de
  notas, análisis o comentarios de la presentación.
- Antes de compartir la versión enriquecida, revisar visualmente las 29
  diapositivas, comprobar que no se inventaron cifras y otorgar como máximo
  permiso de lector salvo autorización distinta.

## Nota sobre el historial Git

Eliminar un secreto del archivo actual no lo elimina de commits anteriores. La mitigación obligatoria es rotarlo. Reescribir el historial puede evaluarse después, pero no sustituye la rotación y afectaría a cualquier clon existente.
