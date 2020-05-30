//此合约实现根据标签和用户列举功能。
pragma solidity ^0.5.0;

import './CanAdmin.sol';

contract ArticleEnumable is CanAdmin {
    mapping(address => uint256[]) private _userArticles;        //用户文章ID数组
    mapping(string => uint256[])  private _labelArticles;       //同标签文章数组

    constructor(address store_address) CanAdmin(store_address) public {

    }

/////////////////////////////实现用户文章可列举 ////////////////////////
    //获得用户发表文章数量
    function getUserArticleAmount(address _creator) external view returns (uint256) {
        return _userArticles[_creator].length;
    }

    //根据对应索引获得用户文章ID
    function getUserArticleIdByIndex(address _creator,uint256 index) external view returns (uint256) {
        require(index < _userArticles[_creator].length,"index out of bounds");
        return _userArticles[_creator][index];
    }

    //增加用户文章记录
    function addUserArticleId(address _creator,uint256 id) external onlyAdmin {
        _userArticles[_creator].push(id);
    }

/////////////////////////////实现标签文章可列举 /////////////////////////
    //获得标签文章发表数量
    function getLabelArticleAmount(string calldata label) external view returns (uint256) {
        return _labelArticles[label].length;
    }

    //根据索引获得标签文章对应ID
    function getLabelArticleByIndex(string calldata label,uint256 index) external view returns (uint256) {
        require(index < _labelArticles[label].length,"index out of bounds");
        return _labelArticles[label][index];
    }

    //增加标签文章记录
    function addLabelArticleId(string calldata _label,uint256 id) external onlyAdmin {
        _labelArticles[_label].push(id);
    }
}
