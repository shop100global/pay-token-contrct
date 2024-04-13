// SPDX-License-Identifier: MIT
// pragma solidity ^0.8.4;
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/// @custom:security-contact security@100pay.co
contract PayToken is ERC20, ERC20Burnable, Pausable, Ownable, ERC20Capped {
    uint256 private cap_;

    constructor(
        string memory _name, 
        string memory _symbol,
        uint256 initialSupply,
        uint256 _cap
    )
    ERC20(_name, _symbol) ERC20Capped(_cap) 
    {
        cap_ = _cap;
        _mint(msg.sender, initialSupply);
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount)
        internal
        whenNotPaused
        override
    {
        super._beforeTokenTransfer(from, to, amount);
    }

    function _mint(address to, uint256 amount)
        internal
        override(ERC20, ERC20Capped)
    {
        require(totalSupply() + amount <= cap_, "Max number of tokens minted");
        super._mint(to, amount);
    }
}
