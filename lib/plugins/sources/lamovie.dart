import 'package:botsito/models/content.dart';
import 'package:botsito/models/episode.dart';
import 'package:botsito/models/link.dart';
import 'package:botsito/models/season.dart';
import 'package:botsito/plugins/sources/provider_base.dart';
import 'package:botsito/util/get_ua.dart';
import 'package:dio/dio.dart';

class Lamovie implements ProviderBase {
  static final _urlBase = 'https://la.movie';

  static Dio get _dio => Dio(
    BaseOptions(
      baseUrl: _urlBase,
      headers: {'user-agent': getUA(), 'referer': _urlBase},
    ),
  );

  @override
  Future<List<Link>> getLinks(String id) async {
    final res = await _dio.get(
      '/wp-api/v1/player',
      queryParameters: {'postId': id},
      options: Options(headers: {'content-type': 'application/json'}),
    );

    final List items = res.data['data']['embeds'] ?? [];

    return items.map((e) {
      return Link(url: e['url'], language: e['lang'], isDownload: false);
    }).toList();
  }

  @override
  Future<List<Content>> search(String query) async {
    final res = await _dio.get(
      '/wp-api/v1/search?postType=any&q=$query&postsPerPage=5',
      options: Options(headers: {'content-type': 'application/json'}),
    );

    final List json = res.data['data']['posts'] ?? [];
    return json.map((e) {
      final image =
          'https://la.movie/wp-content/uploads${e['images']['poster']}';
      final isSerie = ['tvshows', 'animes'].contains(e['type']);

      return Content(
        id: e['_id'].toString(),
        slug: e['slug'],
        title: e['original_title'],
        image: image,
        isSerie: isSerie,
      );
    }).toList();
  }

  @override
  Future<List<Season>> seasons(String id) async {
    final url =
        '/wp-api/v1/single/episodes/list?_id=$id&season=1&page=1&postsPerPage=50';
    final res = await _dio.get(
      url,
      options: Options(headers: {'content-type': 'application/json'}),
    );
    final List<Season> seasons = [];
    final totalSeasons = res.data['data']['seasons'];

    for (final i in totalSeasons) {
      final url =
          '/wp-api/v1/single/episodes/list?_id=$id&season=$i&page=1&postsPerPage=100';
      final res = await _dio.get(
        url,
        options: Options(headers: {'content-type': 'application/json'}),
      );
      final List<Episode> episodes = [];
      for (final e in res.data['data']['posts']) {
        episodes.add(
          Episode(
            id: e['_id'].toString(),
            seasonNumber: e['season_number'],
            episodeNumber: e['episode_number'],
          ),
        );
      }

      seasons.add(Season(seasonNumber: int.parse(i), episodes: episodes));
    }

    return seasons;
  }
}
