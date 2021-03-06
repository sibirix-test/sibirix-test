import 'package:auto_route/annotations.dart';
import 'package:fwitter/locations/fweet_feed/fweet_feed_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(page: FweetFeedScreen, path: '/feed', initial: true),
  ],
)
class $AppRouter {}
