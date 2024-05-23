import 'package:chuckle_chest/app/app.dart';
import 'package:chuckle_chest/bootstrap/bootstrap.dart';
import 'package:cplatform_client/cplatform_client.dart';
import 'package:cpub/supabase_flutter.dart';
import 'package:flutter/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // debugRepaintRainbowEnabled = true;
  await Supabase.initialize(
    url: CPlatformClient.operatingSystem == COperatingSystem.android
        ? 'http://10.0.2.2:54321'
        : 'http://localhost:54321',
    anonKey:
        '''***REMOVED***''',
  );

  await bootstrap(() => ChuckleChestApp(flavor: CAppFlavor.development));
}
