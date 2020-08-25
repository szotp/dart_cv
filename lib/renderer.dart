import 'dart:io';

import 'package:dart_cv/resume.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import 'social_link.dart';

class Renderer {
  final styleLocation = TextStyle(color: PdfColors.grey);
  final styleSubtitle = TextStyle(fontSize: 10);
  final styleName = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final styleLink =
      TextStyle(color: PdfColor.fromInt(0xFF007ACC), fontSize: 10);
  final leftColumnWidth = 150.0;

  Document buildDocument(Resume resume) {
    final pdf = Document(
      theme: ThemeData.withFont(
        base: loadFont('font/Lato-Regular.ttf'),
        bold: loadFont('font/Lato-Bold.ttf'),
        italic: loadFont('font/Lato-Italic.ttf'),
      ),
    );

    pdf.addPage(MultiPage(
      pageTheme: PageTheme(
        margin: EdgeInsets.all(40),
      ),
      build: (context) => buildResume(context, resume),
    ));

    return pdf;
  }

  List<Widget> buildResume(Context context, Resume resume) {
    return [
      ...buildDetails(resume.details, resume.about),
      ...buildSection(resume.industry.reversed, 'Industry', buildIndustry),
      ...buildSection(resume.education, 'Education', buildEducation),
      ...buildSection(resume.skills, 'Skills', buildSkill),
      ...buildSection(
        resume.contributions,
        'Contributions',
        buildContribution,
      ),
      Expanded(child: SizedBox()),
      Text(resume.clause,
          style: TextStyle(color: PdfColors.blueGrey500, fontSize: 8)),
    ];
  }

  List<Widget> buildDetails(ResumeDetails details, String about) {
    return [
      Text(
        '${details.firstName} ${details.lastName}',
        style: styleName,
      ),
      SizedBox(height: 48),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: leftColumnWidth,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SocialLink.github(details.github),
              SocialLink.email(details.email),
              SocialLink.phone(details.phone),
              SocialLink.linkedin(details.linkedin),
              SocialLink.skype(details.skype),
            ]),
          ),
          Expanded(child: Text(about)),
        ],
      )
    ];
  }

  Widget buildEducation(Education model) {
    return buildTimedSection(model.dates, [
      Text(model.degree, style: TextStyle(fontWeight: FontWeight.bold)),
      Text(model.school.toString()),
      Text(model.location, style: styleLocation),
    ]);
  }

  Widget buildIndustry(Industry model) {
    Widget buildCase(String e) {
      return Padding(
        padding: EdgeInsets.only(top: 2),
        child: Text('- $e', style: styleSubtitle),
      );
    }

    return buildTimedSection(model.dates, [
      Text(model.title.toString(),
          style: TextStyle(fontWeight: FontWeight.bold)),
      Text(model.place),
      Text(model.location, style: styleLocation),
      ...model.cases.reversed.map(buildCase),
    ]);
  }

  Widget buildContribution(Contribution model) {
    return buildBulletColumn([
      Text(model.name),
      UrlLink(child: Text(model.url, style: styleLink), destination: model.url),
      Text(model.summary, style: styleSubtitle),
      SizedBox(height: 4),
    ]);
  }

  Widget buildSkill(Skill model) {
    return buildBulletColumn([
      Text(model.name),
      if (model.info != null) Text(model.info, style: styleSubtitle),
    ]);
  }

  List<Widget> buildSection<T>(
    Iterable<T> items,
    String title,
    Widget Function(T) builder,
  ) {
    const nonSpannable = 1;

    return [
      SizedBox(
          child: Column(children: [
        Header(text: title, padding: EdgeInsets.only(top: 20)),
        ...items.take(nonSpannable).map(builder),
      ])),
      ...items.skip(nonSpannable).map(builder),
    ];
  }

  Widget buildTimedSection(DateRange date, List<Widget> rows) {
    return Padding(
        padding: EdgeInsets.only(bottom: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: leftColumnWidth, child: Text(date.value)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: rows,
              ),
            ),
          ],
        ));
  }
}

Widget buildBulletColumn(List<Widget> rows) {
  return Padding(
    padding: EdgeInsets.only(bottom: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BulletPoint(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: rows,
          ),
        ),
      ],
    ),
  );
}

Font loadFont(String name) {
  return Font.ttf(File(name).readAsBytesSync().buffer.asByteData());
}

class BulletPoint extends StatelessWidget {
  @override
  Widget build(Context context) {
    return Padding(
      padding: EdgeInsets.only(right: 4),
      child: Stack(children: [
        Opacity(
          opacity: 0,
          child: Text('||'),
        ),
        Positioned(
          left: 0,
          top: 0,
          bottom: 0,
          right: 0,
          child: Center(
            child: Container(
              width: 5,
              height: 5,
              decoration:
                  BoxDecoration(color: PdfColors.black, shape: BoxShape.circle),
            ),
          ),
        ),
      ]),
    );
  }
}
