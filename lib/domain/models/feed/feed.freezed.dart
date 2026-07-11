// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FeedEvent {

 FeedEventType get eventType; FeedType get feedType; String get feedId;
/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedEventCopyWith<FeedEvent> get copyWith => _$FeedEventCopyWithImpl<FeedEvent>(this as FeedEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedEvent&&(identical(other.eventType, eventType) || other.eventType == eventType)&&(identical(other.feedType, feedType) || other.feedType == feedType)&&(identical(other.feedId, feedId) || other.feedId == feedId));
}


@override
int get hashCode => Object.hash(runtimeType,eventType,feedType,feedId);

@override
String toString() {
  return 'FeedEvent(eventType: $eventType, feedType: $feedType, feedId: $feedId)';
}


}

/// @nodoc
abstract mixin class $FeedEventCopyWith<$Res>  {
  factory $FeedEventCopyWith(FeedEvent value, $Res Function(FeedEvent) _then) = _$FeedEventCopyWithImpl;
@useResult
$Res call({
 FeedEventType eventType, FeedType feedType, String feedId
});




}
/// @nodoc
class _$FeedEventCopyWithImpl<$Res>
    implements $FeedEventCopyWith<$Res> {
  _$FeedEventCopyWithImpl(this._self, this._then);

  final FeedEvent _self;
  final $Res Function(FeedEvent) _then;

/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventType = null,Object? feedType = null,Object? feedId = null,}) {
  return _then(_self.copyWith(
eventType: null == eventType ? _self.eventType : eventType // ignore: cast_nullable_to_non_nullable
as FeedEventType,feedType: null == feedType ? _self.feedType : feedType // ignore: cast_nullable_to_non_nullable
as FeedType,feedId: null == feedId ? _self.feedId : feedId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FeedEvent].
extension FeedEventPatterns on FeedEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedEvent value)  $default,){
final _that = this;
switch (_that) {
case _FeedEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedEvent value)?  $default,){
final _that = this;
switch (_that) {
case _FeedEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( FeedEventType eventType,  FeedType feedType,  String feedId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedEvent() when $default != null:
return $default(_that.eventType,_that.feedType,_that.feedId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( FeedEventType eventType,  FeedType feedType,  String feedId)  $default,) {final _that = this;
switch (_that) {
case _FeedEvent():
return $default(_that.eventType,_that.feedType,_that.feedId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( FeedEventType eventType,  FeedType feedType,  String feedId)?  $default,) {final _that = this;
switch (_that) {
case _FeedEvent() when $default != null:
return $default(_that.eventType,_that.feedType,_that.feedId);case _:
  return null;

}
}

}

/// @nodoc


class _FeedEvent implements FeedEvent {
  const _FeedEvent({required this.eventType, required this.feedType, required this.feedId});
  

@override final  FeedEventType eventType;
@override final  FeedType feedType;
@override final  String feedId;

/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedEventCopyWith<_FeedEvent> get copyWith => __$FeedEventCopyWithImpl<_FeedEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedEvent&&(identical(other.eventType, eventType) || other.eventType == eventType)&&(identical(other.feedType, feedType) || other.feedType == feedType)&&(identical(other.feedId, feedId) || other.feedId == feedId));
}


@override
int get hashCode => Object.hash(runtimeType,eventType,feedType,feedId);

@override
String toString() {
  return 'FeedEvent(eventType: $eventType, feedType: $feedType, feedId: $feedId)';
}


}

/// @nodoc
abstract mixin class _$FeedEventCopyWith<$Res> implements $FeedEventCopyWith<$Res> {
  factory _$FeedEventCopyWith(_FeedEvent value, $Res Function(_FeedEvent) _then) = __$FeedEventCopyWithImpl;
@override @useResult
$Res call({
 FeedEventType eventType, FeedType feedType, String feedId
});




}
/// @nodoc
class __$FeedEventCopyWithImpl<$Res>
    implements _$FeedEventCopyWith<$Res> {
  __$FeedEventCopyWithImpl(this._self, this._then);

  final _FeedEvent _self;
  final $Res Function(_FeedEvent) _then;

/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventType = null,Object? feedType = null,Object? feedId = null,}) {
  return _then(_FeedEvent(
eventType: null == eventType ? _self.eventType : eventType // ignore: cast_nullable_to_non_nullable
as FeedEventType,feedType: null == feedType ? _self.feedType : feedType // ignore: cast_nullable_to_non_nullable
as FeedType,feedId: null == feedId ? _self.feedId : feedId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$Post {

 String? get id; FeedType get feedType; String? get title; String? get body; List<AppFile> get photos; User get author; DateTime get created; DateTime get updated;
/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostCopyWith<Post> get copyWith => _$PostCopyWithImpl<Post>(this as Post, _$identity);

  /// Serializes this Post to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Post&&(identical(other.id, id) || other.id == id)&&(identical(other.feedType, feedType) || other.feedType == feedType)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&const DeepCollectionEquality().equals(other.photos, photos)&&(identical(other.author, author) || other.author == author)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,feedType,title,body,const DeepCollectionEquality().hash(photos),author,created,updated);

@override
String toString() {
  return 'Post(id: $id, feedType: $feedType, title: $title, body: $body, photos: $photos, author: $author, created: $created, updated: $updated)';
}


}

/// @nodoc
abstract mixin class $PostCopyWith<$Res>  {
  factory $PostCopyWith(Post value, $Res Function(Post) _then) = _$PostCopyWithImpl;
@useResult
$Res call({
 String? id, FeedType feedType, String? title, String? body, List<AppFile> photos, User author, DateTime created, DateTime updated
});


$UserCopyWith<$Res> get author;

}
/// @nodoc
class _$PostCopyWithImpl<$Res>
    implements $PostCopyWith<$Res> {
  _$PostCopyWithImpl(this._self, this._then);

  final Post _self;
  final $Res Function(Post) _then;

/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? feedType = null,Object? title = freezed,Object? body = freezed,Object? photos = null,Object? author = null,Object? created = null,Object? updated = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,feedType: null == feedType ? _self.feedType : feedType // ignore: cast_nullable_to_non_nullable
as FeedType,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,photos: null == photos ? _self.photos : photos // ignore: cast_nullable_to_non_nullable
as List<AppFile>,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as User,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res> get author {
  
  return $UserCopyWith<$Res>(_self.author, (value) {
    return _then(_self.copyWith(author: value));
  });
}
}


/// Adds pattern-matching-related methods to [Post].
extension PostPatterns on Post {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Post value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Post() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Post value)  $default,){
final _that = this;
switch (_that) {
case _Post():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Post value)?  $default,){
final _that = this;
switch (_that) {
case _Post() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  FeedType feedType,  String? title,  String? body,  List<AppFile> photos,  User author,  DateTime created,  DateTime updated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Post() when $default != null:
return $default(_that.id,_that.feedType,_that.title,_that.body,_that.photos,_that.author,_that.created,_that.updated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  FeedType feedType,  String? title,  String? body,  List<AppFile> photos,  User author,  DateTime created,  DateTime updated)  $default,) {final _that = this;
switch (_that) {
case _Post():
return $default(_that.id,_that.feedType,_that.title,_that.body,_that.photos,_that.author,_that.created,_that.updated);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  FeedType feedType,  String? title,  String? body,  List<AppFile> photos,  User author,  DateTime created,  DateTime updated)?  $default,) {final _that = this;
switch (_that) {
case _Post() when $default != null:
return $default(_that.id,_that.feedType,_that.title,_that.body,_that.photos,_that.author,_that.created,_that.updated);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Post implements Post {
  const _Post({this.id, required this.feedType, this.title, this.body, final  List<AppFile> photos = const [], required this.author, required this.created, required this.updated}): _photos = photos;
  factory _Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

@override final  String? id;
@override final  FeedType feedType;
@override final  String? title;
@override final  String? body;
 final  List<AppFile> _photos;
@override@JsonKey() List<AppFile> get photos {
  if (_photos is EqualUnmodifiableListView) return _photos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_photos);
}

@override final  User author;
@override final  DateTime created;
@override final  DateTime updated;

/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostCopyWith<_Post> get copyWith => __$PostCopyWithImpl<_Post>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Post&&(identical(other.id, id) || other.id == id)&&(identical(other.feedType, feedType) || other.feedType == feedType)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&const DeepCollectionEquality().equals(other._photos, _photos)&&(identical(other.author, author) || other.author == author)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,feedType,title,body,const DeepCollectionEquality().hash(_photos),author,created,updated);

@override
String toString() {
  return 'Post(id: $id, feedType: $feedType, title: $title, body: $body, photos: $photos, author: $author, created: $created, updated: $updated)';
}


}

/// @nodoc
abstract mixin class _$PostCopyWith<$Res> implements $PostCopyWith<$Res> {
  factory _$PostCopyWith(_Post value, $Res Function(_Post) _then) = __$PostCopyWithImpl;
@override @useResult
$Res call({
 String? id, FeedType feedType, String? title, String? body, List<AppFile> photos, User author, DateTime created, DateTime updated
});


@override $UserCopyWith<$Res> get author;

}
/// @nodoc
class __$PostCopyWithImpl<$Res>
    implements _$PostCopyWith<$Res> {
  __$PostCopyWithImpl(this._self, this._then);

  final _Post _self;
  final $Res Function(_Post) _then;

/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? feedType = null,Object? title = freezed,Object? body = freezed,Object? photos = null,Object? author = null,Object? created = null,Object? updated = null,}) {
  return _then(_Post(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,feedType: null == feedType ? _self.feedType : feedType // ignore: cast_nullable_to_non_nullable
as FeedType,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,photos: null == photos ? _self._photos : photos // ignore: cast_nullable_to_non_nullable
as List<AppFile>,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as User,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res> get author {
  
  return $UserCopyWith<$Res>(_self.author, (value) {
    return _then(_self.copyWith(author: value));
  });
}
}


/// @nodoc
mixin _$Reel {

 String? get id; FeedType get feedType; String? get title; String? get subTitle; AppFile get videoUrl; User get author; DateTime get created; DateTime get updated;
/// Create a copy of Reel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReelCopyWith<Reel> get copyWith => _$ReelCopyWithImpl<Reel>(this as Reel, _$identity);

  /// Serializes this Reel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Reel&&(identical(other.id, id) || other.id == id)&&(identical(other.feedType, feedType) || other.feedType == feedType)&&(identical(other.title, title) || other.title == title)&&(identical(other.subTitle, subTitle) || other.subTitle == subTitle)&&(identical(other.videoUrl, videoUrl) || other.videoUrl == videoUrl)&&(identical(other.author, author) || other.author == author)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,feedType,title,subTitle,videoUrl,author,created,updated);

@override
String toString() {
  return 'Reel(id: $id, feedType: $feedType, title: $title, subTitle: $subTitle, videoUrl: $videoUrl, author: $author, created: $created, updated: $updated)';
}


}

/// @nodoc
abstract mixin class $ReelCopyWith<$Res>  {
  factory $ReelCopyWith(Reel value, $Res Function(Reel) _then) = _$ReelCopyWithImpl;
@useResult
$Res call({
 String? id, FeedType feedType, String? title, String? subTitle, AppFile videoUrl, User author, DateTime created, DateTime updated
});


$AppFileCopyWith<$Res> get videoUrl;$UserCopyWith<$Res> get author;

}
/// @nodoc
class _$ReelCopyWithImpl<$Res>
    implements $ReelCopyWith<$Res> {
  _$ReelCopyWithImpl(this._self, this._then);

  final Reel _self;
  final $Res Function(Reel) _then;

/// Create a copy of Reel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? feedType = null,Object? title = freezed,Object? subTitle = freezed,Object? videoUrl = null,Object? author = null,Object? created = null,Object? updated = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,feedType: null == feedType ? _self.feedType : feedType // ignore: cast_nullable_to_non_nullable
as FeedType,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,subTitle: freezed == subTitle ? _self.subTitle : subTitle // ignore: cast_nullable_to_non_nullable
as String?,videoUrl: null == videoUrl ? _self.videoUrl : videoUrl // ignore: cast_nullable_to_non_nullable
as AppFile,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as User,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of Reel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppFileCopyWith<$Res> get videoUrl {
  
  return $AppFileCopyWith<$Res>(_self.videoUrl, (value) {
    return _then(_self.copyWith(videoUrl: value));
  });
}/// Create a copy of Reel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res> get author {
  
  return $UserCopyWith<$Res>(_self.author, (value) {
    return _then(_self.copyWith(author: value));
  });
}
}


/// Adds pattern-matching-related methods to [Reel].
extension ReelPatterns on Reel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Reel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Reel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Reel value)  $default,){
final _that = this;
switch (_that) {
case _Reel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Reel value)?  $default,){
final _that = this;
switch (_that) {
case _Reel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  FeedType feedType,  String? title,  String? subTitle,  AppFile videoUrl,  User author,  DateTime created,  DateTime updated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Reel() when $default != null:
return $default(_that.id,_that.feedType,_that.title,_that.subTitle,_that.videoUrl,_that.author,_that.created,_that.updated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  FeedType feedType,  String? title,  String? subTitle,  AppFile videoUrl,  User author,  DateTime created,  DateTime updated)  $default,) {final _that = this;
switch (_that) {
case _Reel():
return $default(_that.id,_that.feedType,_that.title,_that.subTitle,_that.videoUrl,_that.author,_that.created,_that.updated);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  FeedType feedType,  String? title,  String? subTitle,  AppFile videoUrl,  User author,  DateTime created,  DateTime updated)?  $default,) {final _that = this;
switch (_that) {
case _Reel() when $default != null:
return $default(_that.id,_that.feedType,_that.title,_that.subTitle,_that.videoUrl,_that.author,_that.created,_that.updated);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Reel implements Reel {
  const _Reel({this.id, required this.feedType, this.title, this.subTitle, required this.videoUrl, required this.author, required this.created, required this.updated});
  factory _Reel.fromJson(Map<String, dynamic> json) => _$ReelFromJson(json);

@override final  String? id;
@override final  FeedType feedType;
@override final  String? title;
@override final  String? subTitle;
@override final  AppFile videoUrl;
@override final  User author;
@override final  DateTime created;
@override final  DateTime updated;

/// Create a copy of Reel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReelCopyWith<_Reel> get copyWith => __$ReelCopyWithImpl<_Reel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Reel&&(identical(other.id, id) || other.id == id)&&(identical(other.feedType, feedType) || other.feedType == feedType)&&(identical(other.title, title) || other.title == title)&&(identical(other.subTitle, subTitle) || other.subTitle == subTitle)&&(identical(other.videoUrl, videoUrl) || other.videoUrl == videoUrl)&&(identical(other.author, author) || other.author == author)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,feedType,title,subTitle,videoUrl,author,created,updated);

@override
String toString() {
  return 'Reel(id: $id, feedType: $feedType, title: $title, subTitle: $subTitle, videoUrl: $videoUrl, author: $author, created: $created, updated: $updated)';
}


}

/// @nodoc
abstract mixin class _$ReelCopyWith<$Res> implements $ReelCopyWith<$Res> {
  factory _$ReelCopyWith(_Reel value, $Res Function(_Reel) _then) = __$ReelCopyWithImpl;
@override @useResult
$Res call({
 String? id, FeedType feedType, String? title, String? subTitle, AppFile videoUrl, User author, DateTime created, DateTime updated
});


@override $AppFileCopyWith<$Res> get videoUrl;@override $UserCopyWith<$Res> get author;

}
/// @nodoc
class __$ReelCopyWithImpl<$Res>
    implements _$ReelCopyWith<$Res> {
  __$ReelCopyWithImpl(this._self, this._then);

  final _Reel _self;
  final $Res Function(_Reel) _then;

/// Create a copy of Reel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? feedType = null,Object? title = freezed,Object? subTitle = freezed,Object? videoUrl = null,Object? author = null,Object? created = null,Object? updated = null,}) {
  return _then(_Reel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,feedType: null == feedType ? _self.feedType : feedType // ignore: cast_nullable_to_non_nullable
as FeedType,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,subTitle: freezed == subTitle ? _self.subTitle : subTitle // ignore: cast_nullable_to_non_nullable
as String?,videoUrl: null == videoUrl ? _self.videoUrl : videoUrl // ignore: cast_nullable_to_non_nullable
as AppFile,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as User,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of Reel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppFileCopyWith<$Res> get videoUrl {
  
  return $AppFileCopyWith<$Res>(_self.videoUrl, (value) {
    return _then(_self.copyWith(videoUrl: value));
  });
}/// Create a copy of Reel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res> get author {
  
  return $UserCopyWith<$Res>(_self.author, (value) {
    return _then(_self.copyWith(author: value));
  });
}
}

// dart format on
