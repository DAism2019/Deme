from web3.auto import w3
from json import loads
from os.path import dirname, abspath

def init():
    path = dirname(dirname(abspath(__file__)))
    store_abi_path = path + '/build/contracts/ArticleStore.json'
    admin_abi_path = path + '/build/contracts/ArticleAdmin.json'
    info_abi_path = path + '/build/contracts/ArticleInfo.json'
    enum_abi_path = path + '/build/contracts/ArticleEnumable.json'
    all_address_path = dirname(dirname(abspath(__file__))) + '/contracts/address.json';
    all_address = loads(open(all_address_path).read())
    contract_store_abi = loads(open(store_abi_path).read())['abi']
    contract_admin_abi = loads(open(admin_abi_path).read())['abi']
    contract_info_abi = loads(open(info_abi_path).read())['abi']
    contract_enum_abi = loads(open(enum_abi_path).read())['abi']
    store_contract = w3.eth.contract(address=all_address["ArticleStore"], abi=contract_store_abi)
    admin_contract = w3.eth.contract(address=all_address["ArticleAdmin"], abi=contract_admin_abi)
    info_contract = w3.eth.contract(address=all_address["ArticleInfo"], abi=contract_info_abi)
    enum_contract = w3.eth.contract(address=all_address["ArticleEnumable"], abi=contract_enum_abi)
    return store_contract,admin_contract,info_contract,enum_contract

ArticleStore,ArticleAdmin,ArticleInfo,ArticleEnumable = init()
