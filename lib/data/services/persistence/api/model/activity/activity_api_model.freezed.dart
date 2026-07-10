// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity_api_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ActivityApiModel {

@JsonKey(includeFromJson: false, includeToJson: false) String? get id; String? get title; String? get description; String? get relatedId; String get type; String? get thumbnailUrl;@FirestoreTimestampConverter() DateTime get createdAt;
/// Create a copy of ActivityApiModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActivityApiModelCopyWith<ActivityApiModel> get copyWith => _$ActivityApiModelCopyWithImpl<ActivityApiModel>(this as ActivityApiModel, _$identity);

  /// Serializes this ActivityApiModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivityApiModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.relatedId, relatedId) || other.relatedId == relatedId)&&(identical(other.type, type) || other.type == type)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,relatedId,type,thumbnailUrl,createdAt);

@override
String toString() {
  return 'ActivityApiModel(id: $id, title: $title, description: $description, relatedId: $relatedId, type: $type, thumbnailUrl: $thumbnailUrl, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $ActivityApiModelCopyWith<$Res>  {
  factory $ActivityApiModelCopyWith(ActivityApiModel value, $Res Function(ActivityApiModel) _then) = _$ActivityApiModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeFromJson: false, includeToJson: false) String? id, String? title, String? description, String? relatedId, String type, String? thumbnailUrl,@FirestoreTimestampConverter() DateTime createdAt
});




}
/// @nodoc
class _$ActivityApiModelCopyWithImpl<$Res>
    implements $ActivityApiModelCopyWith<$Res> {
  _$ActivityApiModelCopyWithImpl(this._self, this._then);

  final ActivityApiModel _self;
  final $Res Function(ActivityApiModel) _then;

/// Create a copy of ActivityApiModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? title = freezed,Object? description = freezed,Object? relatedId = freezed,Object? type = null,Object? thumbnailUrl = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,relatedId: freezed == relatedId ? _self.relatedId : relatedId // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ActivityApiModel].
extension ActivityApiModelPatterns on ActivityApiModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActivityApiModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActivityApiModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActivityApiModel value)  $default,){
final _that = this;
switch (_that) {
case _ActivityApiModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActivityApiModel value)?  $default,){
final _that = this;
switch (_that) {
case _ActivityApiModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeFromJson: false, includeToJson: false)  String? id,  String? title,  String? description,  String? relatedId,  String type,  String? thumbnailUrl, @FirestoreTimestampConverter()  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActivityApiModel() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.relatedId,_that.type,_that.thumbnailUrl,_that.createdAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeFromJson: false, includeToJson: false)  String? id,  String? title,  String? description,  String? relatedId,  String type,  String? thumbnailUrl, @FirestoreTimestampConverter()  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _ActivityApiModel():
return $default(_that.id,_that.title,_that.description,_that.relatedId,_that.type,_that.thumbnailUrl,_that.createdAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeFromJson: false, includeToJson: false)  String? id,  String? title,  String? description,  String? relatedId,  String type,  String? thumbnailUrl, @FirestoreTimestampConverter()  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _ActivityApiModel() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.relatedId,_that.type,_that.thumbnailUrl,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ActivityApiModel implements ActivityApiModel {
  const _ActivityApiModel({@JsonKey(includeFromJson: false, includeToJson: false) this.id, this.title, this.description, this.relatedId, this.type = 'post', this.thumbnailUrl, @FirestoreTimestampConverter() required this.createdAt});
  factory _ActivityApiModel.fromJson(Map<String, dynamic> json) => _$ActivityApiModelFromJson(json);

@override@JsonKey(includeFromJson: false, includeToJson: false) final  String? id;
@override final  String? title;
@override final  String? description;
@override final  String? relatedId;
@override@JsonKey() final  String type;
@override final  String? thumbnailUrl;
@override@FirestoreTimestampConverter() final  DateTime createdAt;

/// Create a copy of ActivityApiModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActivityApiModelCopyWith<_ActivityApiModel> get copyWith => __$ActivityApiModelCopyWithImpl<_ActivityApiModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActivityApiModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActivityApiModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.relatedId, relatedId) || other.relatedId == relatedId)&&(identical(other.type, type) || other.type == type)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,relatedId,type,thumbnailUrl,createdAt);

@override
String toString() {
  return 'ActivityApiModel(id: $id, title: $title, description: $description, relatedId: $relatedId, type: $type, thumbnailUrl: $thumbnailUrl, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ActivityApiModelCopyWith<$Res> implements $ActivityApiModelCopyWith<$Res> {
  factory _$ActivityApiModelCopyWith(_ActivityApiModel value, $Res Function(_ActivityApiModel) _then) = __$ActivityApiModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeFromJson: false, includeToJson: false) String? id, String? title, String? description, String? relatedId, String type, String? thumbnailUrl,@FirestoreTimestampConverter() DateTime createdAt
});




}
/// @nodoc
class __$ActivityApiModelCopyWithImpl<$Res>
    implements _$ActivityApiModelCopyWith<$Res> {
  __$ActivityApiModelCopyWithImpl(this._self, this._then);

  final _ActivityApiModel _self;
  final $Res Function(_ActivityApiModel) _then;

/// Create a copy of ActivityApiModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? title = freezed,Object? description = freezed,Object? relatedId = freezed,Object? type = null,Object? thumbnailUrl = freezed,Object? createdAt = null,}) {
  return _then(_ActivityApiModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,relatedId: freezed == relatedId ? _self.relatedId : relatedId // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
