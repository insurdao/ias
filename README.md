



## Solc


* [0.8.1](https://github.com/ethereum/solidity/releases)


## Dapp Tools

* [nix-os](https://nixos.org/download.html) - NIX dependency management 
* [dapp-tools](http://dapp.tools) - Solidity | Ethereum tools

```
# install NIX tools
curl -L https://nixos.org/nix/install | sh

# install dapp tools
curl https://dapp.tools/install | sh
. "$HOME/.nix-profile/etc/profile.d/nix.sh"
nix-env -iA dapp hevm seth solc -if https://github.com/dapphub/dapptools/tarball/master --substituters https://dapp.cachix.org --trusted-public-keys dapp.cachix.org-1:9GJt9Ja8IQwR7YW/aF0QvCa6OmjGmsKoZIist0dG+Rs=
```
