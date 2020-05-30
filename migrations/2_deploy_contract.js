const SvgHash = artifacts.require("SvgHash");
const ArticleStore = artifacts.require("ArticleStore");
const NameRegister = artifacts.require("NameRegister");
module.exports = function(deployer) {
    deployer.deploy(SvgHash,{overwrite:false});
    deployer.deploy(ArticleStore,{overwrite:false});
    deployer.deploy(NameRegister,{overwrite:false});
};
