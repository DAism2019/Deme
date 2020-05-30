from web3.auto import w3
from json import loads
from privateKey import my_address, private_key
from contract import ArticleStore


def showFlag(flag):
    if flag:
        return "是"
    else:
        return "否"


def getInfo():
    isArticleStore = ArticleStore.functions.isArticleStore().call()
    print("本合约是否文章存储系统主合约:",showFlag(isArticleStore))
    admin_address = ArticleStore.functions.getAdminAddress().call()
    print("发表文章合约地址:",admin_address)
    info_address = ArticleStore.functions.getInfoAddress().call()
    print("文章内容合约地址:",info_address)
    enum_address = ArticleStore.functions.getEnumAddress().call()
    print("列举文章合约地址:",enum_address)
    isUpgrade = ArticleStore.functions.isUpgrade().call()
    print("当前合约是否升级过:",showFlag(isUpgrade))
    upgrade_address = ArticleStore.functions.getUpgradeAddress().call()
    print("本身升级合约地址:",upgrade_address)
    isPause = ArticleStore.functions.isPause().call()
    print("当前合约是否暂停:",showFlag(isPause))


getInfo()
