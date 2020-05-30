from web3.auto import w3
from json import loads
from os.path import dirname, abspath
from privateKey import my_address, private_key
from contract import NFT_CONTRACT


def getMyERC():
    myBalance = NFT_CONTRACT.functions.balanceOf(my_address).call()
    print("myBalance:",myBalance)


getMyERC()
