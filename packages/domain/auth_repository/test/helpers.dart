import 'package:cauth_repository/cauth_repository.dart';
import 'package:ccore/ccore.dart';

CAuthUserChest createChest({
  String? id,
  String? name,
  CUserRole? userRole,
}) =>
    CAuthUserChest(
      id: id ?? 'asdsada',
      name: name ?? 'asdasd',
      userRole: userRole ?? CUserRole.viewer,
    );
