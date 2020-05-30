/**
 * A interface to save code of svg in ethereum indexed by it's hash
 * 本合约用来使用hash来注册SVG图片，是独立于文章存储系统的
 **/
pragma solidity ^ 0.5.0;

contract OldSvgHash {
    function hasCode(string memory _hash) public view returns(bool);
    function getCode(string calldata _hash) external view returns(string memory);
}

//这里不要用不用SvgStore，编译后会重写SvgStore
contract SvgStoreInterface {
    function getAdminAddress() external view returns(address);
}


contract SvgHashNew {
    mapping(string => bool) private _hashStatus; //记录每个hash是否保存
    mapping(string => string) private _hashCode; //记录每个存在的hash对应的code
    mapping(address => string[]) _userHashs; //用户个人图片
    string[] private _publicHashs; //公共图片
    OldSvgHash public oldInstance; //以前旧图片
    SvgStoreInterface public svg_store; //总合约，通过它得到管理合约地址，这样可以升级管理合约

    modifier onlyAdmin() {
        address svg_admin = svg_store.getAdminAddress();
        require(msg.sender == svg_admin, "SvgHashNew: permission denied");
        _;
    }

    constructor(address old_address, address svg_store_address) public {
        require(old_address != address(0) && svg_store_address != address(0), 'SvgHashNew: zero_address');
        oldInstance = OldSvgHash(old_address);
        svg_store = SvgStoreInterface(svg_store_address);
    }

    /**
     * @dev Return the existing of a svg hash
     **/
    function hasCode(string memory _hash) public view returns(bool) {
        if (oldInstance.hasCode(_hash)) {
            return true;
        }
        return _hashStatus[_hash];
    }

    /**
     * @dev Get the code of svg by it's hash
     **/
    function getCode(string calldata _hash) external view returns(string memory) {
        if (oldInstance.hasCode(_hash)) {
            return oldInstance.getCode(_hash);
        }
        return _hashCode[_hash];
    }

    /**
     * @dev Set the code of svg by it's hash
     **/
    function addCode(address creator, string calldata _hash, string calldata _code, bool isPublic) external onlyAdmin returns(uint) {
        bool flag = hasCode(_hash);
        require(!flag, 'hash has code');
        _hashStatus[_hash] = true;
        _hashCode[_hash] = _code;
        if (isPublic) {
            _publicHashs.push(_hash);
            return _publicHashs.length;
        } else {
            _userHashs[creator].push(_hash);
            return _userHashs[creator].length;
        }
    }

    /**
     * @dev Get the amount of svg uploaded by user
     **/
    function getUserSvgAmount(address user) external view returns(uint256) {
        return _userHashs[user].length;
    }

    /**
     * @dev Get the code and hash of svg uploaded by user accord to index
     **/
    function getUserSvgByIndex(address user, uint256 index) external view returns(string memory hash, string memory code) {
        require(index < _userHashs[user].length, 'beyond the bound');
        hash = _userHashs[user][index];
        code = _hashCode[hash];
    }

    //获取所有公共图片数量
    function getPublicHashAmount() external view returns(uint) {
        return _publicHashs.length;
    }

    //获得某一个公共图片
    function getPublicHashByIndex(uint index) external view returns(string memory hash, string memory code) {
        require(index < _publicHashs.length, "beyond the bound");
        hash = _publicHashs[index];
        code = _hashCode[hash];
    }
}
