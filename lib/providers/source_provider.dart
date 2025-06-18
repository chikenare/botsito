import 'package:botsito/models/content.dart';
import 'package:botsito/models/link.dart';
import 'package:botsito/models/season.dart';
import 'package:botsito/models/setting/domain.dart';
import 'package:botsito/plugins/sources/allcalidad.dart';
import 'package:botsito/providers/setting_provider.dart';
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

  final domains = (await ref.read(settingPProvider.future))?.domains ?? [];

  final ignoredDomains = domains
      .where((e) => e.ignore)
      .map((e) => e.hostname)
      .toList();

  links.removeWhere((e) => ignoredDomains.contains(e.hostname));

  return links.map((link) {
    final newDomain = _getDomainToReplace(link, domains);

    return link.copyWith(
      url: newDomain == null
          ? null
          : link.url.replaceFirst(link.hostname, newDomain.hostname),
    );
  }).toList();
}

Domain? _getDomainToReplace(Link link, List<Domain> domains) {
  for (final d in domains) {
    if (d.childDomains.contains(link.hostname)) {
      return d;
    }
  }
  return null;
}

@riverpod
Future<List<Season>> season(Ref ref, String id) async {
  return await Allcalidad().seasons(id);
}
