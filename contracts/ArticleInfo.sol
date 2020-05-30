//此合约用来记录所有的文章信息
pragma solidity ^0.5.0;
import './CanAdmin.sol';

contract ArticleInfo is CanAdmin {
    struct Article {
        address creator;
        uint256 uploadTime;
        string title;
        string label;
        string context;
    }
    mapping(uint256 => Article) private _allArticles;           //考虑升级，使用了map而不是数组

    modifier hasArticle(uint256 id) {
        require(_allArticles[id].creator != address(0));
        _;
    }

    modifier noArticle(uint256 id) {
        require(_allArticles[id].creator == address(0));
        _;
    }

    constructor(address store_address) CanAdmin(store_address) public {
        
    }

    //获得文章简要信息 创建者、标题、标签、上传时间
    function getArticleInfoByIndex(uint256 index) external hasArticle(index) view returns (address ,string memory,string memory,uint256){
        Article memory info = _allArticles[index];
        return (info.creator,info.title,info.label,info.uploadTime);
    }

    //获取文章内容
    function getArticleContextByIndex(uint256 index) external hasArticle(index) view returns (string memory) {
        return _allArticles[index].context;
    }

    //增加一篇文章
    function addOneArticle(uint256 id,address _creator,string calldata _title, string calldata _label,string calldata _context)
            onlyAdmin noArticle(id) external {
        Article memory info = Article(_creator,block.timestamp,_title,_label,_context);
        _allArticles[id] = info;
    }
}
