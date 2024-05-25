
// SPDX-License-Identifier: MIT
pragma solidity >=0.8.25;

import "https://github.com/aave/aave-v3-core/blob/master/contracts/flashloan/base/FlashLoanSimpleReceiverBase.sol";
import "https://github.com/aave/aave-v3-core/blob/master/contracts/interfaces/IPoolAddressesProvider.sol";
import "https://github.com/aave/aave-v3-core/blob/master/contracts/dependencies/openzeppelin/contracts/IERC20.sol";




contract SimpleFlashLoan is FlashLoanSimpleReceiverBase {

    //The account (EOA) that
    address payable owner;

    //_addressProvider is the address of the lending Pool and is offered by IPoolAddressesProvider.sol
    constructor(address _addressProvider)
    FlashLoanSimpleReceiverBase(IPoolAddressesProvider(_addressProvider))
    {
    }

    function fn_requestFlashLoan(address _token, uint256 _amount) public {
        address receiverAddress = address(this);
        address asset = _token;
        uint256 amount = _amount;
        bytes memory params = "";
        uint16 referralCode = 0;

        POOL.flashLoanSimple(receiverAddress, asset, amount, params, referralCode);

    }

    function executeOperation(address asset, uint256 amount, uint256 premium, address initiator, bytes calldata params) external override returns (bool) {

    }
}
