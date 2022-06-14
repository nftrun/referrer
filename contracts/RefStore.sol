// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "./IRefStore.sol";

contract RefStore is IRefStore, AccessControl {
    bytes32 public constant APPEND_ROLE = keccak256("APPEND_ROLE");
    /// @dev referrer[user] => user
    mapping(address => address) public override referrer;

    constructor() {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(APPEND_ROLE, msg.sender);
    }

    ///
    function addReferrer(address from, address to) external override {
        require(referrer[msg.sender] == address(0), 'addReferrer: alreday add!');
        require(hasRole(APPEND_ROLE, msg.sender), "Caller can not append referrer!");
        referrer[from] = to;
        emit ReferrerAdded(to, from);
    }
}