import 'package:botsito/models/content.dart';
import 'package:botsito/models/episode.dart';
import 'package:botsito/models/link.dart';
import 'package:botsito/models/season.dart';
import 'package:botsito/plugins/sources/source_base.dart';
import 'package:botsito/util/get_ua.dart';
import 'package:dio/dio.dart';
import 'package:html/parser.dart';

class Cinecalidad implements SourceBase {
  static final urlBase = 'https://www.cinecalidad.ec/';
  static final Map<String, String> headers = {
    'referer': urlBase,
    'user-agent': getUA(),
  };
  static Dio get _dio => Dio(BaseOptions(baseUrl: urlBase, headers: headers));

  @override
  Future<List<Content>> search(String query) async {
    final res = await _dio.get('/', queryParameters: {'s': query});

    final doc = parse(res.data);
    final items = doc
        .querySelectorAll('.custom')
        .where(
          (tmp) => tmp.querySelector('img')?.attributes['data-src'] != null,
        )
        .map((e) {
          final image = e.querySelector('img')!.attributes['data-src']!;

          final url = e.querySelector('a')!.attributes['href']!;
          final title = e.querySelector('.in_title')?.text ?? 'No title';
          return Content(
            id: url,
            slug: 'slug',
            title: title,
            image: image,
            isSerie: e.querySelector('.selt')?.text != 'Película',
          );
        })
        .toList();

    return items;
  }

  @override
  Future<List<Season>> seasons(String id) async {
    final res = await _dio.get(id);
    final doc = parse(res.data);

    final episodes = doc.querySelectorAll('li.mark-1').map((e) {
      final numerando = e.querySelector('.numerando')!.text;
      final match = (RegExp(r'S(\d+)-E(\d+)')).firstMatch(numerando);
      final seasonNumber = int.parse(match!.group(1)!);
      final episodeNumber = int.parse(match.group(2)!);

      return Episode(
        id: Uri.decodeComponent(e.querySelector('a')!.attributes['href']!),
        seasonNumber: seasonNumber,
        episodeNumber: episodeNumber,
      );
    });

    final List<Season> seasons = [];

    for (final episode in episodes) {
      final season = seasons.firstWhere(
        (s) => s.seasonNumber == episode.seasonNumber,
        orElse: () {
          final newSeason = Season(
            seasonNumber: episode.seasonNumber,
            episodes: [],
          );
          seasons.add(newSeason);
          return newSeason;
        },
      );
      season.episodes.add(episode);
    }

    return seasons;
  }

  @override
  Future<List<Link>> getLinks(String id) async {
    final res = await _dio.get(id);
    final doc = parse(res.data);

    final items = doc.querySelectorAll('.dooplay_player_option').map((e) {
      return Link(url: e.attributes['data-option']!);
    });

    return items.toList();
  }
}
