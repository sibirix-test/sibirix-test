import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fwitter/router.gr.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'utils/globals.dart';

final _appRouter = AppRouter();

void main() {
  runApp(const ProviderScope(child: App()));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _Router();
  }
}

class _Router extends ConsumerWidget {
  const _Router({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    initializeDateFormatting('RU');
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: gScaffoldMessengerKey,
      title: 'Fwitter',
      theme: appTheme,
      routerDelegate: AutoRouterDelegate(_appRouter),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
