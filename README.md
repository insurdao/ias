

## Nix

* [why-nix](https://medium.com/dapphub/dapp-tools-and-the-nix-package-manager-c4c692c87310)


```
openssl genrsa -des3 -passout pass:x -out keypair.key 2048

```

## Solc


* [0.8.1](https://github.com/ethereum/solidity/releases)


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
