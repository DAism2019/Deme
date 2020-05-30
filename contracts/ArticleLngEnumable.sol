//此合约增加功能，根据语言来分类获取
pragma solidity ^0.5.0;
import './CanAdmin.sol';



contract ArticleLngEnumable is CanAdmin {
    mapping(string => uint256[])  private _lngArticles;       //语言文章数组

    constructor(address store_address) CanAdmin(store_address) public {
        handleOldDataZh();
        handleOldDataEn();
    }

    function handleOldDataEn() private {
        string memory lng = 'en';
        _lngArticles[lng].push(7);
    }

    function handleOldDataZh() private {
        string memory lng = 'zh';
        for(uint i=1;i<=6;i++){
             _lngArticles[lng].push(i);
        }

    }

    /////////////////////////////实现语言文章可列举 ////////////////////////
        //获得语言分类文章数量
        function getLngArticleAmount(string calldata _lng) external view returns (uint256) {
            return _lngArticles[_lng].length;
        }

        //根据对应索引获得用户文章ID
        function getLngArticleIdByIndex(string calldata _lng,uint256 index) external view returns (uint256) {
            require(index < _lngArticles[_lng].length,"index out of bounds");
            return _lngArticles[_lng][index];
        }

        //增加用户文章记录
        function addLngArticleId(string calldata _lng,uint256 id) external onlyAdmin {
            _lngArticles[_lng].push(id);
        }

}
