// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "@openzeppelin/contracts/governance/TimelockController.sol";

/**
 * - minDelay -> seconds every scheduled action must wait :u
 * - proposers -> addresses allowed to schedule/cancel actions
 * - executors -> addresses allowed to execute ready actions
 * - admin -> manages role assignment from the start
 */

contract TsakiTimelock is TimelockController {
    constructor(
        uint256 minDelay,
        address[] memory proposers,
        address[] memory executors,
        address admin
    ) TimelockController(minDelay, proposers, executors, admin) {}
}
