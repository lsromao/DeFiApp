pragma solidity^0.5.0;

import "./DappToken.sol";
import "./DaiToken.sol";

contract TokenFarm{
    string public name = "Rondinha Token Farm";
    DappToken public dappToken;
    DaiToken public daiToken;
    address owner;

    address[] public stakers;

    mapping(address => uint) public stakingBalance;
    mapping(address => bool) public hasStaked;
    mapping(address => bool) public isStaking;

    constructor(DappToken _dappToken, DaiToken _daiToken) public{
        dappToken = _dappToken;
        daiToken = _daiToken;
        owner = msg.sender;
    }

    // Stake Tokens (deposit)
    function stakeTokens(uint _amount) public{
        // Stake must be greater than 0 
        require(_amount > 0, "amount cannot be 0");

        //Transfer Mock Dai tokens to this contract for staking
        daiToken.transferFrom(msg.sender, address(this), _amount);

        //Update stake balance
        stakingBalance[msg.sender] = stakingBalance[msg.sender] + _amount; 

        //Add user to stake array  only if they haven't staked
        if(!hasStaked[msg.sender]){
            stakers.push(msg.sender);
            
        }

        //Update stake status
        isStaking[msg.sender] = true;
        hasStaked[msg.sender] = true;

        
        
    }

    // Unstaking Tokens (withdraw)

    // Issuing Tokens 
    function issueTokens() public {
        require(msg.sender == owner, "only owner can call this function");

        for (uint i=0; i < stakers.length; i++){
            address recipient = stakers[i];
            uint balance = stakingBalance[recipient];

            if(balance > 0){
                dappToken.transfer(recipient, balance);
            }
            
        }
    }

}



