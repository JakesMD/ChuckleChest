// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$CAppRouter extends RootStackRouter {
  // ignore: unused_element
  _$CAppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    CGemRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<CGemRouteArgs>(
          orElse: () => CGemRouteArgs(gemID: pathParams.getString('gemID')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: CGemPage(
          gemID: args.gemID,
          key: args.key,
        )),
      );
    },
    CHomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: CHomePage()),
      );
    },
  };
}

/// generated route for
/// [CGemPage]
class CGemRoute extends PageRouteInfo<CGemRouteArgs> {
  CGemRoute({
    required String gemID,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          CGemRoute.name,
          args: CGemRouteArgs(
            gemID: gemID,
            key: key,
          ),
          rawPathParams: {'gemID': gemID},
          initialChildren: children,
        );

  static const String name = 'CGemRoute';

  static const PageInfo<CGemRouteArgs> page = PageInfo<CGemRouteArgs>(name);
}

class CGemRouteArgs {
  const CGemRouteArgs({
    required this.gemID,
    this.key,
  });

  final String gemID;

  final Key? key;

  @override
  String toString() {
    return 'CGemRouteArgs{gemID: $gemID, key: $key}';
  }
}

/// generated route for
/// [CHomePage]
class CHomeRoute extends PageRouteInfo<void> {
  const CHomeRoute({List<PageRouteInfo>? children})
      : super(
          CHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'CHomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
