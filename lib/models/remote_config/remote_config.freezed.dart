// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'remote_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RemoteConfig {

 List<HostRemoteConfig> get hosts;
/// Create a copy of RemoteConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RemoteConfigCopyWith<RemoteConfig> get copyWith => _$RemoteConfigCopyWithImpl<RemoteConfig>(this as RemoteConfig, _$identity);

  /// Serializes this RemoteConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RemoteConfig&&const DeepCollectionEquality().equals(other.hosts, hosts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(hosts));

@override
String toString() {
  return 'RemoteConfig(hosts: $hosts)';
}


}

/// @nodoc
abstract mixin class $RemoteConfigCopyWith<$Res>  {
  factory $RemoteConfigCopyWith(RemoteConfig value, $Res Function(RemoteConfig) _then) = _$RemoteConfigCopyWithImpl;
@useResult
$Res call({
 List<HostRemoteConfig> hosts
});




}
/// @nodoc
class _$RemoteConfigCopyWithImpl<$Res>
    implements $RemoteConfigCopyWith<$Res> {
  _$RemoteConfigCopyWithImpl(this._self, this._then);

  final RemoteConfig _self;
  final $Res Function(RemoteConfig) _then;

/// Create a copy of RemoteConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hosts = null,}) {
  return _then(_self.copyWith(
hosts: null == hosts ? _self.hosts : hosts // ignore: cast_nullable_to_non_nullable
as List<HostRemoteConfig>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _RemoteConfig implements RemoteConfig {
  const _RemoteConfig({required final  List<HostRemoteConfig> hosts}): _hosts = hosts;
  factory _RemoteConfig.fromJson(Map<String, dynamic> json) => _$RemoteConfigFromJson(json);

 final  List<HostRemoteConfig> _hosts;
@override List<HostRemoteConfig> get hosts {
  if (_hosts is EqualUnmodifiableListView) return _hosts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_hosts);
}


/// Create a copy of RemoteConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RemoteConfigCopyWith<_RemoteConfig> get copyWith => __$RemoteConfigCopyWithImpl<_RemoteConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RemoteConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RemoteConfig&&const DeepCollectionEquality().equals(other._hosts, _hosts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_hosts));

@override
String toString() {
  return 'RemoteConfig(hosts: $hosts)';
}


}

/// @nodoc
abstract mixin class _$RemoteConfigCopyWith<$Res> implements $RemoteConfigCopyWith<$Res> {
  factory _$RemoteConfigCopyWith(_RemoteConfig value, $Res Function(_RemoteConfig) _then) = __$RemoteConfigCopyWithImpl;
@override @useResult
$Res call({
 List<HostRemoteConfig> hosts
});




}
/// @nodoc
class __$RemoteConfigCopyWithImpl<$Res>
    implements _$RemoteConfigCopyWith<$Res> {
  __$RemoteConfigCopyWithImpl(this._self, this._then);

  final _RemoteConfig _self;
  final $Res Function(_RemoteConfig) _then;

/// Create a copy of RemoteConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hosts = null,}) {
  return _then(_RemoteConfig(
hosts: null == hosts ? _self._hosts : hosts // ignore: cast_nullable_to_non_nullable
as List<HostRemoteConfig>,
  ));
}


}

// dart format on
