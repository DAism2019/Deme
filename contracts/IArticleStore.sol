//一些公共接口
pragma solidity ^0.5.0;

interface IArticleStore {
    function getAdminAddress() external view returns(address);
    function getInfoAddress() external view returns(address);
    function getEnumAddress() external view returns(address);
    function getUpgradeAddress() external view returns(address);
    function isArticleStore() external pure returns(bool);
    function isPause() external view returns(bool);
}
