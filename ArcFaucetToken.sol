// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ArcFaucetToken {
    string public name = "Arc Builder Token";
    string public symbol = "ABT";
    uint8 public decimals = 18;
    uint256 public totalSupply;

    uint256 public constant FAUCET_AMOUNT = 100 * 10**18;
    uint256 public constant COOLDOWN_TIME = 24 hours;

    mapping(address => uint256) private balances;
    mapping(address => uint256) public lastClaimAt;

    event Transfer(address indexed from, address indexed to, uint256 value);

    constructor() {
        _mint(msg.sender, 1000000 * 10**18);
    }

    function balanceOf(address account) external view returns (uint256) {
        return balances[account];
    }

    function requestTokens() external {
        require(
            block.timestamp >= lastClaimAt[msg.sender] + COOLDOWN_TIME,
            "Faucet: Voce deve aguardar 24 horas entre os resgates."
        );

        lastClaimAt[msg.sender] = block.timestamp;
        _mint(msg.sender, FAUCET_AMOUNT);
    }

    function getTimeUntilNextClaim(address user) external view returns (uint256) {
        uint256 nextClaimTime = lastClaimAt[user] + COOLDOWN_TIME;
        if (block.timestamp >= nextClaimTime) {
            return 0;
        } else {
            return nextClaimTime - block.timestamp;
        }
    }

    function _mint(address account, uint256 amount) internal {
        require(account != address(0), "Endereco invalido");
        totalSupply += amount;
        balances[account] += amount;
        emit Transfer(address(0), account, amount);
    }
}
