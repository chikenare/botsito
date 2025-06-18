// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'host_remote_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HostRemoteConfig {

 String get name; String get domain; List<String> get toReplace;
/// Create a copy of HostRemoteConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HostRemoteConfigCopyWith<HostRemoteConfig> get copyWith => _$HostRemoteConfigCopyWithImpl<HostRemoteConfig>(this as HostRemoteConfig, _$identity);

  /// Serializes this HostRemoteConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HostRemoteConfig&&(identical(other.name, name) || other.name == name)&&(identical(other.domain, domain) || other.domain == domain)&&const DeepCollectionEquality().equals(other.toReplace, toReplace));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,domain,const DeepCollectionEquality().hash(toReplace));

@override
String toString() {
  return 'HostRemoteConfig(name: $name, domain: $domain, toReplace: $toReplace)';
}


}

/// @nodoc
abstract mixin class $HostRemoteConfigCopyWith<$Res>  {
  factory $HostRemoteConfigCopyWith(HostRemoteConfig value, $Res Function(HostRemoteConfig) _then) = _$HostRemoteConfigCopyWithImpl;
@useResult
$Res call({
 String name, String domain, List<String> toReplace
});




}
/// @nodoc
class _$HostRemoteConfigCopyWithImpl<$Res>
    implements $HostRemoteConfigCopyWith<$Res> {
  _$HostRemoteConfigCopyWithImpl(this._self, this._then);

  final HostRemoteConfig _self;
  final $Res Function(HostRemoteConfig) _then;

/// Create a copy of HostRemoteConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? domain = null,Object? toReplace = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,domain: null == domain ? _self.domain : domain // ignore: cast_nullable_to_non_nullable
as String,toReplace: null == toReplace ? _self.toReplace : toReplace // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _HostRemoteConfig implements HostRemoteConfig {
  const _HostRemoteConfig({required this.name, required this.domain, required final  List<String> toReplace}): _toReplace = toReplace;
  factory _HostRemoteConfig.fromJson(Map<String, dynamic> json) => _$HostRemoteConfigFromJson(json);

@override final  String name;
@override final  String domain;
 final  List<String> _toReplace;
@override List<String> get toReplace {
  if (_toReplace is EqualUnmodifiableListView) return _toReplace;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_toReplace);
}


/// Create a copy of HostRemoteConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HostRemoteConfigCopyWith<_HostRemoteConfig> get copyWith => __$HostRemoteConfigCopyWithImpl<_HostRemoteConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HostRemoteConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HostRemoteConfig&&(identical(other.name, name) || other.name == name)&&(identical(other.domain, domain) || other.domain == domain)&&const DeepCollectionEquality().equals(other._toReplace, _toReplace));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,domain,const DeepCollectionEquality().hash(_toReplace));

@override
String toString() {
  return 'HostRemoteConfig(name: $name, domain: $domain, toReplace: $toReplace)';
}


}

/// @nodoc
abstract mixin class _$HostRemoteConfigCopyWith<$Res> implements $HostRemoteConfigCopyWith<$Res> {
  factory _$HostRemoteConfigCopyWith(_HostRemoteConfig value, $Res Function(_HostRemoteConfig) _then) = __$HostRemoteConfigCopyWithImpl;
@override @useResult
$Res call({
 String name, String domain, List<String> toReplace
});




}
/// @nodoc
class __$HostRemoteConfigCopyWithImpl<$Res>
    implements _$HostRemoteConfigCopyWith<$Res> {
  __$HostRemoteConfigCopyWithImpl(this._self, this._then);

  final _HostRemoteConfig _self;
  final $Res Function(_HostRemoteConfig) _then;

/// Create a copy of HostRemoteConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? domain = null,Object? toReplace = null,}) {
  return _then(_HostRemoteConfig(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,domain: null == domain ? _self.domain : domain // ignore: cast_nullable_to_non_nullable
as String,toReplace: null == toReplace ? _self._toReplace : toReplace // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
