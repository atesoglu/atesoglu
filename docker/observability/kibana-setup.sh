#!/usr/bin/env bash
set -euo pipefail

KIBANA_URL="${KIBANA_URL:-http://localhost:5601}"

echo "⌛ Waiting for Kibana at ${KIBANA_URL}..."
for _ in $(seq 1 60); do
    curl -fsS "${KIBANA_URL}/api/status" >/dev/null 2>&1 && break
    sleep 2
done
curl -fsS "${KIBANA_URL}/api/status" >/dev/null 2>&1 \
    || { echo "❌ Kibana did not become ready in time." >&2; exit 1; }

# allowNoIndex: the .NET Serilog sink creates local-logs-* later, and this 400s without it.
curl --fail-with-body -sS -X POST "${KIBANA_URL}/api/data_views/data_view" \
    -H "kbn-xsrf: true" \
    -H "Content-Type: application/json" \
    -d '{
      "override": true,
      "data_view": {
        "id": "local-logs",
        "name": "Local logs",
        "title": "local-logs-*",
        "timeFieldName": "@timestamp",
        "allowNoIndex": true
      }
    }' >/dev/null

curl --fail-with-body -sS -X POST "${KIBANA_URL}/api/data_views/default" \
    -H "kbn-xsrf: true" \
    -H "Content-Type: application/json" \
    -d '{"data_view_id": "local-logs", "force": true}' >/dev/null

echo "✅ Kibana data view 'local-logs' created and set as default."
