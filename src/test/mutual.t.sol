// SPDX-License-Identifier: MIT

pragma solidity >=0.8.1;

import "ds-test/test.sol";

import "../mutual.sol";

contract MutualTest is DSTest {
    Mutual mutual;

    function setUp() public {
        mutual = new Mutual();
    }

    function testFail_basic_sanity() public {
        assertTrue(false);
    }

    function test_basic_sanity() public {
        assertTrue(true);
    }
}
