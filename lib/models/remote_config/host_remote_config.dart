import 'package:freezed_annotation/freezed_annotation.dart';

part 'host_remote_config.freezed.dart';
part 'host_remote_config.g.dart';

@freezed
abstract class HostRemoteConfig with _$HostRemoteConfig {
  const factory HostRemoteConfig({
    required String name,
    required String domain,
    required List<String> toReplace,
  }) = _HostRemoteConfig;

  factory HostRemoteConfig.fromJson(Map<String, Object?> json) =>
      _$HostRemoteConfigFromJson(json);
}
