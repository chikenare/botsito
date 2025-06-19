import 'package:botsito/models/content.dart';
import 'package:botsito/models/link.dart';
import 'package:botsito/models/remote_config/host_remote_config.dart';
import 'package:botsito/models/season.dart';
import 'package:botsito/plugins/sources/allcalidad.dart';
import 'package:botsito/plugins/sources/cinecalidad.dart';
import 'package:botsito/providers/remote_config_provider.dart';
import 'package:botsito/providers/setting_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'source_provider.g.dart';

final Map<String, Function> _constructors = {
  'Cinecalidad': () => Cinecalidad(),
  'Allcalidad': () => Allcalidad(),
};

@riverpod
Future<dynamic> getSourceInstance(Ref ref) async {
  final source = (await ref.read(settingPProvider.future))?.source;

  if (source == null) {
    throw Exception('Error en config we');
  }

  final constructor = _constructors[source];
  if (constructor != null) {
    return constructor();
  } else {
    throw Exception('Clase no registrada: $source');
  }
}

@riverpod
class Search extends _$Search {
  @override
  Future<List<Content>> build() => Future.value([]);

  Future<void> search(String query) async {
    final instance = await ref.read(getSourceInstanceProvider.future);
    final res = await instance.search(query);
    state = AsyncValue.data(res);
  }
}

@riverpod
Future<List<Link>> link(Ref ref, String id) async {
  final instance = await ref.read(getSourceInstanceProvider.future);

  final List<Link> links = await instance.getLinks(id);

  final hosts = (await ref.read(remoteConfigProvider.future)).hosts;

  return links.map((link) {
    final newDomain = _getDomainToReplace(link, hosts);

    final include = hosts.any(
      (host) => [...host.toReplace, host.domain].contains(link.hostname),
    );

    return link.copyWith(
      url: newDomain == null
          ? null
          : link.url.replaceFirst(link.hostname, newDomain.domain),
      include: include,
    );
  }).toList();
}

HostRemoteConfig? _getDomainToReplace(
  Link link,
  List<HostRemoteConfig> domains,
) {
  for (final d in domains) {
    if (d.toReplace.contains(link.hostname)) {
      return d;
    }
  }
  return null;
}

@riverpod
Future<List<Season>> season(Ref ref, String id) async {
  final instance = await ref.read(getSourceInstanceProvider.future);

  return await instance.seasons(id);
}
