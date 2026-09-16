#!/bin/sh

TARGET=${TARGET:-http://web}

while true; do
  tidspunkt=$(date -u '+%Y-%m-%dT%H:%M:%SZ')
  fejlkode=0

resultat=$(curl --silent --show-error \
    --max-time 3 \
    --output /dev/null \
    --write-out '%{http_code} %{time_total}' \
    "$TARGET") || fejlkode=$?

  status=$(echo "$resultat" | cut -d ' ' -f 1)
  svartid=$(echo "$resultat" | cut -d ' ' -f 2)

  if [ "$fejlkode" -ne 0 ]; then
    besked="NEDE: forbindelsesfejl eller timeout"
  elif [ "$status" != "200" ]; then
    besked="FEJL: serveren returnerede HTTP $status"
  elif awk -v tid="$svartid" 'BEGIN { exit !(tid >= 1) }'; then
    besked="LANGSOM: svaret tog mindst 1 sekund"
  else
    besked="OK"
  fi

  echo "$tidspunkt | $besked | Status: $status | Tid: ${svartid}s | Curl-fejl: $fejlkode" \
    | tee -a /app/checks.log

  sleep 5
done