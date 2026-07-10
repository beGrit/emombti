// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Activity _$ActivityFromJson(Map<String, dynamic> json) => _Activity(
  id: json['id'] as String,
  title: json['title'] as String?,
  description: json['description'] as String?,
  relatedId: json['relatedId'] as String?,
  type: $enumDecode(_$ActivityTypeEnumMap, json['type']),
  thumbnailUrl: json['thumbnailUrl'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$ActivityToJson(_Activity instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'relatedId': instance.relatedId,
  'type': _$ActivityTypeEnumMap[instance.type]!,
  'thumbnailUrl': instance.thumbnailUrl,
  'createdAt': instance.createdAt.toIso8601String(),
};

const _$ActivityTypeEnumMap = {
  ActivityType.post: 'post',
  ActivityType.video: 'video',
  ActivityType.popular: 'popular',
};
