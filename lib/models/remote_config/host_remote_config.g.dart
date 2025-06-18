// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'host_remote_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HostRemoteConfig _$HostRemoteConfigFromJson(Map<String, dynamic> json) =>
    _HostRemoteConfig(
      name: json['name'] as String,
      domain: json['domain'] as String,
      toReplace: (json['toReplace'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$HostRemoteConfigToJson(_HostRemoteConfig instance) =>
    <String, dynamic>{
      'name': instance.name,
      'domain': instance.domain,
      'toReplace': instance.toReplace,
    };
