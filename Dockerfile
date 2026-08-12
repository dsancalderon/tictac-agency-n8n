FROM n8nio/n8n:2.32.6@sha256:5f7856f4fc7cd935230f7596e39fdb3d5eda0e379c5b40b699b9c0eb35ebd0bf

# n8n 2.32.6 todavía apunta el nodo oficial de Google Ads a la API v21,
# retirada por Google en agosto de 2026. Se conserva la versión estable de n8n
# y se actualizan únicamente las rutas compiladas del nodo a v25. En v25,
# metrics.video_views fue reemplazado por metrics.video_trueview_views.
USER root
RUN GOOGLE_ADS_NODE_DIR=/usr/local/lib/node_modules/n8n/node_modules/n8n-nodes-base/dist/nodes/Google/Ads \
    && CAMPAIGN_FILE="$GOOGLE_ADS_NODE_DIR/CampaignDescription.js" \
    && NODE_FILE="$GOOGLE_ADS_NODE_DIR/GoogleAds.node.js" \
    && test -f "$CAMPAIGN_FILE" \
    && test -f "$NODE_FILE" \
    && grep -q '/v21/' "$CAMPAIGN_FILE" \
    && grep -q '/v21/' "$NODE_FILE" \
    && sed -i 's#/v21/#/v25/#g; s#metrics.video_views#metrics.video_trueview_views#g' "$CAMPAIGN_FILE" "$NODE_FILE" \
    && ! grep -q '/v21/' "$CAMPAIGN_FILE" "$NODE_FILE" \
    && ! grep -q 'metrics.video_views' "$CAMPAIGN_FILE" "$NODE_FILE"
USER node

ENV N8N_HOST=0.0.0.0
ENV N8N_LISTEN_ADDRESS=0.0.0.0
ENV N8N_PORT=5678
ENV PORT=5678
ENV N8N_PROTOCOL=https
ENV GENERIC_TIMEZONE=America/Bogota
ENV TZ=America/Bogota
ENV N8N_RUNNERS_ENABLED=false
ENV N8N_PERSONALIZATION_ENABLED=false
ENV N8N_METRICS=false
ENV NODE_OPTIONS="--max-old-space-size=380"

EXPOSE 5678
