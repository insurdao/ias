// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

import "ds-test/test.sol";

import "../policy.sol";

contract PolicyTest is DSTest {
    Policy policy;

    // function setUp() public {
    //     policy = new Policy("car", 100, 100, 100, 100, 100, 100);
    // }

    function testSucceed_sanity() public {
        assertTrue(true);
    }
}
