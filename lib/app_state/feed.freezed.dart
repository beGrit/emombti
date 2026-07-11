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
mixin _$FeedPostState implements DiagnosticableTreeMixin {

 List<Post> get items;
/// Create a copy of FeedPostState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedPostStateCopyWith<FeedPostState> get copyWith => _$FeedPostStateCopyWithImpl<FeedPostState>(this as FeedPostState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'FeedPostState'))
    ..add(DiagnosticsProperty('items', items));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedPostState&&const DeepCollectionEquality().equals(other.items, items));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'FeedPostState(items: $items)';
}


}

/// @nodoc
abstract mixin class $FeedPostStateCopyWith<$Res>  {
  factory $FeedPostStateCopyWith(FeedPostState value, $Res Function(FeedPostState) _then) = _$FeedPostStateCopyWithImpl;
@useResult
$Res call({
 List<Post> items
});




}
/// @nodoc
class _$FeedPostStateCopyWithImpl<$Res>
    implements $FeedPostStateCopyWith<$Res> {
  _$FeedPostStateCopyWithImpl(this._self, this._then);

  final FeedPostState _self;
  final $Res Function(FeedPostState) _then;

/// Create a copy of FeedPostState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<Post>,
  ));
}

}


/// Adds pattern-matching-related methods to [FeedPostState].
extension FeedPostStatePatterns on FeedPostState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedPostState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedPostState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedPostState value)  $default,){
final _that = this;
switch (_that) {
case _FeedPostState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedPostState value)?  $default,){
final _that = this;
switch (_that) {
case _FeedPostState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Post> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedPostState() when $default != null:
return $default(_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Post> items)  $default,) {final _that = this;
switch (_that) {
case _FeedPostState():
return $default(_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Post> items)?  $default,) {final _that = this;
switch (_that) {
case _FeedPostState() when $default != null:
return $default(_that.items);case _:
  return null;

}
}

}

/// @nodoc


class _FeedPostState extends FeedPostState with DiagnosticableTreeMixin {
  const _FeedPostState({final  List<Post> items = const []}): _items = items,super._();
  

 final  List<Post> _items;
@override@JsonKey() List<Post> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of FeedPostState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedPostStateCopyWith<_FeedPostState> get copyWith => __$FeedPostStateCopyWithImpl<_FeedPostState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'FeedPostState'))
    ..add(DiagnosticsProperty('items', items));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedPostState&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'FeedPostState(items: $items)';
}


}

/// @nodoc
abstract mixin class _$FeedPostStateCopyWith<$Res> implements $FeedPostStateCopyWith<$Res> {
  factory _$FeedPostStateCopyWith(_FeedPostState value, $Res Function(_FeedPostState) _then) = __$FeedPostStateCopyWithImpl;
@override @useResult
$Res call({
 List<Post> items
});




}
/// @nodoc
class __$FeedPostStateCopyWithImpl<$Res>
    implements _$FeedPostStateCopyWith<$Res> {
  __$FeedPostStateCopyWithImpl(this._self, this._then);

  final _FeedPostState _self;
  final $Res Function(_FeedPostState) _then;

/// Create a copy of FeedPostState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,}) {
  return _then(_FeedPostState(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<Post>,
  ));
}


}

/// @nodoc
mixin _$FeedReelState implements DiagnosticableTreeMixin {

 List<Reel> get items;
/// Create a copy of FeedReelState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedReelStateCopyWith<FeedReelState> get copyWith => _$FeedReelStateCopyWithImpl<FeedReelState>(this as FeedReelState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'FeedReelState'))
    ..add(DiagnosticsProperty('items', items));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedReelState&&const DeepCollectionEquality().equals(other.items, items));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'FeedReelState(items: $items)';
}


}

/// @nodoc
abstract mixin class $FeedReelStateCopyWith<$Res>  {
  factory $FeedReelStateCopyWith(FeedReelState value, $Res Function(FeedReelState) _then) = _$FeedReelStateCopyWithImpl;
@useResult
$Res call({
 List<Reel> items
});




}
/// @nodoc
class _$FeedReelStateCopyWithImpl<$Res>
    implements $FeedReelStateCopyWith<$Res> {
  _$FeedReelStateCopyWithImpl(this._self, this._then);

  final FeedReelState _self;
  final $Res Function(FeedReelState) _then;

/// Create a copy of FeedReelState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<Reel>,
  ));
}

}


/// Adds pattern-matching-related methods to [FeedReelState].
extension FeedReelStatePatterns on FeedReelState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedReelState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedReelState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedReelState value)  $default,){
final _that = this;
switch (_that) {
case _FeedReelState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedReelState value)?  $default,){
final _that = this;
switch (_that) {
case _FeedReelState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Reel> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedReelState() when $default != null:
return $default(_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Reel> items)  $default,) {final _that = this;
switch (_that) {
case _FeedReelState():
return $default(_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Reel> items)?  $default,) {final _that = this;
switch (_that) {
case _FeedReelState() when $default != null:
return $default(_that.items);case _:
  return null;

}
}

}

/// @nodoc


class _FeedReelState extends FeedReelState with DiagnosticableTreeMixin {
  const _FeedReelState({final  List<Reel> items = const []}): _items = items,super._();
  

 final  List<Reel> _items;
@override@JsonKey() List<Reel> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of FeedReelState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedReelStateCopyWith<_FeedReelState> get copyWith => __$FeedReelStateCopyWithImpl<_FeedReelState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'FeedReelState'))
    ..add(DiagnosticsProperty('items', items));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedReelState&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'FeedReelState(items: $items)';
}


}

/// @nodoc
abstract mixin class _$FeedReelStateCopyWith<$Res> implements $FeedReelStateCopyWith<$Res> {
  factory _$FeedReelStateCopyWith(_FeedReelState value, $Res Function(_FeedReelState) _then) = __$FeedReelStateCopyWithImpl;
@override @useResult
$Res call({
 List<Reel> items
});




}
/// @nodoc
class __$FeedReelStateCopyWithImpl<$Res>
    implements _$FeedReelStateCopyWith<$Res> {
  __$FeedReelStateCopyWithImpl(this._self, this._then);

  final _FeedReelState _self;
  final $Res Function(_FeedReelState) _then;

/// Create a copy of FeedReelState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,}) {
  return _then(_FeedReelState(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<Reel>,
  ));
}


}

// dart format on
