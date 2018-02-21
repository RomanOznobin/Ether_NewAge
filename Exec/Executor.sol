contract Manager is Executed {
    mapping ( uint => address) internal executed_list;
    uint internal last_point;
    uint internal active_point;
    address internal creator = msg.sender;
    
    modifier isExecuted (uint _target_point) {
        require (_target_point>last_point);
        _;
    }
    
    modifier isCreator {
        require (msg.sender == creator);
        _;
    }    
    
    function AddExecuted (address _address) external isCreator {
        executed_list[++last_point] = _address;
    }
    
    function SetCreator (address _address) external isCreator {
        creator = _address;
    }  
    
    function GetLastPoint () public isExecutor returns (uint) {
        return last_point;
    }
    
    function GetActivPoint () view public isExecutor returns (uint) {
        return active_point;
    }
    
    function SetActivePoint (uint _new_point) public isExecutor isExecuted(_new_point) {
        active_point = _new_point;
    }
    
    function SetNextPoint (uint _step) internal isExecuted(_step) returns (uint) {
        active_point = active_point + _step;
        if (active_point > last_point) {
            active_point = active_point - last_point;
        }
        return active_point;
    }
    
    function GetExecutedAddress () view public isExecutor returns (address) {
        return executed_list[active_point];
    }
    
}