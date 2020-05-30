const ArticleEnumable = artifacts.require("ArticleEnumable");
const ArticleStore = artifacts.require("ArticleStore");
const ArticleInfo = artifacts.require("ArticleInfo");
const ArticleAdmin = artifacts.require("ArticleAdmin");
const ArticleLngEnumable = artifacts.require("ArticleLngEnumable");
module.exports = function(deployer) {
    deployer.deploy(ArticleEnumable,ArticleStore.address);
    deployer.deploy(ArticleInfo,ArticleStore.address);
    deployer.deploy(ArticleLngEnumable,ArticleStore.address);
    deployer.deploy(ArticleAdmin,ArticleStore.address,5);
};
