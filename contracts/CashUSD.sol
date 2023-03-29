// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Import OpenZeppelin contracts
import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/security/PausableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol";

contract CashUSD is Initializable, ERC20Upgradeable, PausableUpgradeable, ReentrancyGuardUpgradeable {
    string private _name;
    string private _symbol;
    uint8 private _decimals;
    uint256 private _initSupply;

    mapping(address => bool) private _blocked;

    address private _owner;

    modifier onlyOwner() {
        require(msg.sender == _owner, "Caller is not the owner");
        _;
    }

    function initialize(string memory name_, string memory symbol_) public initializer {
        __ERC20_init(name_, symbol_);
        __Pausable_init();
        __ReentrancyGuard_init();

        _name = name_;
        _symbol = symbol_;
        _decimals = 18;
        _initSupply = 10_000_000_000 * 10 ** 18; // 1,000,000.00 Tokens
        _mint(msg.sender, _initSupply);

        _owner = msg.sender;
    }

    function transfer(address recipient, uint256 amount) public override(ERC20Upgradeable) whenNotPaused() nonReentrant() returns (bool) {
        require(!_blocked[msg.sender], "Sender account is blocked");
        require(!_blocked[recipient], "Recipient account is blocked");
        return super.transfer(recipient, amount);
    }

    function transferFrom(address sender, address recipient, uint256 amount) public override(ERC20Upgradeable) whenNotPaused() nonReentrant() returns (bool) {
        require(!_blocked[sender], "Sender account is blocked");
        require(!_blocked[recipient], "Recipient account is blocked");
        return super.transferFrom(sender, recipient, amount);
    }

    function approve(address spender, uint256 amount) public override(ERC20Upgradeable) whenNotPaused() nonReentrant() returns (bool) {
    require(!_blocked[msg.sender], "Sender account is blocked");
    require(!_blocked[spender], "Spender account is blocked");
    return super.approve(spender, amount);
}

function increaseAllowance(address spender, uint256 addedValue) public override(ERC20Upgradeable) whenNotPaused() nonReentrant() returns (bool) {
    require(!_blocked[msg.sender], "Sender account is blocked");
    require(!_blocked[spender], "Spender account is blocked");
    return super.increaseAllowance(spender, addedValue);
}

function decreaseAllowance(address spender, uint256 subtractedValue) public override(ERC20Upgradeable) whenNotPaused() nonReentrant() returns (bool) {
    require(!_blocked[msg.sender], "Sender account is blocked");
    require(!_blocked[spender], "Spender account is blocked");
    return super.decreaseAllowance(spender, subtractedValue);
}

function blockAccount(address account) public onlyOwner {
    require(account != address(0), "Invalid address");
    require(!_blocked[account], "Account is already blocked");
    _blocked[account] = true;
    emit AccountBlocked(account);
}

function unblockAccount(address account) public onlyOwner {
    require(account != address(0), "Invalid address");
    require(_blocked[account], "Account is not blocked");
    _blocked[account] = false;
    emit AccountUnblocked(account);
}

event AccountBlocked(address indexed account);
event AccountUnblocked(address indexed account);
}