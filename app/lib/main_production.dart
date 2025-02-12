import 'package:chuckle_chest/app/app.dart';
import 'package:chuckle_chest/bootstrap/bootstrap.dart';

void main() {
  bootstrap(() => const ChuckleChestApp(flavor: CAppFlavor.production));
}
