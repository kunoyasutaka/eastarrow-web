import 'package:eastarrow_web/config/admin_colors.dart';
import 'package:eastarrow_web/config/router_factory.dart';
import 'package:flutter/material.dart';

/// 管理App
class AdminApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'サロン管理Webアプリ',
      theme: ThemeData(
        primarySwatch: AdminColors.themeBlack,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: AdminColors.themeBlack,
            ),
        primaryTextTheme: Theme.of(context).textTheme.apply(
              bodyColor: AdminColors.themeTextPrimary,
            ),
        primaryIconTheme: IconThemeData(
          color: AdminColors.themeTextPrimary,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // ルーティングはすべて onGenerateRoute で行う
      onGenerateRoute: RouterFactory.create().build(),
      navigatorObservers: [_AdminRouteObserver()],
    );
  }
}

/// Navigator Stack の状態を監視してデバッグ出力する
class _AdminRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  final routeStack = _RouteStack();

  @override
  void didPop(Route route, Route? previousRoute) {
    routeStack.pop();
    routeStack.dump(operation: 'pop');
    super.didPop(route, previousRoute);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    routeStack.push(route);
    routeStack.dump(operation: 'push');
    super.didPush(route, previousRoute);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    routeStack.remove(route);
    routeStack.dump(operation: 'remove');
    super.didRemove(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    routeStack.replace(newRoute, oldRoute);
    routeStack.dump(operation: 'replace');
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }
}

/// RouteのStackを管理する
class _RouteStack {
  final List<String> _stack = [];

  void pop() {
    _stack.removeLast();
  }

  void push(Route route) {
    if (route.settings.name != null) {
      _stack.add(route.settings.name!);
    }
  }

  void remove(Route route) {
    for (int i = 0; i < _stack.length; i++) {
      if (_stack[i] == route.settings.name) {
        _stack.removeAt(i);
        return;
      }
    }
  }

  void replace(Route? newRoute, Route? oldRoute) {
    if ((oldRoute != null) && (newRoute != null)) {
      for (int i = _stack.length - 1; i >= 0; i--) {
        if (_stack[i] == oldRoute.settings.name!) {
          _stack.removeAt(i);
          _stack.insert(i, newRoute.settings.name!);
          return;
        }
      }
    }
  }

  void dump({String? operation}) {
    if (operation != null) {
      print('RouteStack: $_stack, operation = $operation');
    } else {
      print('RouteStack: $_stack');
    }
  }
}
