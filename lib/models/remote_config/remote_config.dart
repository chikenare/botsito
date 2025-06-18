import 'package:botsito/models/remote_config/host_remote_config.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'remote_config.freezed.dart';
part 'remote_config.g.dart';

@freezed
abstract class RemoteConfig with _$RemoteConfig {
  const factory RemoteConfig({required List<HostRemoteConfig> hosts}) =
      _RemoteConfig;

  factory RemoteConfig.fromJson(Map<String, Object?> json) =>
      _$RemoteConfigFromJson(json);
}
