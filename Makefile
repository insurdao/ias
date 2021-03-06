all    :; dapp --use solc:$(SOLC_VERSION) build
clean  :; dapp clean
test   :; dapp --use solc:$(SOLC_VERSION) -v test
deploy :; dapp --use solc:$(SOLC_VERSION) create Mutual

SOLC_VERSION=0.8.6

# auto-recompile [install inotify-tools before]
watch-compile:
	while inotifywait -e close_write ./src/*; do dapp --use solc:$(SOLC_VERSION) build; done

watch-test:
	while inotifywait -e close_write ./src/*; do dapp --use solc:$(SOLC_VERSION) -v test; done

optimze:
	DAPP_STANDARD_JSON="config.json" \
	DAPP_SOLC_OPTIMIZE=true \
	DAPP_SOLC_OPTIMIZE_RUNS=1 \
	SOLC_FLAGS="--optimize --optimize-runs=1" \
	dapp --use solc:$(SOLC_VERSION) build


# update nix
update-nix:
	nix-channel --update && nix-env --upgrade

# download list of layer2 networks
get-chains:
	wget -O doc/chains.json https://chainid.network/chains.json

# start node poanetwork.dev chain:99
# https://github.com/dapphub/dapptools/blob/master/src/dapp/docs/testnet.rst
testnet:
	dapp testnet --rpc-port=8545 --chain-id=42


BAT-ERC20=0x9f8cfb61d3b2af62864408dd703f9c3beb55dff7
FROM=0xc97cdc8eb17f0e79cd4080bd5eb500355bec649a
FAUCET=0x94598157fcf0715c3bc9b4a35450cce82ac57b20
balance:
	seth balance $(FROM)

decimals:
	seth call $(BAT-ERC20) 'decimals()' | seth --to-dec

faucet:
	seth send $(FAUCET) 'gulp(address)' $(FROM)

