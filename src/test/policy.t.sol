// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

import "ds-test/test.sol";

import "../policy.sol";

contract PolicyTest is DSTest {
    Policy policy;

    function setUp() public {
        policy = new Policy("car", 100, 10, 5);
    }

    function testSuccess_setPayout() public {
        policy.setPayout(3);
        assertEq(3, policy.payout(), "not same payout");
    }

    function testSucceed_sanity() public {
        assertTrue(true);
    }
}
