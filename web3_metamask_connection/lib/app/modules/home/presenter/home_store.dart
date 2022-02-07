import 'package:flutter_triple/flutter_triple.dart';
import 'package:flutter_web3/flutter_web3.dart';

// ignore: must_be_immutable
class HomeStore extends NotifierStore<Exception, bool> {
  HomeStore() : super(false) {
    init();
  }

  bool get isEnabled => ethereum != null;

  bool get isInOperatingChain => currentChain == operatingChain;

  bool get isConnected => isEnabled && currentAddress.isNotEmpty;

  String currentAddress = '';

  int currentChain = -1;

  static const operatingChain = 56;

  Future<void> connect() async {
    if (isEnabled) {
      final accs = await ethereum!.requestAccount();
      if (accs.isNotEmpty) currentAddress = accs.first;

      currentChain = await ethereum!.getChainId();

      update(true);
    }
  }

  clear() {
    currentAddress = '';
    currentChain = -1;
    // cakeToken = null;
    update(false);
  }

  init() {
    if (isEnabled) {
      ethereum!.onAccountsChanged((accs) {
        clear();
      });

      ethereum!.onChainChanged((chain) {
        clear();
      });
    }
  }

  String walletStatus() {
    String status = "";

    if (isConnected && isInOperatingChain) {
      status = "You're connected!";
    } else if (isConnected && !isInOperatingChain) {
      status = "Wrong chain! Please connect to BSC!";
    }

    return status;
  }

  // static const cakeAddress = '0x0e09fabb73bd3ade0a17ecc321fd13a19e81ce82';

  // static const deadAddress = '0x000000000000000000000000000000000000dead';

  // ContractERC20? cakeToken;

  // BigInt yourCakeBalance = BigInt.zero;

  // getCakeTokenBalance() async {
  //   cakeToken ??= ContractERC20(cakeAddress, provider!.getSigner());
  //   yourCakeBalance = await cakeToken!.balanceOf(currentAddress);
  //   // update();
  // }

  // burnSomeCake() async {
  //   await getCakeTokenBalance();

  //   // Burn all 1 gwei of your Cake! Super dangerous!
  //   if (yourCakeBalance > BigInt.from(1000000000) // 1 Gwei
  //       ) {
  //     final tx = await cakeToken!.transfer(deadAddress, BigInt.from(1000000000));
  //     await tx.wait();

  //     await getCakeTokenBalance();
  //   }
  // }

  // final abi = [
  //   'function cakePerBlock() view returns (uint)',
  //   'function poolLength() view returns (uint)',
  //   'function emergencyWithdraw(uint)',
  // ];

  // static const masterchefAddress = '0x73feaa1ee314f8c655e354234017be2193c9e24e';

  // Contract? masterChef;

  // BigInt cakePerBlock = BigInt.zero;

  // int poolLength = 0;

  // getMasterChefInformation() async {
  //   masterChef ??= Contract(masterchefAddress, abi, provider!.getSigner());
  //   cakePerBlock = await masterChef!.call<BigInt>('cakePerBlock');
  //   poolLength = await masterChef!.call<int>('poolLength');
  //   // update();
  // }

  // emergencyWithdraw() async {
  //   await getMasterChefInformation();

  //   // EMERGENCY WITHDRAW AT POOL 0; ALERT!
  //   final tx = await masterChef!.call('emergencyWithdraw', [0]);
  //   await tx.wait();
  // }
}
