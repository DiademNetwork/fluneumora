import 'package:fluneumora/all.dart';

class Config {
  // wallet
  static const tokenAddress = "0x871e6Ca1065921137DeD597A4750f517bc135B6D";
  static const rpcUrl =
      "https://speedy-nodes-nyc.moralis.io/70e58b68f839ae4874767195/polygon/mumbai";
  static const explorerUrl = "https://explorer-mumbai.maticvigil.com";

  // moralis
  static const applicationId =
      "WYYgip1PUiCtHzSY1pKHNvUVGqDGlcnKkpt6N2XB"; // "dqQSSOZ7jaNtn2qXsE6V3EBQ4tX0YXCTyuWc68bJ";
  static const emulatorServerUrl = "http://10.0.2.2:1337/parse/";
  static const localServerUrl = "http://localhost:1337/parse/";
  static const moralisServerUrl =
      "https://pgnta72s0q9x.moralis.io:2053/server"; // "https://kbrz0qn8lfje.moralis.io:2053/server";
  static const masterKey = "Lk4BG6pmgtYJZE03dIH1tjjM3VlhiWoPtWR2Bf2N";
  static const appName = "fluneumora-testnet";
  static const appVersion = "";
  static const appPackageName = "";

  static const gasPrivateKey =
      "5f5ede4083f7a63e42941792b8bb47ea3aef78b3d3b653f09457167c8541fa34";

  static final transferMaticGasPrice =
      EtherAmount.fromUnitAndValue(EtherUnit.gwei, 1);
  static final transferMaticMaxGas = 21000;

  static final createMaticValue =
      EtherAmount.fromUnitAndValue(EtherUnit.finney, 4);
  static final createMaxGas = 90000;
  static final createGasPrice = EtherAmount.fromUnitAndValue(EtherUnit.gwei, 1);

  static final transferMaticValue =
      EtherAmount.fromUnitAndValue(EtherUnit.finney, 4);
  static final transferMaxGas = 120000;
  static final transferGasPrice =
      EtherAmount.fromUnitAndValue(EtherUnit.gwei, 1);

  static final String depositAddress =
      "0xbf106a19ee762e16ce9a06d3028910eb20bca474";

  static final String depositPrivateKey = "";
}
