// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ActivityApiModel _$ActivityApiModelFromJson(Map<String, dynamic> json) =>
    _ActivityApiModel(
      title: json['title'] as String?,
      description: json['description'] as String?,
      relatedId: json['relatedId'] as String?,
      type: json['type'] as String? ?? 'post',
      thumbnailUrl: json['thumbnailUrl'] as String?,
      createdAt: const FirestoreTimestampConverter().fromJson(
        json['createdAt'],
      ),
    );

Map<String, dynamic> _$ActivityApiModelToJson(
  _ActivityApiModel instance,
) => <String, dynamic>{
  'title': instance.title,
  'description': instance.description,
  'relatedId': instance.relatedId,
  'type': instance.type,
  'thumbnailUrl': instance.thumbnailUrl,
  'createdAt': const FirestoreTimestampConverter().toJson(instance.createdAt),
};
