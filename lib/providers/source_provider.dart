import 'package:botsito/models/content.dart';
import 'package:botsito/models/link.dart';
import 'package:botsito/models/remote_config/host_remote_config.dart';
import 'package:botsito/models/season.dart';
import 'package:botsito/plugins/sources/allcalidad.dart';
import 'package:botsito/providers/remote_config_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'source_provider.g.dart';

@riverpod
class Search extends _$Search {
  @override
  Future<List<Content>> build() => Future.value([]);

  Future<void> search(String query) async {
    final res = await Allcalidad().search(query);
    state = AsyncValue.data(res);
  }
}

@riverpod
Future<List<Link>> link(Ref ref, String id) async {
  final links = await Allcalidad().getLinks(id);

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
  return await Allcalidad().seasons(id);
}
