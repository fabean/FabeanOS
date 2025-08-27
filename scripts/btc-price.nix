{ pkgs }:

pkgs.writeShellScriptBin "btc-price" ''
  #!/usr/bin/env bash
  set -euo pipefail

  URL="https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd&include_24hr_change=true"

  resp="$(${pkgs.curl}/bin/curl -fsS --max-time 3 "$URL" 2>/dev/null || true)"
  if [[ -z "$resp" ]]; then
    echo '{"text":"₿ ?","tooltip":"CoinGecko request failed"}'
    exit 0
  fi

  price=$(${pkgs.jq}/bin/jq -r '.bitcoin.usd // empty' <<<"$resp" 2>/dev/null || true)
  chg=$(${pkgs.jq}/bin/jq -r '.bitcoin.usd_24h_change // empty' <<<"$resp" 2>/dev/null || true)

  if [[ -z "$price" ]]; then
    echo '{"text":"₿ ?","tooltip":"No price in response"}'
    exit 0
  fi

  # Round price to integer; change to 1 decimal with sign
  price_i=$(printf '%.0f' "$price")

  # Handle empty change value safely
  if [ -z "$chg" ]; then
    chg_s="+0.0"
  else
    chg_s=$(printf '%+.1f' "$chg")
  fi

  text="₿ $price_i ($chg_s%)"
  tooltip="BTC/USD: $price ($chg_s% 24h)"

  printf '{"text":"%s","tooltip":"%s"}\n' "$text" "$tooltip"
''