import 'package:chuckle_chest/app/app.dart';
import 'package:chuckle_chest/bootstrap/bootstrap.dart';
import 'package:cpub/supabase_flutter.dart';
import 'package:flutter/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // debugRepaintRainbowEnabled = true;
  await Supabase.initialize(
    url: '***REMOVED***',
    anonKey:
        '''***REMOVED***''',
  );

  await bootstrap(() => ChuckleChestApp(flavor: CAppFlavor.production));
}
