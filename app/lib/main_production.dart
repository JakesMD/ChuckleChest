import 'package:chuckle_chest/app/app.dart';
import 'package:chuckle_chest/bootstrap/bootstrap.dart';
import 'package:cpub/supabase_flutter.dart';
import 'package:flutter/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // debugRepaintRainbowEnabled = true;
  await Supabase.initialize(
    url: const String.fromEnvironment('SUPABASE_PROJECT_URL'),
    anonKey: const String.fromEnvironment('SUPABASE_ANON_KEY'),
  );

  await bootstrap(() => const ChuckleChestApp(flavor: CAppFlavor.production));
}
