/**
* A interface to save code of svg in ethereum indexed by it's hash
* 本合约用来使用hash来注册SVG图片，是独立于文章存储系统的
**/
pragma solidity ^0.5.0;

contract SvgHash {

    mapping(string => bool)  _hashStatus;
    mapping(string => string) _hashCode;
    mapping(address => string[]) _userHashs;

    event AddSvgCode(address indexed user,string hash,uint256 amount);

    /**
    * @dev Return the existing of a svg hash
    **/
    function hasCode(string memory _hash) public view returns(bool){
        return _hashStatus[_hash];
    }

    /**
    * @dev Get the code of svg by it's hash
    **/
    function getCode(string memory _hash) public view returns(string memory){
        return _hashCode[_hash];
    }

    /**
    * @dev Set the code of svg by it's hash
    **/
    function addCode(string memory _hash,string memory _code) public returns(bool){
        bool flag = hasCode(_hash);
        require(!flag,'hash has code');
        _hashStatus[_hash] = true;
        _hashCode[_hash] = _code;
        _userHashs[msg.sender].push(_hash);
        emit AddSvgCode(msg.sender,_hash,_userHashs[msg.sender].length);
        return true;
    }

    /**
    * @dev Get the amount of svg uploaded by user
    **/
    function getUserSvgAmount(address user) public view returns(uint256){
        return _userHashs[user].length;
    }

    /**
    * @dev Get the code and hash of svg uploaded by user accord to index
    **/
    function getUserSvgByIndex(address user,uint256 index) public view returns(string memory hash,string memory code){
        require(index < _userHashs[user].length,'beyond the round');
        hash = _userHashs[user][index];
        code = _hashCode[hash];
    }
}
