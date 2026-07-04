// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_api_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserApiModel {

 String get id; String get collectionId; String get collectionName; String? get username; String? get email; bool? get emailVisibility; bool? get verified; String? get name; String? get mbtiType; String? get introduce; String? get avatar; DateTime get created; DateTime get updated;
/// Create a copy of UserApiModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserApiModelCopyWith<UserApiModel> get copyWith => _$UserApiModelCopyWithImpl<UserApiModel>(this as UserApiModel, _$identity);

  /// Serializes this UserApiModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserApiModel&&(identical(other.id, id) || other.id == id)&&(identical(other.collectionId, collectionId) || other.collectionId == collectionId)&&(identical(other.collectionName, collectionName) || other.collectionName == collectionName)&&(identical(other.username, username) || other.username == username)&&(identical(other.email, email) || other.email == email)&&(identical(other.emailVisibility, emailVisibility) || other.emailVisibility == emailVisibility)&&(identical(other.verified, verified) || other.verified == verified)&&(identical(other.name, name) || other.name == name)&&(identical(other.mbtiType, mbtiType) || other.mbtiType == mbtiType)&&(identical(other.introduce, introduce) || other.introduce == introduce)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,collectionId,collectionName,username,email,emailVisibility,verified,name,mbtiType,introduce,avatar,created,updated);

@override
String toString() {
  return 'UserApiModel(id: $id, collectionId: $collectionId, collectionName: $collectionName, username: $username, email: $email, emailVisibility: $emailVisibility, verified: $verified, name: $name, mbtiType: $mbtiType, introduce: $introduce, avatar: $avatar, created: $created, updated: $updated)';
}


}

/// @nodoc
abstract mixin class $UserApiModelCopyWith<$Res>  {
  factory $UserApiModelCopyWith(UserApiModel value, $Res Function(UserApiModel) _then) = _$UserApiModelCopyWithImpl;
@useResult
$Res call({
 String id, String collectionId, String collectionName, String? username, String? email, bool? emailVisibility, bool? verified, String? name, String? mbtiType, String? introduce, String? avatar, DateTime created, DateTime updated
});




}
/// @nodoc
class _$UserApiModelCopyWithImpl<$Res>
    implements $UserApiModelCopyWith<$Res> {
  _$UserApiModelCopyWithImpl(this._self, this._then);

  final UserApiModel _self;
  final $Res Function(UserApiModel) _then;

/// Create a copy of UserApiModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? collectionId = null,Object? collectionName = null,Object? username = freezed,Object? email = freezed,Object? emailVisibility = freezed,Object? verified = freezed,Object? name = freezed,Object? mbtiType = freezed,Object? introduce = freezed,Object? avatar = freezed,Object? created = null,Object? updated = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,collectionId: null == collectionId ? _self.collectionId : collectionId // ignore: cast_nullable_to_non_nullable
as String,collectionName: null == collectionName ? _self.collectionName : collectionName // ignore: cast_nullable_to_non_nullable
as String,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,emailVisibility: freezed == emailVisibility ? _self.emailVisibility : emailVisibility // ignore: cast_nullable_to_non_nullable
as bool?,verified: freezed == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,mbtiType: freezed == mbtiType ? _self.mbtiType : mbtiType // ignore: cast_nullable_to_non_nullable
as String?,introduce: freezed == introduce ? _self.introduce : introduce // ignore: cast_nullable_to_non_nullable
as String?,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [UserApiModel].
extension UserApiModelPatterns on UserApiModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserApiModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserApiModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserApiModel value)  $default,){
final _that = this;
switch (_that) {
case _UserApiModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserApiModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserApiModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String collectionId,  String collectionName,  String? username,  String? email,  bool? emailVisibility,  bool? verified,  String? name,  String? mbtiType,  String? introduce,  String? avatar,  DateTime created,  DateTime updated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserApiModel() when $default != null:
return $default(_that.id,_that.collectionId,_that.collectionName,_that.username,_that.email,_that.emailVisibility,_that.verified,_that.name,_that.mbtiType,_that.introduce,_that.avatar,_that.created,_that.updated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String collectionId,  String collectionName,  String? username,  String? email,  bool? emailVisibility,  bool? verified,  String? name,  String? mbtiType,  String? introduce,  String? avatar,  DateTime created,  DateTime updated)  $default,) {final _that = this;
switch (_that) {
case _UserApiModel():
return $default(_that.id,_that.collectionId,_that.collectionName,_that.username,_that.email,_that.emailVisibility,_that.verified,_that.name,_that.mbtiType,_that.introduce,_that.avatar,_that.created,_that.updated);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String collectionId,  String collectionName,  String? username,  String? email,  bool? emailVisibility,  bool? verified,  String? name,  String? mbtiType,  String? introduce,  String? avatar,  DateTime created,  DateTime updated)?  $default,) {final _that = this;
switch (_that) {
case _UserApiModel() when $default != null:
return $default(_that.id,_that.collectionId,_that.collectionName,_that.username,_that.email,_that.emailVisibility,_that.verified,_that.name,_that.mbtiType,_that.introduce,_that.avatar,_that.created,_that.updated);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserApiModel implements UserApiModel {
  const _UserApiModel({required this.id, required this.collectionId, required this.collectionName, this.username, this.email, this.emailVisibility, this.verified, this.name, this.mbtiType, this.introduce, this.avatar, required this.created, required this.updated});
  factory _UserApiModel.fromJson(Map<String, dynamic> json) => _$UserApiModelFromJson(json);

@override final  String id;
@override final  String collectionId;
@override final  String collectionName;
@override final  String? username;
@override final  String? email;
@override final  bool? emailVisibility;
@override final  bool? verified;
@override final  String? name;
@override final  String? mbtiType;
@override final  String? introduce;
@override final  String? avatar;
@override final  DateTime created;
@override final  DateTime updated;

/// Create a copy of UserApiModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserApiModelCopyWith<_UserApiModel> get copyWith => __$UserApiModelCopyWithImpl<_UserApiModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserApiModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserApiModel&&(identical(other.id, id) || other.id == id)&&(identical(other.collectionId, collectionId) || other.collectionId == collectionId)&&(identical(other.collectionName, collectionName) || other.collectionName == collectionName)&&(identical(other.username, username) || other.username == username)&&(identical(other.email, email) || other.email == email)&&(identical(other.emailVisibility, emailVisibility) || other.emailVisibility == emailVisibility)&&(identical(other.verified, verified) || other.verified == verified)&&(identical(other.name, name) || other.name == name)&&(identical(other.mbtiType, mbtiType) || other.mbtiType == mbtiType)&&(identical(other.introduce, introduce) || other.introduce == introduce)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,collectionId,collectionName,username,email,emailVisibility,verified,name,mbtiType,introduce,avatar,created,updated);

@override
String toString() {
  return 'UserApiModel(id: $id, collectionId: $collectionId, collectionName: $collectionName, username: $username, email: $email, emailVisibility: $emailVisibility, verified: $verified, name: $name, mbtiType: $mbtiType, introduce: $introduce, avatar: $avatar, created: $created, updated: $updated)';
}


}

/// @nodoc
abstract mixin class _$UserApiModelCopyWith<$Res> implements $UserApiModelCopyWith<$Res> {
  factory _$UserApiModelCopyWith(_UserApiModel value, $Res Function(_UserApiModel) _then) = __$UserApiModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String collectionId, String collectionName, String? username, String? email, bool? emailVisibility, bool? verified, String? name, String? mbtiType, String? introduce, String? avatar, DateTime created, DateTime updated
});




}
/// @nodoc
class __$UserApiModelCopyWithImpl<$Res>
    implements _$UserApiModelCopyWith<$Res> {
  __$UserApiModelCopyWithImpl(this._self, this._then);

  final _UserApiModel _self;
  final $Res Function(_UserApiModel) _then;

/// Create a copy of UserApiModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? collectionId = null,Object? collectionName = null,Object? username = freezed,Object? email = freezed,Object? emailVisibility = freezed,Object? verified = freezed,Object? name = freezed,Object? mbtiType = freezed,Object? introduce = freezed,Object? avatar = freezed,Object? created = null,Object? updated = null,}) {
  return _then(_UserApiModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,collectionId: null == collectionId ? _self.collectionId : collectionId // ignore: cast_nullable_to_non_nullable
as String,collectionName: null == collectionName ? _self.collectionName : collectionName // ignore: cast_nullable_to_non_nullable
as String,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,emailVisibility: freezed == emailVisibility ? _self.emailVisibility : emailVisibility // ignore: cast_nullable_to_non_nullable
as bool?,verified: freezed == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,mbtiType: freezed == mbtiType ? _self.mbtiType : mbtiType // ignore: cast_nullable_to_non_nullable
as String?,introduce: freezed == introduce ? _self.introduce : introduce // ignore: cast_nullable_to_non_nullable
as String?,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$UserFirestoreApiModel {

 String get id; String? get email; String? get password; String? get name; String? get mbtiType; String? get introduce; String? get avatar; String? get backgroundImg; DateTime? get created; DateTime? get updated;
/// Create a copy of UserFirestoreApiModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserFirestoreApiModelCopyWith<UserFirestoreApiModel> get copyWith => _$UserFirestoreApiModelCopyWithImpl<UserFirestoreApiModel>(this as UserFirestoreApiModel, _$identity);

  /// Serializes this UserFirestoreApiModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserFirestoreApiModel&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.name, name) || other.name == name)&&(identical(other.mbtiType, mbtiType) || other.mbtiType == mbtiType)&&(identical(other.introduce, introduce) || other.introduce == introduce)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.backgroundImg, backgroundImg) || other.backgroundImg == backgroundImg)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,password,name,mbtiType,introduce,avatar,backgroundImg,created,updated);

@override
String toString() {
  return 'UserFirestoreApiModel(id: $id, email: $email, password: $password, name: $name, mbtiType: $mbtiType, introduce: $introduce, avatar: $avatar, backgroundImg: $backgroundImg, created: $created, updated: $updated)';
}


}

/// @nodoc
abstract mixin class $UserFirestoreApiModelCopyWith<$Res>  {
  factory $UserFirestoreApiModelCopyWith(UserFirestoreApiModel value, $Res Function(UserFirestoreApiModel) _then) = _$UserFirestoreApiModelCopyWithImpl;
@useResult
$Res call({
 String id, String? email, String? password, String? name, String? mbtiType, String? introduce, String? avatar, String? backgroundImg, DateTime? created, DateTime? updated
});




}
/// @nodoc
class _$UserFirestoreApiModelCopyWithImpl<$Res>
    implements $UserFirestoreApiModelCopyWith<$Res> {
  _$UserFirestoreApiModelCopyWithImpl(this._self, this._then);

  final UserFirestoreApiModel _self;
  final $Res Function(UserFirestoreApiModel) _then;

/// Create a copy of UserFirestoreApiModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? email = freezed,Object? password = freezed,Object? name = freezed,Object? mbtiType = freezed,Object? introduce = freezed,Object? avatar = freezed,Object? backgroundImg = freezed,Object? created = freezed,Object? updated = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,password: freezed == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,mbtiType: freezed == mbtiType ? _self.mbtiType : mbtiType // ignore: cast_nullable_to_non_nullable
as String?,introduce: freezed == introduce ? _self.introduce : introduce // ignore: cast_nullable_to_non_nullable
as String?,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,backgroundImg: freezed == backgroundImg ? _self.backgroundImg : backgroundImg // ignore: cast_nullable_to_non_nullable
as String?,created: freezed == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime?,updated: freezed == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserFirestoreApiModel].
extension UserFirestoreApiModelPatterns on UserFirestoreApiModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserFirestoreApiModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserFirestoreApiModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserFirestoreApiModel value)  $default,){
final _that = this;
switch (_that) {
case _UserFirestoreApiModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserFirestoreApiModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserFirestoreApiModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? email,  String? password,  String? name,  String? mbtiType,  String? introduce,  String? avatar,  String? backgroundImg,  DateTime? created,  DateTime? updated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserFirestoreApiModel() when $default != null:
return $default(_that.id,_that.email,_that.password,_that.name,_that.mbtiType,_that.introduce,_that.avatar,_that.backgroundImg,_that.created,_that.updated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? email,  String? password,  String? name,  String? mbtiType,  String? introduce,  String? avatar,  String? backgroundImg,  DateTime? created,  DateTime? updated)  $default,) {final _that = this;
switch (_that) {
case _UserFirestoreApiModel():
return $default(_that.id,_that.email,_that.password,_that.name,_that.mbtiType,_that.introduce,_that.avatar,_that.backgroundImg,_that.created,_that.updated);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? email,  String? password,  String? name,  String? mbtiType,  String? introduce,  String? avatar,  String? backgroundImg,  DateTime? created,  DateTime? updated)?  $default,) {final _that = this;
switch (_that) {
case _UserFirestoreApiModel() when $default != null:
return $default(_that.id,_that.email,_that.password,_that.name,_that.mbtiType,_that.introduce,_that.avatar,_that.backgroundImg,_that.created,_that.updated);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserFirestoreApiModel implements UserFirestoreApiModel {
  const _UserFirestoreApiModel({required this.id, this.email, this.password, this.name, this.mbtiType, this.introduce, this.avatar, this.backgroundImg, this.created, this.updated});
  factory _UserFirestoreApiModel.fromJson(Map<String, dynamic> json) => _$UserFirestoreApiModelFromJson(json);

@override final  String id;
@override final  String? email;
@override final  String? password;
@override final  String? name;
@override final  String? mbtiType;
@override final  String? introduce;
@override final  String? avatar;
@override final  String? backgroundImg;
@override final  DateTime? created;
@override final  DateTime? updated;

/// Create a copy of UserFirestoreApiModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserFirestoreApiModelCopyWith<_UserFirestoreApiModel> get copyWith => __$UserFirestoreApiModelCopyWithImpl<_UserFirestoreApiModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserFirestoreApiModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserFirestoreApiModel&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.name, name) || other.name == name)&&(identical(other.mbtiType, mbtiType) || other.mbtiType == mbtiType)&&(identical(other.introduce, introduce) || other.introduce == introduce)&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.backgroundImg, backgroundImg) || other.backgroundImg == backgroundImg)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,password,name,mbtiType,introduce,avatar,backgroundImg,created,updated);

@override
String toString() {
  return 'UserFirestoreApiModel(id: $id, email: $email, password: $password, name: $name, mbtiType: $mbtiType, introduce: $introduce, avatar: $avatar, backgroundImg: $backgroundImg, created: $created, updated: $updated)';
}


}

/// @nodoc
abstract mixin class _$UserFirestoreApiModelCopyWith<$Res> implements $UserFirestoreApiModelCopyWith<$Res> {
  factory _$UserFirestoreApiModelCopyWith(_UserFirestoreApiModel value, $Res Function(_UserFirestoreApiModel) _then) = __$UserFirestoreApiModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String? email, String? password, String? name, String? mbtiType, String? introduce, String? avatar, String? backgroundImg, DateTime? created, DateTime? updated
});




}
/// @nodoc
class __$UserFirestoreApiModelCopyWithImpl<$Res>
    implements _$UserFirestoreApiModelCopyWith<$Res> {
  __$UserFirestoreApiModelCopyWithImpl(this._self, this._then);

  final _UserFirestoreApiModel _self;
  final $Res Function(_UserFirestoreApiModel) _then;

/// Create a copy of UserFirestoreApiModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? email = freezed,Object? password = freezed,Object? name = freezed,Object? mbtiType = freezed,Object? introduce = freezed,Object? avatar = freezed,Object? backgroundImg = freezed,Object? created = freezed,Object? updated = freezed,}) {
  return _then(_UserFirestoreApiModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,password: freezed == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,mbtiType: freezed == mbtiType ? _self.mbtiType : mbtiType // ignore: cast_nullable_to_non_nullable
as String?,introduce: freezed == introduce ? _self.introduce : introduce // ignore: cast_nullable_to_non_nullable
as String?,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,backgroundImg: freezed == backgroundImg ? _self.backgroundImg : backgroundImg // ignore: cast_nullable_to_non_nullable
as String?,created: freezed == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime?,updated: freezed == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
