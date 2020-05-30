from web3.auto import w3
from os.path import dirname, abspath
from privateKey import my_address, private_key
from contract import ArticleStore,ArticleAdmin,ArticleInfo,ArticleEnumable

def setup():
    nonce = w3.eth.getTransactionCount(my_address)
    unicorn_txn = ArticleStore.functions.setAdminAddress(ArticleAdmin.address).buildTransaction({
        'nonce': nonce,
        # 'value': w3.toWei(1000, 'ether'),
        'gasPrice': w3.toWei(10, 'gwei'),
        # 'gas': 500000
    })
    signed_txn = w3.eth.account.signTransaction(
        unicorn_txn, private_key=private_key)
    hash = w3.eth.sendRawTransaction(signed_txn.rawTransaction)
    print("设置admin已经发送，请耐心等待并查询,hash值为:", w3.toHex(hash))
    nonce +=1
    unicorn_txn = ArticleStore.functions.setInfoAddress(ArticleInfo.address).buildTransaction({
        'nonce': nonce,
        # 'value': w3.toWei(1000, 'ether'),
        'gasPrice': w3.toWei(10, 'gwei'),
        # 'gas': 500000
    })
    signed_txn = w3.eth.account.signTransaction(
        unicorn_txn, private_key=private_key)
    hash = w3.eth.sendRawTransaction(signed_txn.rawTransaction)
    print("设置info已经发送，请耐心等待并查询,hash值为:", w3.toHex(hash))
    nonce +=1
    unicorn_txn = ArticleStore.functions.setEnumAddress(ArticleEnumable.address).buildTransaction({
        'nonce': nonce,
        # 'value': w3.toWei(1000, 'ether'),
        'gasPrice': w3.toWei(10, 'gwei'),
        # 'gas': 500000
    })
    signed_txn = w3.eth.account.signTransaction(
        unicorn_txn, private_key=private_key)
    hash = w3.eth.sendRawTransaction(signed_txn.rawTransaction)
    print("设置Enumable已经发送，请耐心等待并查询,hash值为:", w3.toHex(hash))


setup()
