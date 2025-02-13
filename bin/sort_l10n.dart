// This is not production code.
// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

String? parseArbDirFromYaml(String yamlContent) {
  final lines = yamlContent.split('\n');
  for (final line in lines) {
    if (line.trim().startsWith('arb-dir:')) {
      final parts = line.split(':');
      if (parts.length == 2) return parts[1].trim();
    }
  }
  return null;
}

Future<void> sortArbFile(File file) async {
  final content = await file.readAsString();

  final jsonContent = jsonDecode(content) as Map<String, dynamic>;

  final mainKeys = <String>[];
  final metaKeys = <String>[];

  for (final key in jsonContent.keys) {
    if (key.startsWith('@') && !key.startsWith('@@')) {
      metaKeys.add(key);
    } else {
      mainKeys.add(key);
    }
  }

  mainKeys.sort();

  final sortedMap = <String, dynamic>{};
  for (final key in mainKeys) {
    sortedMap[key] = jsonContent[key];
    final metaKey = '@$key';
    if (jsonContent.containsKey(metaKey)) {
      sortedMap[metaKey] = jsonContent[metaKey];
    }
  }

  final sortedContent = const JsonEncoder.withIndent('  ').convert(sortedMap);
  await file.writeAsString(sortedContent);
}

void main(List<String> arguments) async {
  if (arguments.length != 1) {
    print('Usage: dart sort_l10n.dart <arb_config_path>');
    exit(1);
  }

  // Read the 10n.yaml file
  final configFile = File(arguments[0]);
  if (!configFile.existsSync()) {
    print('The specified configuration file does not exist.');
    exit(1);
  }

  final configContent = await configFile.readAsString();
  final directoryPath = parseArbDirFromYaml(configContent);

  if (directoryPath == null) {
    print('The arb directory is not specified in the config file.');
    exit(1);
  }

  final directory = Directory(directoryPath);

  if (!directory.existsSync()) {
    print('The arb directory specified in the config file does not exist.');
    exit(1);
  }

  for (final file in directory.listSync()) {
    if (file is File && file.path.endsWith('.arb')) {
      await sortArbFile(file);
    }
  }

  print('All ARB files have been sorted successfully.');
  exit(0);
}
