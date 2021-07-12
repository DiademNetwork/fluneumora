import 'dart:typed_data';

import 'package:fluneumora/all.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:web3dart/crypto.dart';

final EthereumAddress tokenAddress =
    EthereumAddress.fromHex(Config.tokenAddress);

class WalletService {
  late Web3Client _client;

  DeployedContract? _tokenContract;

  final int chainId = 80001;

  final d = KeccakDigest(256);

  WalletService() {
    _client = new Web3Client(Config.rpcUrl, Client());
  }

  Future<String> privateKeyFromMnemonic(String mnemonic) async {
    final seed = mnemonicToSeed(mnemonic);

    final node = BIP32.fromSeed(seed);

    final child = node.derivePath("m/44'/60'/0'/0/0");

    final privateKey = HEX.encode(child.privateKey!);

    return privateKey;
  }

  Stream<String> createToken({
    required String privateKey,
    required String tokenName,
    required String tokenSupply,
  }) async* {
    final credentials = await _client.credentialsFromPrivateKey(privateKey);

    final creatorAddress = await credentials.extractAddress();

    final contract = await _getTokenContract();

    final signedTransaction = await _client.signTransaction(
      credentials,
      Transaction.callContract(
        contract: contract,
        function: contract.function("create"),
        parameters: [
          creatorAddress,
          tokenName,
          BigInt.parse(tokenSupply),
        ],
        gasPrice: Config.createGasPrice,
        maxGas: Config.createMaxGas,
      ),
      chainId: chainId,
    );

    final transactionBytes = d.process(signedTransaction);

    final calculatedTransactionHash = bytesToHex(
      transactionBytes,
      include0x: true,
    );

    yield calculatedTransactionHash;

    String? transactionHash;

    while (transactionHash == null) {
      try {
        transactionHash = await _client.sendRawTransaction(signedTransaction);
      } catch (err) {
        log(err);
        await sleep(Duration(seconds: 1));
      }
    }

    yield transactionHash;
  }

  Future<String> transferMatic(
      {required String privateKey,
      required String recipient,
      required EtherAmount value}) async {
    final EthereumAddress recipientAddress = EthereumAddress.fromHex(recipient);

    final credentials = await _client.credentialsFromPrivateKey(privateKey);

    final senderAddress = await credentials.extractAddress();

    final hash = await _client.sendTransaction(
      credentials,
      Transaction(
        from: senderAddress,
        to: recipientAddress,
        value: value,
        // gasPrice: Config.transferMaticGasPrice,
        // maxGas: Config.transferMaticMaxGas,
      ),
      chainId: chainId,
    );

    return hash;
  }

  Stream<String> transfer({
    required String privateKey,
    required String recipient,
    required String tokenId,
    required String tokenQuantity,
  }) async* {
    final EthereumAddress recipientAddress = EthereumAddress.fromHex(recipient);

    final credentials = await _client.credentialsFromPrivateKey(privateKey);

    final senderAddress = await credentials.extractAddress();

    final contract = await _getTokenContract();

    final signedTransaction = await _client.signTransaction(
      credentials,
      Transaction.callContract(
        contract: contract,
        function: contract.function("safeTransferFrom"),
        parameters: [
          senderAddress,
          recipientAddress,
          BigInt.parse(tokenId),
          BigInt.parse(tokenQuantity),
          Uint8List.fromList([]),
        ],
        gasPrice: Config.transferGasPrice,
        maxGas: Config.transferMaxGas,
      ),
      chainId: chainId,
    );

    yield bytesToHex(d.process(signedTransaction), include0x: true);

    while (true) {
      try {
        yield await _client.sendRawTransaction(signedTransaction);
        break;
      } catch (err) {
        log(err);
        await sleep(Duration(seconds: 2));
      }
    }
  }

  Future<List<dynamic>> listenNextTransfer() async {
    return Future.value([]);

    // final contract = await _getTokenContract();

    // final transferEvent = contract.event("TransferSingle");

    // final subscription = _client
    //     .events(FilterOptions.events(contract: contract, event: transferEvent));

    // final event = await subscription.first;

    // final decoded = transferEvent.decodeResults(event.topics!, event.data!);

    // return decoded;
  }

  Future<DeployedContract> _getTokenContract() async {
    if (_tokenContract == null) {
      final String tokenAbi =
          await rootBundle.loadString('assets/token_abi.json');

      _tokenContract = DeployedContract(
          ContractAbi.fromJson(tokenAbi, "MultiToken"), tokenAddress);
    }

    return _tokenContract!;
  }

  Future<int> getBalance({
    required String userAddress,
    required String tokenId,
  }) async {
    try {
      final contract = await _getTokenContract();

      final balanceFunction = contract.function("balanceOf");

      EthereumAddress address = EthereumAddress.fromHex(userAddress);

      final List balance = await _client.call(
        contract: contract,
        function: balanceFunction,
        params: [
          address,
          BigInt.parse(tokenId),
        ],
      );

      return (balance.first as BigInt).toInt();
    } catch (err) {
      log(err);
    }

    return 0;
  }

  void sendTransaction() {}
}
