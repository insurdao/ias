// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "ds-note/note.sol";


/// keep the collateral in the vault, and keep a list of policies that every user
/// is participating, so every change in the balance will broadcast the balance
/// to all policies. To join a group is simple as exposing the vault to be debited
/// from that group


contract Group is DSNote {
    string      public name;                // Group name
    address     public manager;
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

    // --- MODIFIERS ---
    modifier auth {
        require(wards[msg.sender] == 1, "group/not-authorized");
        _;
    }

    // --- DATA ---

    struct Vault {
        uint256 ink;   // Locked Collateral  [wad]
        uint256 art;   // Normalised Debt    [wad]
    }


    mapping (bytes32 => mapping (address => Vault )) public vaults;

    // --- INIT ----
    constructor(string memory name_,
                address manager_) {

        name        = name_;
        manager     = manager_;
    }



    // --- MATH ---

    function either(bool x, bool y) internal pure returns (bool z) {
        assembly{ z := or(x, y)}
    }
    function both(bool x, bool y) internal pure returns (bool z) {
        assembly{ z := and(x, y)}
    }

}
