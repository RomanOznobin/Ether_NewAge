contract Executed {
    mapping (address => uint) internal executor_list;
    address internal creator = msg.sender;
    
    modifier isExecutor {
        require (executor_list[msg.sender]>0);
        _;
    }
    
    modifier isCreator {
        require (msg.sender == creator);
        _;
    }    
    
    function AddExecutor (address _address, uint _uint) external isCreator {
        executor_list[_address] = _uint;
    }
    
    function SetCreator (address _address) external isCreator {
        creator = _address;
    }    
    
}