import 'dart:io';
import 'package:dart_cv/renderer.dart';
import 'package:dart_cv/resume.dart';
import 'package:dart_cv/social_link.dart';

Future<void> main(List<String> arguments) async {
  await loadSvgsPath();

  final name = 'cv';

  final cv = Resume.open('$name.yaml');

  final renderer = Renderer();
  final pdf = renderer.buildDocument(cv);

  File('$name.pdf').writeAsBytesSync(await pdf.save());
}
