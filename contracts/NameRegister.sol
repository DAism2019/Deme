//本合约用来注册用户名，是独立于文章系统的
pragma solidity ^0.5.0;
contract NameRegister {
    mapping (string => address) private useraddress;
    mapping (address => string) private username;
    mapping (address => bool) private isRigster;
    event RegisterNameSuc(address indexed user,string name);

    //不可重复注册
    function regiser(string memory _name) public  {
        require(useraddress[_name] == address(0),'Name has registered');
        require(!isRigster[msg.sender],"Address has a name");
        username[msg.sender] = _name;
        useraddress[_name] = msg.sender;
        isRigster[msg.sender] = true;
        emit RegisterNameSuc(msg.sender,_name);
    }

    function getUsername(address _user) public view returns(string memory){
        return username[_user];
    }

    function getUserAddress(string memory _name) public view returns(address){
        return useraddress[_name];
    }
}
