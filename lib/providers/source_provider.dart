import 'package:botsito/models/content.dart';
import 'package:botsito/models/link.dart';
import 'package:botsito/models/season.dart';
import 'package:botsito/plugins/sources/allcalidad.dart';
import 'package:botsito/plugins/sources/cinecalidad.dart';
import 'package:botsito/plugins/sources/lamovie.dart';
import 'package:botsito/plugins/sources/pelisforte.dart';
import 'package:botsito/util/constants.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'source_provider.g.dart';

final Map<String, Function> _constructors = {
  'La.movie': () => Lamovie(),
  'Cinecalidad': () => Cinecalidad(),
  'Allcalidad': () => Allcalidad(),
  'Pelisforte': () => Pelisforte(),
};

@riverpod
class SourceP extends _$SourceP {
  @override
  String build() => defaultProvider;

  void setProvider(String name) {
    state = name;
  }
}

@riverpod
dynamic getSourceInstance(Ref ref) {
  final provider = ref.read(sourcePProvider);
  final constructor = _constructors[provider];
  if (constructor != null) {
    return constructor();
  } else {
    throw Exception('Clase no registrada: $provider');
  }
}

@riverpod
class Search extends _$Search {
  @override
  Future<List<Content>> build() => Future.value([]);

  Future<void> search(String query) async {
    final instance = ref.read(getSourceInstanceProvider);
    final res = await instance.search(query);
    state = AsyncValue.data(res);
  }
}

@riverpod
Future<List<Link>> link(
  Ref ref,
  String id, {
  int? seasonNumber,
  int? episodeNumber,
}) async {
  final instance = await ref.read(getSourceInstanceProvider);

  final List<Link> links = await instance.getLinks(id);

  return links
      .map(
        (l) => l.copyWith(
          seasonNumber: seasonNumber,
          episodeNumber: episodeNumber,
        ),
      )
      .toList();
}

@riverpod
Future<List<Season>> season(Ref ref, String id) async {
  final instance = await ref.read(getSourceInstanceProvider);

  return await instance.seasons(id);
}
