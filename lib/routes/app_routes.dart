import 'package:go_router/go_router.dart';
import 'package:dte_app/providers/route_provider.dart';
import 'package:dte_app/screens/dynamic_screen/dynamic_screen.dart';
import 'package:dte_app/screens/tech_screens/error_screen.dart';


class AppRoutes {
  static GoRouter createRouter(RouteProvider routeProvider) {
    List<GoRoute> generateSubRoutes(List<dynamic> subRoutesData, String parentPath) {
      return subRoutesData.map((subRoute) {
        final String subPath = subRoute['path'];
        final String pageName = subRoute['pageName'];
        final String pageType = subRoute['pageType'];
        final String pagePathName = subRoute['pagePathName'];
        final String fullPath = parentPath == "/" ? pagePathName : "$parentPath/$pagePathName";

        final List<dynamic> nestedSubRoutes = subRoute['subRoutes'] ?? [];

        builder(context, state) => DynamicScreen(
              pageName: pageName,
              path: fullPath,
              pageType: pageType,
              pagePathName: pagePathName,
            );

        return GoRoute(
          path: subPath,
          builder: builder,
          routes: nestedSubRoutes.isNotEmpty ? generateSubRoutes(nestedSubRoutes, fullPath) : [],
        );
      }).toList();
    }

    List<GoRoute> generateRoutes(List<dynamic> routesData) {
      return routesData.map((route) {
        final String path = route['path'];
        final String pageName = route['pageName'];
        final String pageType = route['pageType'];
        final String pagePathName = route['pagePathName'];
        final List<dynamic> subRoutes = route['subRoutes'] ?? [];

        builder(context, state) => DynamicScreen(
              pageName: pageName,
              path: path,
              pageType: pageType,
              pagePathName: pagePathName,
            );

        return GoRoute(
          path: path,
          builder: builder,
          routes: subRoutes.isNotEmpty ? generateSubRoutes(subRoutes, path) : [],
        );
      }).toList();
    }

    final List<GoRoute> routes = [
      ...generateRoutes(routeProvider.menuData),
      ...routeProvider.independentRoutes.map((route) {
        return GoRoute(
          path: route['path'],
          builder: (context, state) => route['widget'](context, state),
        );
      }).toList(),
    ];

    return GoRouter(
      routes: routes,
      errorBuilder: (context, state) {
        return ErrorScreen(errorMessage: state.error.toString());
      },
    );

  }
}
