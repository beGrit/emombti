// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserApiModel _$UserApiModelFromJson(Map<String, dynamic> json) =>
    _UserApiModel(
      id: json['id'] as String,
      collectionId: json['collectionId'] as String,
      collectionName: json['collectionName'] as String,
      username: json['username'] as String?,
      email: json['email'] as String?,
      emailVisibility: json['emailVisibility'] as bool?,
      verified: json['verified'] as bool?,
      name: json['name'] as String?,
      mbtiType: json['mbtiType'] as String?,
      introduce: json['introduce'] as String?,
      avatar: json['avatar'] as String?,
      created: DateTime.parse(json['created'] as String),
      updated: DateTime.parse(json['updated'] as String),
    );

Map<String, dynamic> _$UserApiModelToJson(_UserApiModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'collectionId': instance.collectionId,
      'collectionName': instance.collectionName,
      'username': instance.username,
      'email': instance.email,
      'emailVisibility': instance.emailVisibility,
      'verified': instance.verified,
      'name': instance.name,
      'mbtiType': instance.mbtiType,
      'introduce': instance.introduce,
      'avatar': instance.avatar,
      'created': instance.created.toIso8601String(),
      'updated': instance.updated.toIso8601String(),
    };

_UserFirestoreApiModel _$UserFirestoreApiModelFromJson(
  Map<String, dynamic> json,
) => _UserFirestoreApiModel(
  id: json['id'] as String,
  email: json['email'] as String?,
  password: json['password'] as String?,
  name: json['name'] as String?,
  mbtiType: json['mbtiType'] as String?,
  introduce: json['introduce'] as String?,
  avatar: json['avatar'] as String?,
  backgroundImg: json['backgroundImg'] as String?,
  created: json['created'] == null
      ? null
      : DateTime.parse(json['created'] as String),
  updated: json['updated'] == null
      ? null
      : DateTime.parse(json['updated'] as String),
);

Map<String, dynamic> _$UserFirestoreApiModelToJson(
  _UserFirestoreApiModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'password': instance.password,
  'name': instance.name,
  'mbtiType': instance.mbtiType,
  'introduce': instance.introduce,
  'avatar': instance.avatar,
  'backgroundImg': instance.backgroundImg,
  'created': instance.created?.toIso8601String(),
  'updated': instance.updated?.toIso8601String(),
};
