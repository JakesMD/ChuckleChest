// This is not production code.
// ignore_for_file: avoid_print

import 'dart:io';

void main(List<String> arguments) {
  if (arguments.length != 1) {
    print('Usage: dart lcov_coverage.dart <lcov_file_path>');
    exit(1);
  }

  final lcovFile = File(arguments[0]);

  if (!lcovFile.existsSync()) {
    print('The provided LCOV file does not exist. Creating it...');
    lcovFile.createSync(recursive: true);
  }

  final lines = lcovFile.readAsStringSync().split('\n');
  var totalLines = 0;
  var coveredLines = 0;

  for (final line in lines) {
    if (line.startsWith('DA:')) {
      final lineData = line.substring(3).split(',');
      if (lineData.length == 2) {
        final hit = int.parse(lineData[1]);
        if (hit > 0) coveredLines++;
        totalLines++;
      }
    }
  }

  if (totalLines > 0) {
    final coverage = (coveredLines / totalLines) * 100;
    print('Code coverage: ${coverage.toStringAsFixed(2)}%');
    if (coverage != 100) exit(1);
    exit(0);
  } else {
    print('No code coverage information found in the LCOV file.');
    exit(0);
  }
}
