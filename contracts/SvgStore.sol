/**
* 图片存储系统总枢纽 本合约要设置为可升级
**/
pragma solidity ^ 0.5 .0;
import "./Ownable.sol";

contract SvgStore is Ownable {
    address private svg_admin_address;          //SVG管理合约入口
    bool public isUpgrade;                     //是否升级过
    SvgStore public new_instance;          //升级后的实例

    modifier notZeroAddress(address new_address) {
        require(new_address != address(0),"SvgStore: zero_address");
        _;
    }

//////////////////// 管理合约地址管理 //////////////////
    function getAdminAddress() external view returns(address) {
        if(isUpgrade){
            return new_instance.getAdminAddress();
        }
        return svg_admin_address;
    }

    function setAdminAddress(address new_address) onlyOwner notZeroAddress(new_address) external {
        svg_admin_address = new_address;
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
        new_instance = SvgStore(new_address);
        //这里未限制isUpgrade为false是怕升级错了无法挽回，因此，此合约可以来回升级，当然也可以升级已经升级后的合约
        isUpgrade = true;
    }

}
