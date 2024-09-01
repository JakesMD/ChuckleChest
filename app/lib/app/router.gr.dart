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
    CBaseRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const CBasePage()),
      );
    },
    CChestRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<CChestRouteArgs>(
          orElse: () =>
              CChestRouteArgs(chestID: pathParams.optString('chest-id')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: CChestPage(
          chestID: args.chestID,
          key: args.key,
        )),
      );
    },
    CCreateGemRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const CCreateGemPage()),
      );
    },
    CEditGemRoute.name: (routeData) {
      final args = routeData.argsAs<CEditGemRouteArgs>(
          orElse: () => const CEditGemRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: CEditGemPage(
          key: args.key,
          isNewGem: args.isNewGem,
        )),
      );
    },
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
    CGemsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const CGemsPage()),
      );
    },
    CGetStartedRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const CGetStartedPage()),
      );
    },
    CHomeRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args =
          routeData.argsAs<CHomeRouteArgs>(orElse: () => CHomeRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: CHomePage(
          chestID: pathParams.getString('chest-id'),
          key: args.key,
        )),
      );
    },
    CLoginRoute.name: (routeData) {
      final args = routeData.argsAs<CLoginRouteArgs>(
          orElse: () => const CLoginRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: CLoginTab(key: args.key)),
      );
    },
    COTPVerificationRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<COTPVerificationRouteArgs>(
          orElse: () =>
              COTPVerificationRouteArgs(email: queryParams.optString('email')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: COTPVerificationPage(
          email: args.email,
          key: args.key,
        )),
      );
    },
    CSettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const CSettingsPage()),
      );
    },
    CSigninRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const CSigninPage()),
      );
    },
    CSignupRoute.name: (routeData) {
      final args = routeData.argsAs<CSignupRouteArgs>(
          orElse: () => const CSignupRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: CSignupTab(key: args.key)),
      );
    },
  };
}

/// generated route for
/// [CBasePage]
class CBaseRoute extends PageRouteInfo<void> {
  const CBaseRoute({List<PageRouteInfo>? children})
      : super(
          CBaseRoute.name,
          initialChildren: children,
        );

  static const String name = 'CBaseRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CChestPage]
class CChestRoute extends PageRouteInfo<CChestRouteArgs> {
  CChestRoute({
    required String? chestID,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          CChestRoute.name,
          args: CChestRouteArgs(
            chestID: chestID,
            key: key,
          ),
          rawPathParams: {'chest-id': chestID},
          initialChildren: children,
        );

  static const String name = 'CChestRoute';

  static const PageInfo<CChestRouteArgs> page = PageInfo<CChestRouteArgs>(name);
}

class CChestRouteArgs {
  const CChestRouteArgs({
    required this.chestID,
    this.key,
  });

  final String? chestID;

  final Key? key;

  @override
  String toString() {
    return 'CChestRouteArgs{chestID: $chestID, key: $key}';
  }
}

/// generated route for
/// [CCreateGemPage]
class CCreateGemRoute extends PageRouteInfo<void> {
  const CCreateGemRoute({List<PageRouteInfo>? children})
      : super(
          CCreateGemRoute.name,
          initialChildren: children,
        );

  static const String name = 'CCreateGemRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CEditGemPage]
class CEditGemRoute extends PageRouteInfo<CEditGemRouteArgs> {
  CEditGemRoute({
    Key? key,
    bool isNewGem = false,
    List<PageRouteInfo>? children,
  }) : super(
          CEditGemRoute.name,
          args: CEditGemRouteArgs(
            key: key,
            isNewGem: isNewGem,
          ),
          initialChildren: children,
        );

  static const String name = 'CEditGemRoute';

  static const PageInfo<CEditGemRouteArgs> page =
      PageInfo<CEditGemRouteArgs>(name);
}

class CEditGemRouteArgs {
  const CEditGemRouteArgs({
    this.key,
    this.isNewGem = false,
  });

  final Key? key;

  final bool isNewGem;

  @override
  String toString() {
    return 'CEditGemRouteArgs{key: $key, isNewGem: $isNewGem}';
  }
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
/// [CGemsPage]
class CGemsRoute extends PageRouteInfo<void> {
  const CGemsRoute({List<PageRouteInfo>? children})
      : super(
          CGemsRoute.name,
          initialChildren: children,
        );

  static const String name = 'CGemsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CGetStartedPage]
class CGetStartedRoute extends PageRouteInfo<void> {
  const CGetStartedRoute({List<PageRouteInfo>? children})
      : super(
          CGetStartedRoute.name,
          initialChildren: children,
        );

  static const String name = 'CGetStartedRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CHomePage]
class CHomeRoute extends PageRouteInfo<CHomeRouteArgs> {
  CHomeRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          CHomeRoute.name,
          args: CHomeRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'CHomeRoute';

  static const PageInfo<CHomeRouteArgs> page = PageInfo<CHomeRouteArgs>(name);
}

class CHomeRouteArgs {
  const CHomeRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'CHomeRouteArgs{key: $key}';
  }
}

/// generated route for
/// [CLoginTab]
class CLoginRoute extends PageRouteInfo<CLoginRouteArgs> {
  CLoginRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          CLoginRoute.name,
          args: CLoginRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'CLoginRoute';

  static const PageInfo<CLoginRouteArgs> page = PageInfo<CLoginRouteArgs>(name);
}

class CLoginRouteArgs {
  const CLoginRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'CLoginRouteArgs{key: $key}';
  }
}

/// generated route for
/// [COTPVerificationPage]
class COTPVerificationRoute extends PageRouteInfo<COTPVerificationRouteArgs> {
  COTPVerificationRoute({
    String? email,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          COTPVerificationRoute.name,
          args: COTPVerificationRouteArgs(
            email: email,
            key: key,
          ),
          rawQueryParams: {'email': email},
          initialChildren: children,
        );

  static const String name = 'COTPVerificationRoute';

  static const PageInfo<COTPVerificationRouteArgs> page =
      PageInfo<COTPVerificationRouteArgs>(name);
}

class COTPVerificationRouteArgs {
  const COTPVerificationRouteArgs({
    this.email,
    this.key,
  });

  final String? email;

  final Key? key;

  @override
  String toString() {
    return 'COTPVerificationRouteArgs{email: $email, key: $key}';
  }
}

/// generated route for
/// [CSettingsPage]
class CSettingsRoute extends PageRouteInfo<void> {
  const CSettingsRoute({List<PageRouteInfo>? children})
      : super(
          CSettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'CSettingsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CSigninPage]
class CSigninRoute extends PageRouteInfo<void> {
  const CSigninRoute({List<PageRouteInfo>? children})
      : super(
          CSigninRoute.name,
          initialChildren: children,
        );

  static const String name = 'CSigninRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CSignupTab]
class CSignupRoute extends PageRouteInfo<CSignupRouteArgs> {
  CSignupRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          CSignupRoute.name,
          args: CSignupRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'CSignupRoute';

  static const PageInfo<CSignupRouteArgs> page =
      PageInfo<CSignupRouteArgs>(name);
}

class CSignupRouteArgs {
  const CSignupRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'CSignupRouteArgs{key: $key}';
  }
}
