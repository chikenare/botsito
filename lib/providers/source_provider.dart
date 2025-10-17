import 'package:botsito/models/content.dart';
import 'package:botsito/models/link.dart';
import 'package:botsito/models/season.dart';
import 'package:botsito/plugins/sources/allcalidad.dart';
import 'package:botsito/plugins/sources/cinecalidad.dart';
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

  return await instance.getLinks(id);
}

@riverpod
Future<List<Season>> season(Ref ref, String id) async {
  final instance = await ref.read(getSourceInstanceProvider.future);

  return await instance.seasons(id);
}
