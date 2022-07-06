// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;

import 'locations/fweet_feed/fweet_feed_screen.dart' as _i1;
import 'locations/welcome_screen/welcome_screen.dart' as _i2;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    FweetFeedRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.FweetFeedScreen());
    },
    WelcomeRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.WelcomeScreen());
    }
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig('/#redirect',
            path: '/', redirectTo: '/feed', fullMatch: true),
        _i3.RouteConfig(FweetFeedRoute.name, path: '/feed'),
        _i3.RouteConfig(WelcomeRoute.name, path: '/welcome')
      ];
}

/// generated route for
/// [_i1.FweetFeedScreen]
class FweetFeedRoute extends _i3.PageRouteInfo<void> {
  const FweetFeedRoute() : super(FweetFeedRoute.name, path: '/feed');

  static const String name = 'FweetFeedRoute';
}

/// generated route for
/// [_i2.WelcomeScreen]
class WelcomeRoute extends _i3.PageRouteInfo<void> {
  const WelcomeRoute() : super(WelcomeRoute.name, path: '/welcome');

  static const String name = 'WelcomeRoute';
}
