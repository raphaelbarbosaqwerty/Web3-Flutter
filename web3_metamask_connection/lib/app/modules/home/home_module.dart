import 'package:flutter_modular/flutter_modular.dart';
import 'package:web3_metamask_connection/app/modules/home/presenter/home_page.dart';
import 'package:web3_metamask_connection/app/modules/home/presenter/home_store.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => HomePage()),
  ];
}
