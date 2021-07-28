// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "ds-note/note.sol";

/*
  Vault
*/

contract Vault is DSNote{
    bool        public live;
    int         public vid;                 // Auto-increment
    string      public name;                // Group name
    address     public admin;
    address[]   public members;

    mapping (uint => List)    public list;  // vid => Prev & Next vid (double linked list)

    struct Urn {
        uint256 locked;                     // Locked Collateral [amount]
        uint256 debt;                       // Normalised Debt   [amount]
    }

    struct List {
        uint prev;
        uint next;
    }

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

    // --- Modifiers ---
    modifier auth {
        require(wards[msg.sender] == 1, "vault/not-authorized");
        _;
    }

    // --- Data ---
    mapping (bytes32 => mapping (address => uint256 )) public vaults;

    // --- Init ----
    constructor(string memory name_,
                address admin_) {

        name        = name_;
        admin       = admin_;
        live        = true;
    }


    // --- Manipulation ---
    // function fill(bytes32 index, address u) external note {
    //     require(live == true, "vault/not-live");
    //
    // }


    // --- Administration ---
    function stop() external note auth {
        live = false;
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

}
