all    :; dapp --use solc:0.8.0 build
clean  :; dapp clean
test   :; dapp --use solc:0.8.0 test
dkeeploy :; dapp --use solc:0.8.0 create Mutual


optimze:
	DAPP_STANDARD_JSON="config.json" \
	DAPP_SOLC_OPTIMIZE=true \
	DAPP_SOLC_OPTIMIZE_RUNS=1 \
	SOLC_FLAGS="--optimize --optimize-runs=1" \
	dapp --use solc:0.8.1 build



update-nix:
	nix-channel --update && nix-env --upgrade


testnet:
	dapp testnet
