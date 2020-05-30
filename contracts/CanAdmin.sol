//此合约主要是提取那些要使用文章管理的合约接口
pragma solidity ^0.5.0;

contract ArticleStore {
    function getAdminAddress() external view returns(address);
    function isArticleStore() public pure returns(bool);
}

contract CanAdmin {
    ArticleStore public article_store;
    constructor(address store_address) public {
        require(store_address != address(0),"CanAdmin: zero_address");
        article_store = ArticleStore(store_address);
        require(article_store.isArticleStore(),"CanAdmin: invalid contract");
    }

    modifier onlyAdmin() {
        address admin = article_store.getAdminAddress();
        require(admin == msg.sender,"CanAdmin: permission denied");
        _;
    }
}
