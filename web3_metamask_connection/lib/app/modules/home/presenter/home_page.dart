import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:web3_metamask_connection/app/modules/home/presenter/home_store.dart';
import 'home_store.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedBuilder<HomeStore, Exception, bool>(
        store: store,
        onState: (_, counter) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (store.isConnected)
                Center(
                  child: Text(store.walletStatus()),
                ),
              const SizedBox(
                height: 15,
              ),
              if (store.isEnabled && !store.isConnected)
                Center(
                  child: SizedBox(
                    width: 190,
                    child: ElevatedButton(
                      onPressed: () async {
                        await store.connect();
                      },
                      child: Row(
                        children: const [
                          Text('Connect your wallet!'),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(Icons.add),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
        onError: (context, error) => const Center(
          child: Text(
            'Error during connecting with Metamask!',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
