// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resume.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Resume _$ResumeFromJson(Map json) {
  return Resume(
    json['details'] == null
        ? null
        : ResumeDetails.fromJson(json['details'] as Map),
    (json['education'] as List)
        ?.map((e) => e == null ? null : Education.fromJson(e as Map))
        ?.toList(),
    (json['skills'] as List)
        ?.map((e) => e == null ? null : Skill.fromJson(e as Map))
        ?.toList(),
    (json['contributions'] as List)
        ?.map((e) => e == null ? null : Contribution.fromJson(e as Map))
        ?.toList(),
    (json['industry'] as List)
        ?.map((e) => e == null ? null : Industry.fromJson(e as Map))
        ?.toList(),
    json['about'] as String,
    json['clause'] as String,
  );
}

Map<String, dynamic> _$ResumeToJson(Resume instance) => <String, dynamic>{
      'details': instance.details,
      'about': instance.about,
      'education': instance.education,
      'skills': instance.skills,
      'contributions': instance.contributions,
      'industry': instance.industry,
      'clause': instance.clause,
    };

ResumeDetails _$ResumeDetailsFromJson(Map json) {
  return ResumeDetails(
    firstName: json['first_name'] as String,
    lastName: json['last_name'] as String,
    email: json['email'] as String,
    github: json['github'] as String,
    skype: json['skype'] as String,
    linkedin: json['linkedin'] as String,
    phone: json['phone'] as String,
  );
}

Map<String, dynamic> _$ResumeDetailsToJson(ResumeDetails instance) =>
    <String, dynamic>{
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'github': instance.github,
      'skype': instance.skype,
      'linkedin': instance.linkedin,
      'phone': instance.phone,
    };

Education _$EducationFromJson(Map json) {
  return Education(
    json['school'] as String,
    json['location'] as String,
    json['degree'] as String,
    json['dates'] == null ? null : DateRange.fromJson(json['dates'] as String),
  );
}

Map<String, dynamic> _$EducationToJson(Education instance) => <String, dynamic>{
      'school': instance.school,
      'location': instance.location,
      'degree': instance.degree,
      'dates': instance.dates,
    };

Industry _$IndustryFromJson(Map json) {
  return Industry(
    json['place'] as String,
    json['location'] as String,
    json['title'] as String,
    json['dates'] == null ? null : DateRange.fromJson(json['dates'] as String),
    (json['cases'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$IndustryToJson(Industry instance) => <String, dynamic>{
      'place': instance.place,
      'location': instance.location,
      'title': instance.title,
      'dates': instance.dates,
      'cases': instance.cases,
    };

Skill _$SkillFromJson(Map json) {
  return Skill(
    json['name'] as String,
    json['info'] as String,
  );
}

Map<String, dynamic> _$SkillToJson(Skill instance) => <String, dynamic>{
      'name': instance.name,
      'info': instance.info,
    };

Contribution _$ContributionFromJson(Map json) {
  return Contribution(
    json['url'] as String,
    json['name'] as String,
    json['summary'] as String,
  );
}

Map<String, dynamic> _$ContributionToJson(Contribution instance) =>
    <String, dynamic>{
      'url': instance.url,
      'name': instance.name,
      'summary': instance.summary,
    };
