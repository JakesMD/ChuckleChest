import 'package:chuckle_chest/app/app.dart';
import 'package:chuckle_chest/bootstrap/bootstrap.dart';
import 'package:cpub/supabase_flutter.dart';
import 'package:flutter/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // debugRepaintRainbowEnabled = true;
  await Supabase.initialize(
    url: 'https://mgopsyysiuhacmfpxpdd.supabase.co',
    anonKey:
        '''eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1nb3BzeXlzaXVoYWNtZnB4cGRkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTY0OTAwODMsImV4cCI6MjAzMjA2NjA4M30.ptP4yS8tqzKfN4IcTo2TqbN8N98hgPBjON9O-VbqfV4''',
  );

  await bootstrap(() => ChuckleChestApp(flavor: CAppFlavor.production));
}
