import 'package:botsito/models/remote_config/remote_config.dart';
import 'package:botsito/util/constants.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'remote_config_provider.g.dart';

@riverpod
Future<RemoteConfig> remoteConfig(Ref ref) async {
  final res = await Dio().get(remoteConfigUrl);

  return RemoteConfig.fromJson(res.data);
}
