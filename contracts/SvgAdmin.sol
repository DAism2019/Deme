//本合约只做一件事，负责处理用户上传的SVG图片
//本合约可升级，用来增加一些功能
pragma solidity ^0.5.0;

//保存SVG内容的合约接口，包括图片是公有还是私有的
contract SvgHashInterface {
    //返回公共或者私有图片的数量
    function addCode(address creator,string calldata _hash,string calldata _code,bool isPublic) external returns(uint);
}

contract SvgAdmin {
    SvgHashInterface public svg_info_store;         //具体SVG存储合约
    event AddSvgCode(address indexed user,bool indexed isPublic,uint256 amount,string hash);

    constructor(address info_store_address) public {
        require(info_store_address != address(0),"SvgAdmin: zero_address");
        svg_info_store = SvgHashInterface(info_store_address);
    }

    //保存SVG图片
    function addCode(string calldata _hash,string calldata _code,bool isPublic) external {
        uint amount = svg_info_store.addCode(msg.sender,_hash,_code,isPublic);
        emit AddSvgCode(msg.sender,isPublic,amount,_hash);
    }
}
