#测试当前网络接点是否能连接上
from web3.auto import w3
# from web3 import Web3,HTTPProvider
# web3 = Web3(HTTPProvider('https://ropsten.infura.io/v3/9e1f16ff18f847bfb54093d4cf8c5f78'))


connected = w3.isConnected()
print("connected:",connected)
