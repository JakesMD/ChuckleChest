import 'package:chuckle_chest/app/app.dart';
import 'package:chuckle_chest/app/bootstrap/bootstrap.dart';

void main() {
  bootstrap(
    (dependencyContext) => ChuckleChestApp(
      flavor: CAppFlavor.staging,
      dependencyContext: dependencyContext,
    ),
  );
}
