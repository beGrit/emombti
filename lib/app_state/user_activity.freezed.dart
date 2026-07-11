// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_activity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserActivityState implements DiagnosticableTreeMixin {

 List<Activity> get items;
/// Create a copy of UserActivityState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserActivityStateCopyWith<UserActivityState> get copyWith => _$UserActivityStateCopyWithImpl<UserActivityState>(this as UserActivityState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'UserActivityState'))
    ..add(DiagnosticsProperty('items', items));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserActivityState&&const DeepCollectionEquality().equals(other.items, items));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'UserActivityState(items: $items)';
}


}

/// @nodoc
abstract mixin class $UserActivityStateCopyWith<$Res>  {
  factory $UserActivityStateCopyWith(UserActivityState value, $Res Function(UserActivityState) _then) = _$UserActivityStateCopyWithImpl;
@useResult
$Res call({
 List<Activity> items
});




}
/// @nodoc
class _$UserActivityStateCopyWithImpl<$Res>
    implements $UserActivityStateCopyWith<$Res> {
  _$UserActivityStateCopyWithImpl(this._self, this._then);

  final UserActivityState _self;
  final $Res Function(UserActivityState) _then;

/// Create a copy of UserActivityState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<Activity>,
  ));
}

}


/// Adds pattern-matching-related methods to [UserActivityState].
extension UserActivityStatePatterns on UserActivityState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserActivityState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserActivityState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserActivityState value)  $default,){
final _that = this;
switch (_that) {
case _UserActivityState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserActivityState value)?  $default,){
final _that = this;
switch (_that) {
case _UserActivityState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Activity> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserActivityState() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Activity> items)  $default,) {final _that = this;
switch (_that) {
case _UserActivityState():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Activity> items)?  $default,) {final _that = this;
switch (_that) {
case _UserActivityState() when $default != null:
return $default(_that.items);case _:
  return null;

}
}

}

/// @nodoc


class _UserActivityState extends UserActivityState with DiagnosticableTreeMixin {
  const _UserActivityState({final  List<Activity> items = const []}): _items = items,super._();
  

 final  List<Activity> _items;
@override@JsonKey() List<Activity> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of UserActivityState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserActivityStateCopyWith<_UserActivityState> get copyWith => __$UserActivityStateCopyWithImpl<_UserActivityState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'UserActivityState'))
    ..add(DiagnosticsProperty('items', items));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserActivityState&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'UserActivityState(items: $items)';
}


}

/// @nodoc
abstract mixin class _$UserActivityStateCopyWith<$Res> implements $UserActivityStateCopyWith<$Res> {
  factory _$UserActivityStateCopyWith(_UserActivityState value, $Res Function(_UserActivityState) _then) = __$UserActivityStateCopyWithImpl;
@override @useResult
$Res call({
 List<Activity> items
});




}
/// @nodoc
class __$UserActivityStateCopyWithImpl<$Res>
    implements _$UserActivityStateCopyWith<$Res> {
  __$UserActivityStateCopyWithImpl(this._self, this._then);

  final _UserActivityState _self;
  final $Res Function(_UserActivityState) _then;

/// Create a copy of UserActivityState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,}) {
  return _then(_UserActivityState(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<Activity>,
  ));
}


}

// dart format on
