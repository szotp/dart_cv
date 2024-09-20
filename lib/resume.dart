import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:yaml/yaml.dart';

part 'resume.g.dart';

const yaml = JsonSerializable(
  anyMap: true,
  fieldRename: FieldRename.snake,
);

@yaml
class Resume {
  final ResumeDetails details;
  final String about;
  final List<Education> education;
  final List<Skill> skills;
  final List<Contribution> contributions;
  final List<Industry> industry;
  final String? clause;

  Resume(
    this.details,
    this.education,
    this.skills,
    this.contributions,
    this.industry,
    this.about,
    this.clause,
  );
  factory Resume.fromJson(Map json) => _$ResumeFromJson(json);
  Map<String, dynamic> toJson() => _$ResumeToJson(this);

  factory Resume.open(String path) {
    final yaml = File(path).readAsStringSync();
    final file = loadYaml(yaml);
    return Resume.fromJson(file);
  }
}

@yaml
class ResumeDetails {
  final String firstName;
  final String lastName;
  final String email;
  final String github;
  final String skype;
  final String linkedin;
  final String phone;

  ResumeDetails({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.github,
    required this.skype,
    required this.linkedin,
    required this.phone,
  });

  factory ResumeDetails.fromJson(Map json) => _$ResumeDetailsFromJson(json);
  Map toJson() => _$ResumeDetailsToJson(this);
}

@yaml
class Education {
  final String school;
  final String location;
  final String degree;
  final DateRange dates;
  Education(this.school, this.location, this.degree, this.dates);

  factory Education.fromJson(Map json) => _$EducationFromJson(json);
  Map toJson() => _$EducationToJson(this);
}

@yaml
class Industry {
  final String place;
  final String location;
  final String title;
  final DateRange dates;
  final List<String> cases;

  Industry(this.place, this.location, this.title, this.dates, this.cases);

  factory Industry.fromJson(Map json) => _$IndustryFromJson(json);
  Map toJson() => _$IndustryToJson(this);
}

@yaml
class Skill {
  final String name;
  final String? info;
  Skill(this.name, this.info);

  factory Skill.fromJson(Map json) => _$SkillFromJson(json);
  Map toJson() => _$SkillToJson(this);
}

@yaml
class Contribution {
  final String url;
  final String name;
  final String summary;

  Contribution(this.url, this.name, this.summary);

  factory Contribution.fromJson(Map json) => _$ContributionFromJson(json);
  Map toJson() => _$ContributionToJson(this);
}

class DateRange {
  final String value;
  DateRange(this.value);

  factory DateRange.fromJson(String json) => DateRange(json);
  String toJson() => value;
}
