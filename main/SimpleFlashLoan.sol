
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

    function fn_requestFlashLoan(
        address _token, 
        uint256 _amount
    ) public {
        //receiverAddress is the address of the account receiving the flashloan. This is the address of this smart contract.
        //asset corresponds to the IERC20 token
        //amount refers to the amount of the tokens to be borrowed
        //params and referralCode won't be used in this code. They are required by the AAVE flashloan interface
        address receiverAddress = address(this);
        address asset = _token;
        uint256 amount = _amount;
        bytes memory params = "";
        uint16 referralCode = 0;

        //This function finally requests the flash loan
        POOL.flashLoanSimple(receiverAddress, asset, amount, params, referralCode);
    }

    //This function is called after the contract has received the flash loan. This functions performs the desired logic with 
    //the flash loan and finally pays the flash loan back
    /*
    @param assets The addresses of the flash-borrowed assets
    * @param amounts The amounts of the flash-borrowed assets
    * @param premiums The fee of each flash-borrowed asset
    * @param initiator The address of the flashloan initiator
    * @param params The byte-encoded params passed when initiating the flashloan
    * @return True if the execution of the operation succeeds, false otherwise
    */
    function executeOperation(
        address asset, 
        uint256 amount, 
        uint256 premium, 
        address initiator, 
        bytes calldata params
    ) external override returns (bool) {

        //Logic to be performed before repaying the flash loan goes here

        //Here, the flash loan is paid back:
        //Calculates the total amount to be paid back to the lender
        uint256 totalAmount = amount + premium;
        //We're approving the IERC20 token with the lending pool such that we can interact with the lending pool for that particular token
        IERC20(asset).approve(address(POOL), totalAmount);
        
        return true;
    }

    receive() external payable { }
}
