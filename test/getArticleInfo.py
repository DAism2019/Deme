from web3.auto import w3
from json import loads
from os.path import dirname, abspath
from privateKey import my_address, private_key
from contract import ArticleAdmin,ArticleInfo,ArticleEnumable


def getInfo():
    amount = ArticleAdmin.functions.nonce().call()
    print("当前文章总数为:",amount)


getInfo()
