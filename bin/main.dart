import 'dart:io';
import 'package:dart_cv/renderer.dart';
import 'package:dart_cv/resume.dart';
import 'package:dart_cv/social_link.dart';

Future<void> main(List<String> arguments) async {
  await loadSvgsPath();

  final name = arguments.firstOrNull ?? 'example.yaml';
  final cv = Resume.open(name);

  final renderer = Renderer();
  final pdf = renderer.buildDocument(cv);

  File(name.replaceFirst('.yaml', '.pdf')).writeAsBytesSync(await pdf.save());
}
