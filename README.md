```
 _ __ _ ____ _  _ ____ ___  ____ ____
 | | \| ==== |__| |--< |__> |--| [__]

```

IAS - Insurance Autonomous System

## Introduction


* [dapp-tools-tutorial](https://medium.com/coinmonks/use-dapp-tools-for-ethereum-contract-development-2775d8b2ba0)
* [dapp-overview-video](https://www.youtube.com/watch?v=lPinWgaNceM)


Deployer and Factories are sent (deployed) to the network using seth.


## Quick Vocab

Risk Parameters:

* max claim % over the vault per claim request
* max consecutive claims per period


* wad: some quantity of tokens, usually as a fixed point integer with 10^18 decimal places.
* ray: a fixed point integer, with 10^27 decimal places.
* rad: a fixed point integer, with 10^45 decimal places.
* file: administer some configuration value
* guy, usr: some address
* ilk - collateral type, each has its own set of risk parameters [specie
    synonymous]
* valut - the solvency

* auth: check whether an address can call this method
* ward: an address that is allowed to call authed methods
* rely: allow an address to call authed methods
* deny: disallow an address from calling authed methods

* sin: anticoin tokens (system debt, not belonging to any urn)

* urn: a specific CDP
    - ink: collateral balance
    - art: outstanding stablecoin debt
* grab: liquidate a CDP
* heal: create / destroy equal quantities of stablecoin and system debt (vice)

## Dependencies

If you want to install dependencies from scratch and avoid an inter-dependency
conflict, install in this following order:

```
rm -rf lib/*
dapp install ds-note
dapp install ds-auth
```

## Actors

The main 'actors' are the vault, claim and risk. 

- Vault: has the minimum collateral to keep a member covered
- Claim: get funds from all vaults to prepare, approve or decline a claim, and
    execute its payment [see in dss how flap.sol works with vaults]
- Risk: keeps calculating the minimum in the vault members, and decided who is
    covered, notify for more deposits. It has the balance of all the vaults
    subscribed into this policy. Every vault transation notifies the risk, and
    it recalculates the minimum for all the vaults.
- Policy: a container with policies approved by the insurdao gov commitee. The
    policy terms are copied to a Group instance, and the group will also connect
    the calculation risk to a plugable risk contract. Insurdao gov will have the
    right to change the plugable risk policy [but with no access to the vaults,
    only claim contract can access it]
- Group: it joins a policy, risk, vaults. 


## Flow


The member's invitation contains the policy address this member was invited, so
when member deposits to his vault the minimum collateral, it notifies the policy
and he becomes covered. When his vault becomes under-collaterized, 

- Broker creates policy instance
- Broker adds claim-adjuster
- Broker invites members
- Member deposits $ in vaults
- Member authorizes policy template to debit from vault
- Policy checks if it has minimum cash to start


## Code Style [original](https://github.com/makerdao/dss/blob/master/DEVELOPING.md)

This is obviously opinionated and you may even disagree, but here are the considerations that make this code look like it does:

* Distinct things should have distinct names ("memes")
* Lack of symmetry and typographic alignment is a code smell.
* Inheritance masks complexity and encourages over abstraction, be explicit about what you want.
* In this modular system, contracts generally shouldn't call or jump into themselves, except for math. Again, this masks complexity.


## Best Practices

* [contract-size-limit](https://soliditydeveloper.com/max-contract-size)

## ERC20


* [eip-712-intro](https://medium.com/metamask/eip712-is-coming-what-to-expect-and-how-to-use-it-bb92fd1a7a26)
* [eip-712](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-712.md)

## Nix

* [why-nix](https://medium.com/dapphub/dapp-tools-and-the-nix-package-manager-c4c692c87310)


```
openssl genrsa -des3 -passout pass:x -out keypair.key 2048

```

## Dapp Tools

* [dapp-tools](https://github.com/dapphub/dapptools)
* [test-script-example](https://github.com/alext234/crypto-zombies-l5/blob/master/testnet_script.sh)


```
# install 0.8.3 compiler
`nix-env -f https://github.com/dapphub/dapptools/archive/master.tar.gz -iA solc-static-versions.solc_0_8_3`

# upgrade
nix-channel --update && nix-env --upgrade

# testnet [point to the test account]
dapp testnet
export ETH_KEYSTORE=$HOME/sec/wallets/kovan
export ETH_PASSWORD=$HOME/sec/wallets/kovan/pass
export SETH_CHAIN=poa
export chainid=$(seth --to-uint256 99)
export ETH_GAS=3500000
export ETH_RPC_URL=http://localhost
export ETH_RPC_PORT=8545
export ETH_FROM=$(cat ~/.dapp/testnet/8545/config/account)


# send from
export FROM=0x92e0ac9dCa97491838871fbaA18f85437711F832
export TO=0x0cde80AD77Ab131510036A72b012a4A0F26C2ACC
seth --to-wei 100 eth | xargs -I{} seth send --value {} -F $FROM $TO
```

## Architecture


* [state-machine](https://fravoll.github.io/solidity-patterns/state_machine.html)
* [contract-interactions](https://ethereumdev.io/interact-with-other-contracts-from-solidity/)
* [struct-or-child-contract](https://ethereum.stackexchange.com/questions/8615/child-contract-vs-struct/8620)

## Solc


* [0.8.3](https://github.com/ethereum/solidity/releases)


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

# add solc 0.8.3
nix-env -iA solc-versions.solc_0_8_3 \
  -if https://github.com/dapphub/dapptools/tarball/master

# add solc 0.7.6
nix-env -iA solc-versions.solc_0_7_4 \
  -if https://github.com/dapphub/dapptools/tarball/master
```

## Testnet

```
# start the testnet 
dapp testnet

# clean genesis and chain data
rm -rf ~/.dapp/testnet
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



## Design Considerations

- Token agnostic

  - system doesn't care about the implementation of external tokens
  - can operate entirely independently of other systems.

- Verifiable

  - designed from the bottom up to be amenable to formal verification
  - the core and balance database makes _no_ external calls and
    contains _no_ precision loss (i.e. no division)

- Modular
  - multi contract core system is made to be very adaptable to changing
    requirements.
  - allows for implementations of e.g. auctions, liquidation, risk
    conditions, to be altered on a live system.
  - allows for the addition of novel collateral types



## Authentication

The contracts here use a very simple multi-owner authentication system,
where a contract totally trusts multiple other contracts to call its
functions and configure it.

It is expected that modification of this state will be via an interface
that is used by the Governance layer.



## Resources


* [poa-testnet](https://www.poa.network/for-users/wallets/metamask)
* [chainids-networks](https://ethereum.stackexchange.com/questions/17051/how-to-select-a-network-id-or-is-there-a-list-of-network-ids/17101)
* [inside-a-transaction](https://medium.com/@codetractio/inside-an-ethereum-transaction-fa94ffca912f)
* [cheat-sheet](https://manojpramesh.github.io/solidity-cheatsheet/)
* [makerdao](https://github.com/makerdao)


