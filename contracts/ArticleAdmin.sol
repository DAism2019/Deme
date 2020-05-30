//此合约用来管理文章的创建
pragma solidity ^0.5.0;

import "./IArticleStore.sol";

//保存文章信息的合约接口
contract ArticleInfoInterface {
    function addOneArticle(uint256 id,address _creator,string calldata _title, string calldata _label,string calldata _context) external;
}

//保存根据用户或者标签分类的合约接口
contract ArticleEnumableInterface {
    function addUserArticleId(address _creator,uint256 id) external;
    function addLabelArticleId(string calldata _label,uint256 id) external;
}

//保存根据语言分类的合约接口
contract ArticleLngEnumableInterface {
    function addLngArticleId(string calldata _lng,uint256 id) external;
}

//主合约
contract ArticleAdmin {
    IArticleStore public article_store;         //ArticleStore 实例
    uint256 public nonce;                       //所有文章数量计数器
    ArticleLngEnumableInterface public lngEnumable;       //一个ArticleLngEnumable实例，放在这是不想升级IArticleStore
    event AddArticleSuc(address indexed creator,string title);

    constructor(address store_address,uint256 new_nonce) public {
        require(store_address != address(0),"ArticleAdmin: zero_address");
        article_store = IArticleStore(store_address);
        require(article_store.isArticleStore(),"ArticleAdmin: invalid contract");
        nonce = new_nonce;
    }

    function setLngEnumable(address new_address) external {
        require(new_address != address(0),"ArticleAdmin: zero_address");
        require(address(lngEnumable) == address(0),"ArticleAdmin:has setup");
        lngEnumable = ArticleLngEnumableInterface(new_address);
    }

    //发表一篇文章
    function addOneArticle(string calldata title,string calldata label,string calldata context,string calldata lng) external {
        require(!article_store.isPause(),"ArticleAdmin: ArticleStore is paused");
        address info_address =  article_store.getInfoAddress();
        nonce ++;
        ArticleInfoInterface(info_address).addOneArticle(nonce,msg.sender,title,label,context);
        ArticleEnumableInterface enumable = ArticleEnumableInterface(article_store.getEnumAddress());
        enumable.addUserArticleId(msg.sender,nonce);
        enumable.addLabelArticleId(label,nonce);
        lngEnumable.addLngArticleId(lng,nonce);
        emit AddArticleSuc(msg.sender,title);
    }
}
