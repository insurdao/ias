// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "ds-note/note.sol";

/*
The single source of truth for the Insurdao Protocol. It contains the accounting system of
the core Vault, internal balances for each memeber, and collateral state. The Vault has no external dependencies
and maintains the central "Accounting Invariants" of the Insurdao  Protocol. It houses the public
interface for Vault management, allowing urn (Vault) owners to adjust their Vault state balances.
It also contains the public interface for Vault fungibility, allowing urn (Vault) owners to transfer,
split, and merge Vaults. Excluding these interfaces, the Vault is accessed through trusted smart
contract modules. Every vault will have a mutuality treasury, and keep tracking of every deposit and member
ledger cashflows, facilitating audit, emergency shutdown and disolution.
*/

contract Vault is DSNote{
    int         public live;
    address[]   public members;

    // --- Auth ---
    mapping (address => uint256) public wards;
    function rely(address usr) external note auth { wards[usr] = 1; }
    function deny(address usr) external note auth { wards[usr] = 0; }

    mapping(address => mapping (address => uint)) public can;
    function hope(address usr) external note { can[msg.sender][usr] = 1; }
    function nope(address usr) external note { can[msg.sender][usr] = 0; }
    function wish(address bit, address usr) internal view returns (bool) {
        return either(bit == usr, can[bit][usr] == 1);
    }

    // --- Data ---
    struct Ilk {
        uint256 tot;    // Total Locked From Vaults [wad]
        uint256 floor;  // Max Claim Withdraw     [percent]
    }


    mapping (bytes32 => Ilk)                        public ilks;
    mapping (bytes32 => mapping (address => uint))  public gems;
    mapping (bytes32 => mapping (address => uint))  public jail;  // [wad]


    // --- Modifiers ---
    modifier auth {
        require(wards[msg.sender] == 1, "vault/not-authorized");
        _;
    }

    // --- Init ----
    constructor() {
        wards[msg.sender] = 1;
        live = 1;
    }

    // --- Administration ---
    // function init()
    // function file() // set cap for ilk
    function stop() external note auth {
        live = 0;
    }


    // --- Math ---
    function either(bool x, bool y) internal pure returns (bool z) {
        assembly{ z := or(x, y)}
    }
    function both(bool x, bool y) internal pure returns (bool z) {
        assembly{ z := and(x, y)}
    }
    function add(uint x, int y) internal pure returns (uint z) {
        z = x + uint(y);
        require(y >= 0 || z <= x);
        require(y <= 0 || z >= x);
    }
    function sub(uint x, int y) internal pure returns (uint z) {
        z = x - uint(y);
        require(y <= 0 || z <= x);
        require(y >= 0 || z >= x);
    }
    function mul(uint x, int y) internal pure returns (int z) {
        z = int(x) * y;
        require(int(x) >= 0);
        require(y == 0 || z / y == int(x));
    }
    function add(uint x, uint y) internal pure returns (uint z) {
        require((z = x + y) >= x);
    }
    function sub(uint x, uint y) internal pure returns (uint z) {
        require((z = x - y) <= x);
    }
    function mul(uint x, uint y) internal pure returns (uint z) {
        require(y == 0 || (z = x * y) / y == x);
    }


    // function lock - lock collateral to pay a claim into a jail
    // function free - unlock unused claim from jail
    // function pick - only claim contract and stop shutdown can grab from locked

}
