import 'package:auto_route/annotations.dart';
import 'package:fwitter/locations/welcome_screen/welcome_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[AutoRoute(page: WelcomeScreen, path: '/welcome')],
)
class $AppRouter {}
