from web3.auto import w3
from json import loads
from os.path import dirname, abspath
from privateKey import my_address, private_key
from contract import NFT_CONTRACT

receiver_address = '0xc8ffF86C2abdb3065E0FaD8914A36d12e152cDA0'


def getMyToken():
    myBalance = NFT_CONTRACT.functions.balanceOf(my_address).call()
    print("myBalance:",myBalance)
    for i in range(myBalance):
        owner = NFT_CONTRACT.functions.ownerOf(i).call()
        print("当前tokenId为:",i)
        print("当前owner为:",owner)
        print("当前owner是否为自己:",owner == my_address)


def transfer():
    nonce = w3.eth.getTransactionCount(my_address)
    unicorn_txn = NFT_CONTRACT.functions.safeTransferFrom(my_address,receiver_address,1).buildTransaction({
        'nonce': nonce,
        # 'value': w3.toWei(1000, 'ether'),
        'gasPrice': w3.toWei(10, 'gwei'),
        # 'gas': 500000
    })
    signed_txn = w3.eth.account.signTransaction(
        unicorn_txn, private_key=private_key)
    hash = w3.eth.sendRawTransaction(signed_txn.rawTransaction)
    print("安全交易已经发送，请耐心等待并查询,hash值为:", w3.toHex(hash))



transfer()
