import 'package:botsito/models/content.dart';
import 'package:botsito/models/episode.dart';
import 'package:botsito/models/link.dart';
import 'package:botsito/models/season.dart';
import 'package:botsito/plugins/sources/provider_base.dart';
import 'package:dio/dio.dart';
import 'package:html/parser.dart';

class Pocketapp implements ProviderBase {
  static final apiKey = '6jJaqKcyGgHRc3nsu0NAB5UFjDIum6HEMyeSFhU0MIaZSNfmEg';
  static final _urlBase = 'https://pocket.pocketplaypro.com';
  static Dio get _dio => Dio(
    BaseOptions(
      baseUrl: '$_urlBase/api',
      headers: {'user-agent': 'okhttp/5.1.0', 'x-api-key': apiKey},
    ),
  );
  @override
  Future<List<Link>> getLinks(String id) async {
    final res = await Dio().get(
      id,
      options: Options(headers: {'user-agent': 'okhttp/5.1.0'}),
    );
    final html = parse(res.data);
    final List<Link> links = [];
    for (final item in html.querySelectorAll('div.language-container')) {
      final language = item.attributes['id'];
      final linksRaw = item.querySelectorAll('li').map((e) {
        final regex = RegExp(r"setiframe\('([^']+)'\)");
        final match = regex.firstMatch(e.attributes['onclick']!);
        return match!.group(1);
      });

      for (final l in linksRaw) {
        links.add(Link(url: l!, language: language!, isDownload: false));
      }
    }

    return links;
  }

  @override
  Future<List<Content>> search(String query) async {
    final res = await _dio.post('/search/1', data: {'query': query});

    final List<Content> contents = [];

    for (final e in res.data['data']) {
      final image =
          'https://media.themoviedb.org/t/p/w220_and_h330_face${e['tmdb_path_poster']}';
      final isSerie = e['media_type'] == '2';
      final type = isSerie ? 'serie' : 'movie';
      contents.add(
        Content(
          id: isSerie
              ? '${e['key_id']}|$type'
              : '$_urlBase/movie-embed/${e['key_id']}',
          slug: 'slug',
          title: e['title'],
          image: image,
          isSerie: isSerie,
        ),
      );
    }
    return contents;
  }

  @override
  Future<List<Season>> seasons(String d) async {
    final data = d.split('|');
    final id = data[0];
    final type = data[1];
    final res = await _dio.post('/$type', data: {type: id});
    final List<Season> seasons = [];

    for (final e in res.data['data']['seasons']) {
      final List<Episode> episodes = e['episodes'].map<Episode>((episode) {
        final seasonNumber = int.parse(e['season_number']);
        final episodeNumber = int.parse(episode['episode_number']);
        final embedUrl = episode['links'][0]['url'];
        return Episode(
          id: embedUrl,
          seasonNumber: seasonNumber,
          episodeNumber: episodeNumber,
        );
      }).toList();
      seasons.add(
        Season(seasonNumber: int.parse(e['season_number']), episodes: episodes),
      );
    }
    return seasons;
  }
}
