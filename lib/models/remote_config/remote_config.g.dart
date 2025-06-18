// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RemoteConfig _$RemoteConfigFromJson(Map<String, dynamic> json) =>
    _RemoteConfig(
      hosts: (json['hosts'] as List<dynamic>)
          .map((e) => HostRemoteConfig.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RemoteConfigToJson(_RemoteConfig instance) =>
    <String, dynamic>{'hosts': instance.hosts};
