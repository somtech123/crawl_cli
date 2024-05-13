import 'package:args/command_runner.dart';
import 'package:crawl_installer/crawl_installer.dart' as crawl_installer;

void main(List<String> args) async {
  final runner = CommandRunner('crawl', 'manage packages in your dart project')
    ..addCommand(crawl_installer.InstallCommand());

  await runner.run(args);
}
