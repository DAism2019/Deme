/**
* 文章存储系统总枢纽 本合约要设置为可升级
**/
pragma solidity ^0.5.0;

import "./IArticleStore.sol";
import "./Ownable.sol";

contract ArticleStore  is Ownable, IArticleStore {
    address private store_admin_address;            //文章管理合约地址 ,此合约为可升级，用来增加一些信息
    address private store_info_address;              //文章信息合约地址,   不可升级
    address private store_enum_address;              //保存可罗列信息合约地址 不可升级
    bool public isPause;                       //暂停增加文章以方便升级
    bool public isUpgrade;                     //是否升级过
    IArticleStore public new_instance;          //升级后的实例

    event SetAdminAddressSuc(address _from, address _to);
    event SetInfoAddressSuc(address _from, address _to);
    event SetEnumAddressSuc(address _from, address _to);
    event UpgradeSuccess(address _to);

    modifier notZeroAddress(address new_address) {
        require(new_address != address(0),"ArticleStore: zero_address");
        _;
    }

    //代表本合约是文章存储合约，防止出错
    function isArticleStore() external pure returns(bool) {
        return true;
    }

//////////////////// 管理合约地址管理 //////////////////
    function getAdminAddress() external view returns(address) {
        if(isUpgrade){
            return new_instance.getAdminAddress();
        }
        return store_admin_address;
    }

    function setAdminAddress(address new_address) onlyOwner notZeroAddress(new_address) external {
        emit SetAdminAddressSuc(store_admin_address,new_address);
        store_admin_address = new_address;
    }

//////////////////////// 管理文章信息合约地址 ///////////////////

    function getInfoAddress() external view returns(address) {
        if(isUpgrade){
            return new_instance.getInfoAddress();
        }
        return store_info_address;
    }

    function setInfoAddress(address new_address) external notZeroAddress(new_address) onlyOwner {
         emit SetInfoAddressSuc(store_info_address,new_address);
         store_info_address = new_address;
    }

//////////////////////// 管理可罗列信息合约地址 //////////////////
    function getEnumAddress() external view returns(address) {
        if(isUpgrade){
            return new_instance.getEnumAddress();
        }
        return store_enum_address;
    }

    function setEnumAddress(address new_address) external notZeroAddress(new_address) onlyOwner {
        emit SetEnumAddressSuc(store_enum_address,new_address);
        store_enum_address = new_address;
    }

//////////////////////// 暂停管理 /////////////////////
    function pause() onlyOwner external {
        require (!isPause,"ArticleStore: has paused");
        isPause = true;
    }

    function unPause() onlyOwner external {
        require (isPause,"ArticleStore: has not paused");
        isPause = false;
    }

//////////////////实现自升级//////////////////////
    //得到升级合约地址，如果地址为空，代表它未升级，是最后一次升级的合约。
    function getUpgradeAddress() external view returns(address) {
        if(isUpgrade){
            return new_instance.getUpgradeAddress();
        }
        return address(new_instance);
    }

    //必须先暂停后再升级
    function upgrade(address new_address) external notZeroAddress(new_address) onlyOwner {
        require (isPause,"ArticleStore: has not paused");
        new_instance = IArticleStore(new_address);
        require (new_instance.isArticleStore(),"ArticleStore: invalid contract");
        //这里未限制isUpgrade为false是怕升级错了无法挽回，因此，此合约可以来回升级，当然也可以升级已经升级后的合约
        isUpgrade = true;
        emit UpgradeSuccess(new_address);
    }

}
