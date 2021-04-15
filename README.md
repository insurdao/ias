
```
 _ __ _ ____ _  _ ____ ___  ____ ____
 | | \| ==== |__| |--< |__> |--| [__]

```

## Code Style [original](https://github.com/makerdao/dss/blob/master/DEVELOPING.md)

This is obviously opinionated and you may even disagree, but here are the considerations that make this code look like it does:

* Distinct things should have distinct names ("memes")
* Lack of symmetry and typographic alignment is a code smell.
* Inheritance masks complexity and encourages over abstraction, be explicit about what you want.
* In this modular system, contracts generally shouldn't call or jump into themselves, except for math. Again, this masks complexity.


## Best Practices

* [contract-size-limit](https://soliditydeveloper.com/max-contract-size)

## ERC20


Dai [dai.sol] in makerdao repo has a nice ERC20 implementation, maybe we can
follow it.

* [eip-712-intro](https://medium.com/metamask/eip712-is-coming-what-to-expect-and-how-to-use-it-bb92fd1a7a26)
* [eip-712](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-712.md)

## Nix

* [why-nix](https://medium.com/dapphub/dapp-tools-and-the-nix-package-manager-c4c692c87310)


```
openssl genrsa -des3 -passout pass:x -out keypair.key 2048

```


## Architecture

* [state-machine](https://fravoll.github.io/solidity-patterns/state_machine.html)
* [contract-interactions](https://ethereumdev.io/interact-with-other-contracts-from-solidity/)
* [struct-or-child-contract](https://ethereum.stackexchange.com/questions/8615/child-contract-vs-struct/8620)

## Solc


* [0.8.1](https://github.com/ethereum/solidity/releases)


## Optimizations

* [struct](https://medium.com/@novablitz/storing-structs-is-costing-you-gas-774da988895e)
* [gas-optimization](https://medium.com/coinmonks/gas-optimization-in-solidity-part-i-variables-9d5775e43dde)

## Assembly

* [all-assembly](https://medium.com/@jeancvllr/solidity-tutorial-all-about-assembly-5acdfefde05c)
* [evm-intro](https://medium.com/0xcode/the-ethereum-virtual-machine-evm-runtime-environment-d7969544d3dd)
* [string-utils](https://github.com/Arachnid/solidity-stringutils/blob/master/src/strings.sol)
* [bytes-lib](https://github.com/GNSPS/solidity-bytes-utils/blob/master/contracts/BytesLib.sol)

## Dapp Tools

* [nix-os](https://nixos.org/download.html) - NIX dependency management 
* [dapp-tools](http://dapp.tools) - Solidity | Ethereum tools
* [daap-solc](https://xscode.com/dapphub/dapptools) - How to install 

```
# install NIX tools
curl -L https://nixos.org/nix/install | sh

# download dapp tools
curl https://dapp.tools/install | sh
. "$HOME/.nix-profile/etc/profile.d/nix.sh"

# install daap tools
nix-env -iA dapp hevm seth solc \
  -if https://github.com/dapphub/dapptools/tarball/master \
  --substituters https://dapp.cachix.org \
  --trusted-public-keys dapp.cachix.org-1:9GJt9Ja8IQwR7YW/aF0QvCa6OmjGmsKoZIist0dG+Rs=

# add solc 0.8.1
nix-env -iA solc-versions.solc_0_8_1 \
  -if https://github.com/dapphub/dapptools/tarball/master

# add solc 0.7.6
nix-env -iA solc-versions.solc_0_7_4 \
  -if https://github.com/dapphub/dapptools/tarball/master
```


## Seth

* [seth-examples](https://docs.makerdao.com/clis/seth)

```
export ETH_KEYSTORE=<path to your keystore folder>
export ETH_PASSWORD=<path and filename to the text file containing the password for your account e.g: /home/one1up/MakerDAO/415pass >
export ETH_FROM=0x540981Ec05a00F70d503C528428119c2caA3CE95
export SETH_CHAIN=kovan
```


## Calls


```
seth balance 0x0cde80AD77Ab131510036A72b012a4A0F26C2ACC

seth send --value 0.1  0xfB6916095ca1df60bB79Ce92cE3Ea74c37c5d359
```


## Governance

* [security-and-gov](https://medium.com/coinmonks/voting-and-governance-in-security-tokens-1e3d041dabb8)
* [gov-types](https://blog.makerdao.com/the-different-types-of-cryptocurrency-tokens-explained/)
* [voting-example](https://github.com/xdaichain/voting-dapp-contracts/tree/master/contracts)

## Ethereum


* [poa-testnet](https://www.poa.network/for-users/wallets/metamask)
* [chainids-networks](https://ethereum.stackexchange.com/questions/17051/how-to-select-a-network-id-or-is-there-a-list-of-network-ids/17101)
* [inside-a-transaction](https://medium.com/@codetractio/inside-an-ethereum-transaction-fa94ffca912f)
* [cheat-sheet](https://manojpramesh.github.io/solidity-cheatsheet/)
