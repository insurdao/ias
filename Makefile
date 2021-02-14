all    :; dapp --use solc:0.8.1 build
clean  :; dapp clean
test   :; dapp --use solc:0.8.1 test
deploy :; dapp --use solc:0.8.1 create WepyContracts


optimze:
	DAPP_STANDARD_JSON="config.json" \
	DAPP_SOLC_OPTIMIZE=true \
	DAPP_SOLC_OPTIMIZE_RUNS=1 \
	SOLC_FLAGS="--optimize --optimize-runs=1" \
	dapp --use solc:0.7.4 build
