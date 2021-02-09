all    :; dapp --use solc:0.8.1 build
clean  :; dapp clean
test   :; dapp --use solc:0.8.1 test
deploy :; dapp --use solc:0.8.1 create WepyContracts
