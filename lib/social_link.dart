import 'dart:io';
import 'dart:isolate';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:path/path.dart' as p;
import 'package:xml/xml.dart' as xml;

String svgsPath = '';

Future<void> loadSvgsPath() async {
  final brandsUri =
      await Isolate.resolvePackageUri(Uri.parse('package:dart_cv/assets/icons'));
  svgsPath = brandsUri!.toFilePath();
}

Widget loadIcon(String name) {
  final svgString = File(p.join(svgsPath, name)).readAsStringSync();
  final doc = xml.XmlDocument.parse(svgString);

  final svg = doc.rootElement;
  final viewBox = svg.getAttribute('viewBox');
  final viewBoxValues = viewBox!.split(' ').map((x) => double.parse(x)).toList();

  final path = doc.findAllElements('path').first;
  var d = path.getAttribute('d')!;

  return SizedBox(
    width: 10,
    height: 10,
    child: Shape(
      d,
      width: viewBoxValues[2],
      height: viewBoxValues[3],
      fillColor: PdfColors.black,
    ),
  );
}

class SocialLink extends StatelessWidget {
  final String social;
  final String value;
  final String destination;

  SocialLink(this.social, this.value, this.destination);

  factory SocialLink.skype(String value) {
    return SocialLink('skype.svg', value, 'skype:$value?chat');
  }

  factory SocialLink.github(String value) {
    return SocialLink('github.svg', value, 'https://github.com/$value');
  }

  factory SocialLink.linkedin(String value) {
    return SocialLink(
        'linkedin.svg', value, 'https://www.linkedin.com/in/$value');
  }

  factory SocialLink.email(String value) {
    return SocialLink('envelope.svg', value, 'mailto:$value');
  }

  factory SocialLink.phone(String value) {
    final link = value.replaceAll(' ', '');
    return SocialLink('phone.svg', value, 'tel:$link');
  }

  @override
  Widget build(Context context) {
    return Row(
      children: [
        loadIcon(social),
        SizedBox(width: 2),
        UrlLink(
          child: Text(value,
              style: TextStyle(color: PdfColors.blue, fontSize: 10)),
          destination: destination,
        ),
      ],
    );
  }
}
