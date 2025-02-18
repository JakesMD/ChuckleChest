// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'routes.dart';

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
      final args = routeData.argsAs<CChestRouteArgs>(
          orElse: () => const CChestRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: CChestPage(
          chestID: args.chestID,
          key: args.key,
        )),
      );
    },
    CCollectionsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const CCollectionsPage()),
      );
    },
    CCreateGemRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const CCreateGemPage()),
      );
    },
    CDemoRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const CDemoPage()),
      );
    },
    CEditAvatarRoute.name: (routeData) {
      final args = routeData.argsAs<CEditAvatarRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: CEditAvatarPage(
          personID: args.personID,
          avatarURL: args.avatarURL,
          key: args.key,
        )),
      );
    },
    CEditGemRoute.name: (routeData) {
      final args = routeData.argsAs<CEditGemRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: CEditGemPage(
          initialGem: args.initialGem,
          key: args.key,
        )),
      );
    },
    CEditPersonRoute.name: (routeData) {
      final args = routeData.argsAs<CEditPersonRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: CEditPersonPage(
          person: args.person,
          isPersonNew: args.isPersonNew,
          key: args.key,
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
    CGetStartedRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const CGetStartedPage()),
      );
    },
    CHomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const CHomePage()),
      );
    },
    CInvitationsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const CInvitationsPage()),
      );
    },
    CInvitedRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const CInvitedTab()),
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
    CLogsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CLogsPage(),
      );
    },
    CManageChestRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const CManageChestPage()),
      );
    },
    CMembersRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const CMembersTab()),
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
    CPeopleRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const CPeoplePage()),
      );
    },
    CRandomCollectionRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const CRandomCollectionPage()),
      );
    },
    CRecentsCollectionRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const CRecentsCollectionPage()),
      );
    },
    CSettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const CSettingsPage()),
      );
    },
    CSharedGemRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<CSharedGemRouteArgs>(
          orElse: () =>
              CSharedGemRouteArgs(shareToken: queryParams.optString('token')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: CSharedGemPage(
          shareToken: args.shareToken,
          key: args.key,
        )),
      );
    },
    CSigninRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const CSigninPage()),
      );
    },
    CSignupRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const CSignupTab()),
      );
    },
    CYearCollectionRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<CYearCollectionRouteArgs>(
          orElse: () =>
              CYearCollectionRouteArgs(year: pathParams.getInt('year')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: CYearCollectionPage(
          year: args.year,
          key: args.key,
        )),
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
    String? chestID,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          CChestRoute.name,
          args: CChestRouteArgs(
            chestID: chestID,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'CChestRoute';

  static const PageInfo<CChestRouteArgs> page = PageInfo<CChestRouteArgs>(name);
}

class CChestRouteArgs {
  const CChestRouteArgs({
    this.chestID,
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
/// [CCollectionsPage]
class CCollectionsRoute extends PageRouteInfo<void> {
  const CCollectionsRoute({List<PageRouteInfo>? children})
      : super(
          CCollectionsRoute.name,
          initialChildren: children,
        );

  static const String name = 'CCollectionsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
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
/// [CDemoPage]
class CDemoRoute extends PageRouteInfo<void> {
  const CDemoRoute({List<PageRouteInfo>? children})
      : super(
          CDemoRoute.name,
          initialChildren: children,
        );

  static const String name = 'CDemoRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CEditAvatarPage]
class CEditAvatarRoute extends PageRouteInfo<CEditAvatarRouteArgs> {
  CEditAvatarRoute({
    required BigInt personID,
    required CAvatarURL avatarURL,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          CEditAvatarRoute.name,
          args: CEditAvatarRouteArgs(
            personID: personID,
            avatarURL: avatarURL,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'CEditAvatarRoute';

  static const PageInfo<CEditAvatarRouteArgs> page =
      PageInfo<CEditAvatarRouteArgs>(name);
}

class CEditAvatarRouteArgs {
  const CEditAvatarRouteArgs({
    required this.personID,
    required this.avatarURL,
    this.key,
  });

  final BigInt personID;

  final CAvatarURL avatarURL;

  final Key? key;

  @override
  String toString() {
    return 'CEditAvatarRouteArgs{personID: $personID, avatarURL: $avatarURL, key: $key}';
  }
}

/// generated route for
/// [CEditGemPage]
class CEditGemRoute extends PageRouteInfo<CEditGemRouteArgs> {
  CEditGemRoute({
    required CGem? initialGem,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          CEditGemRoute.name,
          args: CEditGemRouteArgs(
            initialGem: initialGem,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'CEditGemRoute';

  static const PageInfo<CEditGemRouteArgs> page =
      PageInfo<CEditGemRouteArgs>(name);
}

class CEditGemRouteArgs {
  const CEditGemRouteArgs({
    required this.initialGem,
    this.key,
  });

  final CGem? initialGem;

  final Key? key;

  @override
  String toString() {
    return 'CEditGemRouteArgs{initialGem: $initialGem, key: $key}';
  }
}

/// generated route for
/// [CEditPersonPage]
class CEditPersonRoute extends PageRouteInfo<CEditPersonRouteArgs> {
  CEditPersonRoute({
    required CPerson person,
    bool isPersonNew = false,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          CEditPersonRoute.name,
          args: CEditPersonRouteArgs(
            person: person,
            isPersonNew: isPersonNew,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'CEditPersonRoute';

  static const PageInfo<CEditPersonRouteArgs> page =
      PageInfo<CEditPersonRouteArgs>(name);
}

class CEditPersonRouteArgs {
  const CEditPersonRouteArgs({
    required this.person,
    this.isPersonNew = false,
    this.key,
  });

  final CPerson person;

  final bool isPersonNew;

  final Key? key;

  @override
  String toString() {
    return 'CEditPersonRouteArgs{person: $person, isPersonNew: $isPersonNew, key: $key}';
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
class CHomeRoute extends PageRouteInfo<void> {
  const CHomeRoute({List<PageRouteInfo>? children})
      : super(
          CHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'CHomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CInvitationsPage]
class CInvitationsRoute extends PageRouteInfo<void> {
  const CInvitationsRoute({List<PageRouteInfo>? children})
      : super(
          CInvitationsRoute.name,
          initialChildren: children,
        );

  static const String name = 'CInvitationsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CInvitedTab]
class CInvitedRoute extends PageRouteInfo<void> {
  const CInvitedRoute({List<PageRouteInfo>? children})
      : super(
          CInvitedRoute.name,
          initialChildren: children,
        );

  static const String name = 'CInvitedRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
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
/// [CLogsPage]
class CLogsRoute extends PageRouteInfo<void> {
  const CLogsRoute({List<PageRouteInfo>? children})
      : super(
          CLogsRoute.name,
          initialChildren: children,
        );

  static const String name = 'CLogsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CManageChestPage]
class CManageChestRoute extends PageRouteInfo<void> {
  const CManageChestRoute({List<PageRouteInfo>? children})
      : super(
          CManageChestRoute.name,
          initialChildren: children,
        );

  static const String name = 'CManageChestRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CMembersTab]
class CMembersRoute extends PageRouteInfo<void> {
  const CMembersRoute({List<PageRouteInfo>? children})
      : super(
          CMembersRoute.name,
          initialChildren: children,
        );

  static const String name = 'CMembersRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
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
/// [CPeoplePage]
class CPeopleRoute extends PageRouteInfo<void> {
  const CPeopleRoute({List<PageRouteInfo>? children})
      : super(
          CPeopleRoute.name,
          initialChildren: children,
        );

  static const String name = 'CPeopleRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CRandomCollectionPage]
class CRandomCollectionRoute extends PageRouteInfo<void> {
  const CRandomCollectionRoute({List<PageRouteInfo>? children})
      : super(
          CRandomCollectionRoute.name,
          initialChildren: children,
        );

  static const String name = 'CRandomCollectionRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CRecentsCollectionPage]
class CRecentsCollectionRoute extends PageRouteInfo<void> {
  const CRecentsCollectionRoute({List<PageRouteInfo>? children})
      : super(
          CRecentsCollectionRoute.name,
          initialChildren: children,
        );

  static const String name = 'CRecentsCollectionRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
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
/// [CSharedGemPage]
class CSharedGemRoute extends PageRouteInfo<CSharedGemRouteArgs> {
  CSharedGemRoute({
    required String? shareToken,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          CSharedGemRoute.name,
          args: CSharedGemRouteArgs(
            shareToken: shareToken,
            key: key,
          ),
          rawQueryParams: {'token': shareToken},
          initialChildren: children,
        );

  static const String name = 'CSharedGemRoute';

  static const PageInfo<CSharedGemRouteArgs> page =
      PageInfo<CSharedGemRouteArgs>(name);
}

class CSharedGemRouteArgs {
  const CSharedGemRouteArgs({
    required this.shareToken,
    this.key,
  });

  final String? shareToken;

  final Key? key;

  @override
  String toString() {
    return 'CSharedGemRouteArgs{shareToken: $shareToken, key: $key}';
  }
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
class CSignupRoute extends PageRouteInfo<void> {
  const CSignupRoute({List<PageRouteInfo>? children})
      : super(
          CSignupRoute.name,
          initialChildren: children,
        );

  static const String name = 'CSignupRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CYearCollectionPage]
class CYearCollectionRoute extends PageRouteInfo<CYearCollectionRouteArgs> {
  CYearCollectionRoute({
    required int year,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          CYearCollectionRoute.name,
          args: CYearCollectionRouteArgs(
            year: year,
            key: key,
          ),
          rawPathParams: {'year': year},
          initialChildren: children,
        );

  static const String name = 'CYearCollectionRoute';

  static const PageInfo<CYearCollectionRouteArgs> page =
      PageInfo<CYearCollectionRouteArgs>(name);
}

class CYearCollectionRouteArgs {
  const CYearCollectionRouteArgs({
    required this.year,
    this.key,
  });

  final int year;

  final Key? key;

  @override
  String toString() {
    return 'CYearCollectionRouteArgs{year: $year, key: $key}';
  }
}
