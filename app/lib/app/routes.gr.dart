// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'routes.dart';

/// generated route for
/// [CBasePage]
class CBaseRoute extends PageRouteInfo<void> {
  const CBaseRoute({List<PageRouteInfo>? children})
      : super(CBaseRoute.name, initialChildren: children);

  static const String name = 'CBaseRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const CBasePage());
    },
  );
}

/// generated route for
/// [CChangeAvatarPage]
class CChangeAvatarRoute extends PageRouteInfo<CChangeAvatarRouteArgs> {
  CChangeAvatarRoute({
    required BigInt personID,
    required CAvatarURL avatarURL,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          CChangeAvatarRoute.name,
          args: CChangeAvatarRouteArgs(
            personID: personID,
            avatarURL: avatarURL,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'CChangeAvatarRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CChangeAvatarRouteArgs>();
      return WrappedRoute(
        child: CChangeAvatarPage(
          personID: args.personID,
          avatarURL: args.avatarURL,
          key: args.key,
        ),
      );
    },
  );
}

class CChangeAvatarRouteArgs {
  const CChangeAvatarRouteArgs({
    required this.personID,
    required this.avatarURL,
    this.key,
  });

  final BigInt personID;

  final CAvatarURL avatarURL;

  final Key? key;

  @override
  String toString() {
    return 'CChangeAvatarRouteArgs{personID: $personID, avatarURL: $avatarURL, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CChangeAvatarRouteArgs) return false;
    return personID == other.personID &&
        avatarURL == other.avatarURL &&
        key == other.key;
  }

  @override
  int get hashCode => personID.hashCode ^ avatarURL.hashCode ^ key.hashCode;
}

/// generated route for
/// [CChestPage]
class CChestRoute extends PageRouteInfo<CChestRouteArgs> {
  CChestRoute({String? chestID, Key? key, List<PageRouteInfo>? children})
      : super(
          CChestRoute.name,
          args: CChestRouteArgs(chestID: chestID, key: key),
          initialChildren: children,
        );

  static const String name = 'CChestRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CChestRouteArgs>(
        orElse: () => const CChestRouteArgs(),
      );
      return WrappedRoute(
        child: CChestPage(chestID: args.chestID, key: args.key),
      );
    },
  );
}

class CChestRouteArgs {
  const CChestRouteArgs({this.chestID, this.key});

  final String? chestID;

  final Key? key;

  @override
  String toString() {
    return 'CChestRouteArgs{chestID: $chestID, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CChestRouteArgs) return false;
    return chestID == other.chestID && key == other.key;
  }

  @override
  int get hashCode => chestID.hashCode ^ key.hashCode;
}

/// generated route for
/// [CCollectionsPage]
class CCollectionsRoute extends PageRouteInfo<void> {
  const CCollectionsRoute({List<PageRouteInfo>? children})
      : super(CCollectionsRoute.name, initialChildren: children);

  static const String name = 'CCollectionsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const CCollectionsPage());
    },
  );
}

/// generated route for
/// [CCreateChestPage]
class CCreateChestRoute extends PageRouteInfo<CCreateChestRouteArgs> {
  CCreateChestRoute({Key? key, List<PageRouteInfo>? children})
      : super(
          CCreateChestRoute.name,
          args: CCreateChestRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'CCreateChestRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CCreateChestRouteArgs>(
        orElse: () => const CCreateChestRouteArgs(),
      );
      return WrappedRoute(child: CCreateChestPage(key: args.key));
    },
  );
}

class CCreateChestRouteArgs {
  const CCreateChestRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'CCreateChestRouteArgs{key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CCreateChestRouteArgs) return false;
    return key == other.key;
  }

  @override
  int get hashCode => key.hashCode;
}

/// generated route for
/// [CCreateGemPage]
class CCreateGemRoute extends PageRouteInfo<void> {
  const CCreateGemRoute({List<PageRouteInfo>? children})
      : super(CCreateGemRoute.name, initialChildren: children);

  static const String name = 'CCreateGemRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const CCreateGemPage());
    },
  );
}

/// generated route for
/// [CDemoPage]
class CDemoRoute extends PageRouteInfo<void> {
  const CDemoRoute({List<PageRouteInfo>? children})
      : super(CDemoRoute.name, initialChildren: children);

  static const String name = 'CDemoRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const CDemoPage());
    },
  );
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
          args: CEditGemRouteArgs(initialGem: initialGem, key: key),
          initialChildren: children,
        );

  static const String name = 'CEditGemRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CEditGemRouteArgs>();
      return WrappedRoute(
        child: CEditGemPage(initialGem: args.initialGem, key: args.key),
      );
    },
  );
}

class CEditGemRouteArgs {
  const CEditGemRouteArgs({required this.initialGem, this.key});

  final CGem? initialGem;

  final Key? key;

  @override
  String toString() {
    return 'CEditGemRouteArgs{initialGem: $initialGem, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CEditGemRouteArgs) return false;
    return initialGem == other.initialGem && key == other.key;
  }

  @override
  int get hashCode => initialGem.hashCode ^ key.hashCode;
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

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CEditPersonRouteArgs>();
      return WrappedRoute(
        child: CEditPersonPage(
          person: args.person,
          isPersonNew: args.isPersonNew,
          key: args.key,
        ),
      );
    },
  );
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CEditPersonRouteArgs) return false;
    return person == other.person &&
        isPersonNew == other.isPersonNew &&
        key == other.key;
  }

  @override
  int get hashCode => person.hashCode ^ isPersonNew.hashCode ^ key.hashCode;
}

/// generated route for
/// [CGemPage]
class CGemRoute extends PageRouteInfo<CGemRouteArgs> {
  CGemRoute({required String gemID, Key? key, List<PageRouteInfo>? children})
      : super(
          CGemRoute.name,
          args: CGemRouteArgs(gemID: gemID, key: key),
          rawPathParams: {'gemID': gemID},
          initialChildren: children,
        );

  static const String name = 'CGemRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<CGemRouteArgs>(
        orElse: () => CGemRouteArgs(gemID: pathParams.getString('gemID')),
      );
      return WrappedRoute(
        child: CGemPage(gemID: args.gemID, key: args.key),
      );
    },
  );
}

class CGemRouteArgs {
  const CGemRouteArgs({required this.gemID, this.key});

  final String gemID;

  final Key? key;

  @override
  String toString() {
    return 'CGemRouteArgs{gemID: $gemID, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CGemRouteArgs) return false;
    return gemID == other.gemID && key == other.key;
  }

  @override
  int get hashCode => gemID.hashCode ^ key.hashCode;
}

/// generated route for
/// [CGetStartedPage]
class CGetStartedRoute extends PageRouteInfo<void> {
  const CGetStartedRoute({List<PageRouteInfo>? children})
      : super(CGetStartedRoute.name, initialChildren: children);

  static const String name = 'CGetStartedRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const CGetStartedPage());
    },
  );
}

/// generated route for
/// [CHomePage]
class CHomeRoute extends PageRouteInfo<void> {
  const CHomeRoute({List<PageRouteInfo>? children})
      : super(CHomeRoute.name, initialChildren: children);

  static const String name = 'CHomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const CHomePage());
    },
  );
}

/// generated route for
/// [CInvitationsPage]
class CInvitationsRoute extends PageRouteInfo<void> {
  const CInvitationsRoute({List<PageRouteInfo>? children})
      : super(CInvitationsRoute.name, initialChildren: children);

  static const String name = 'CInvitationsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const CInvitationsPage());
    },
  );
}

/// generated route for
/// [CInvitedPage]
class CInvitedRoute extends PageRouteInfo<void> {
  const CInvitedRoute({List<PageRouteInfo>? children})
      : super(CInvitedRoute.name, initialChildren: children);

  static const String name = 'CInvitedRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const CInvitedPage());
    },
  );
}

/// generated route for
/// [CLoginTab]
class CLoginRoute extends PageRouteInfo<CLoginRouteArgs> {
  CLoginRoute({Key? key, List<PageRouteInfo>? children})
      : super(
          CLoginRoute.name,
          args: CLoginRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'CLoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CLoginRouteArgs>(
        orElse: () => const CLoginRouteArgs(),
      );
      return WrappedRoute(child: CLoginTab(key: args.key));
    },
  );
}

class CLoginRouteArgs {
  const CLoginRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'CLoginRouteArgs{key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CLoginRouteArgs) return false;
    return key == other.key;
  }

  @override
  int get hashCode => key.hashCode;
}

/// generated route for
/// [CLogsPage]
class CLogsRoute extends PageRouteInfo<void> {
  const CLogsRoute({List<PageRouteInfo>? children})
      : super(CLogsRoute.name, initialChildren: children);

  static const String name = 'CLogsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CLogsPage();
    },
  );
}

/// generated route for
/// [CManageChestPage]
class CManageChestRoute extends PageRouteInfo<void> {
  const CManageChestRoute({List<PageRouteInfo>? children})
      : super(CManageChestRoute.name, initialChildren: children);

  static const String name = 'CManageChestRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const CManageChestPage());
    },
  );
}

/// generated route for
/// [CMembersPage]
class CMembersRoute extends PageRouteInfo<void> {
  const CMembersRoute({List<PageRouteInfo>? children})
      : super(CMembersRoute.name, initialChildren: children);

  static const String name = 'CMembersRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const CMembersPage());
    },
  );
}

/// generated route for
/// [CPeoplePage]
class CPeopleRoute extends PageRouteInfo<void> {
  const CPeopleRoute({List<PageRouteInfo>? children})
      : super(CPeopleRoute.name, initialChildren: children);

  static const String name = 'CPeopleRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const CPeoplePage());
    },
  );
}

/// generated route for
/// [CRandomCollectionPage]
class CRandomCollectionRoute extends PageRouteInfo<void> {
  const CRandomCollectionRoute({List<PageRouteInfo>? children})
      : super(CRandomCollectionRoute.name, initialChildren: children);

  static const String name = 'CRandomCollectionRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const CRandomCollectionPage());
    },
  );
}

/// generated route for
/// [CRecentsCollectionPage]
class CRecentsCollectionRoute extends PageRouteInfo<void> {
  const CRecentsCollectionRoute({List<PageRouteInfo>? children})
      : super(CRecentsCollectionRoute.name, initialChildren: children);

  static const String name = 'CRecentsCollectionRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const CRecentsCollectionPage());
    },
  );
}

/// generated route for
/// [CSettingsPage]
class CSettingsRoute extends PageRouteInfo<void> {
  const CSettingsRoute({List<PageRouteInfo>? children})
      : super(CSettingsRoute.name, initialChildren: children);

  static const String name = 'CSettingsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const CSettingsPage());
    },
  );
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
          args: CSharedGemRouteArgs(shareToken: shareToken, key: key),
          rawQueryParams: {'token': shareToken},
          initialChildren: children,
        );

  static const String name = 'CSharedGemRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final queryParams = data.queryParams;
      final args = data.argsAs<CSharedGemRouteArgs>(
        orElse: () =>
            CSharedGemRouteArgs(shareToken: queryParams.optString('token')),
      );
      return WrappedRoute(
        child: CSharedGemPage(shareToken: args.shareToken, key: args.key),
      );
    },
  );
}

class CSharedGemRouteArgs {
  const CSharedGemRouteArgs({required this.shareToken, this.key});

  final String? shareToken;

  final Key? key;

  @override
  String toString() {
    return 'CSharedGemRouteArgs{shareToken: $shareToken, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CSharedGemRouteArgs) return false;
    return shareToken == other.shareToken && key == other.key;
  }

  @override
  int get hashCode => shareToken.hashCode ^ key.hashCode;
}

/// generated route for
/// [CSigninPage]
class CSigninRoute extends PageRouteInfo<void> {
  const CSigninRoute({List<PageRouteInfo>? children})
      : super(CSigninRoute.name, initialChildren: children);

  static const String name = 'CSigninRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const CSigninPage());
    },
  );
}

/// generated route for
/// [CSignupTab]
class CSignupRoute extends PageRouteInfo<void> {
  const CSignupRoute({List<PageRouteInfo>? children})
      : super(CSignupRoute.name, initialChildren: children);

  static const String name = 'CSignupRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const CSignupTab());
    },
  );
}

/// generated route for
/// [CVerifyOTPPage]
class CVerifyOTPRoute extends PageRouteInfo<CVerifyOTPRouteArgs> {
  CVerifyOTPRoute({String? email, Key? key, List<PageRouteInfo>? children})
      : super(
          CVerifyOTPRoute.name,
          args: CVerifyOTPRouteArgs(email: email, key: key),
          rawQueryParams: {'email': email},
          initialChildren: children,
        );

  static const String name = 'CVerifyOTPRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final queryParams = data.queryParams;
      final args = data.argsAs<CVerifyOTPRouteArgs>(
        orElse: () =>
            CVerifyOTPRouteArgs(email: queryParams.optString('email')),
      );
      return WrappedRoute(
        child: CVerifyOTPPage(email: args.email, key: args.key),
      );
    },
  );
}

class CVerifyOTPRouteArgs {
  const CVerifyOTPRouteArgs({this.email, this.key});

  final String? email;

  final Key? key;

  @override
  String toString() {
    return 'CVerifyOTPRouteArgs{email: $email, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CVerifyOTPRouteArgs) return false;
    return email == other.email && key == other.key;
  }

  @override
  int get hashCode => email.hashCode ^ key.hashCode;
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
          args: CYearCollectionRouteArgs(year: year, key: key),
          rawPathParams: {'year': year},
          initialChildren: children,
        );

  static const String name = 'CYearCollectionRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<CYearCollectionRouteArgs>(
        orElse: () => CYearCollectionRouteArgs(year: pathParams.getInt('year')),
      );
      return WrappedRoute(
        child: CYearCollectionPage(year: args.year, key: args.key),
      );
    },
  );
}

class CYearCollectionRouteArgs {
  const CYearCollectionRouteArgs({required this.year, this.key});

  final int year;

  final Key? key;

  @override
  String toString() {
    return 'CYearCollectionRouteArgs{year: $year, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CYearCollectionRouteArgs) return false;
    return year == other.year && key == other.key;
  }

  @override
  int get hashCode => year.hashCode ^ key.hashCode;
}
