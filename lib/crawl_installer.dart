import 'package:args/command_runner.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class InstallCommand extends Command {
  @override
  void run() {
    _installPackage(argResults!.arguments.first);
  }

  _installPackage(String name) async {
    final res = await http.get(Uri.parse('https://pub.dev/api/packages/$name'));

    if (res.statusCode == HttpStatus.notFound) {
      print(res.body);
      exit(1);
    }

    final data = json.decode(res.body);
    var version = data['latest']['version'];

    final pubspec = File('pubspec.yaml').readAsStringSync();

    final up = pubspec.replaceFirst(
        'dependencies:\n', 'dependencies:\n  $name: $version\n');

    File('pubspec.yaml').writeAsStringSync(up);

    Process.runSync('pub', ['get']);
  }

  @override
  String get description => 'Adds a pacakage to the project';

  @override
  String get name => 'install';
}
