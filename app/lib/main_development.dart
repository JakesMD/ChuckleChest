import 'package:chuckle_chest/app/app.dart';
import 'package:chuckle_chest/bootstrap/bootstrap.dart';
import 'package:cplatform_client/cplatform_client.dart';
import 'package:cpub/supabase_flutter.dart';
import 'package:flutter/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // debugRepaintRainbowEnabled = true;
  await Supabase.initialize(
    url: CPlatformClient.operatingSystem == COperatingSystem.android &&
            CPlatformClient.deviceType != CDeviceType.mobileWeb
        ? 'http://10.0.2.2:54321'
        : 'http://localhost:54321',
    anonKey:
        '''eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0''',
  );

  await bootstrap(() => ChuckleChestApp(flavor: CAppFlavor.development));
}
