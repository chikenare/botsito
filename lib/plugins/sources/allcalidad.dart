import 'package:botsito/models/content.dart';
import 'package:botsito/models/episode.dart';
import 'package:botsito/models/link.dart';
import 'package:botsito/models/season.dart';
import 'package:botsito/plugins/sources/provider_base.dart';
import 'package:dio/dio.dart';

class Allcalidad implements ProviderBase {
  static Dio get _dio =>
      Dio(BaseOptions(baseUrl: 'https://allcalidad.re/api/rest'));
  static const _imageUrlBase = 'https://allcalidad.re/wp-content/uploads';

  @override
  Future<List<Content>> search(String query) async {
    final res = await _dio.get(
      '/search',
      queryParameters: {
        'query': query,
        'post_type': 'movies,tvshows,animes',
        'posts_per_page': 16,
      },
    );

    final data = res.data['data']['posts'].map<Content>((e) {
      return Content(
        id: e['_id'].toString(),
        slug: e['slug'],
        title: e['title'],
        image: '$_imageUrlBase${e['images']['poster']}',
        isSerie: e['type'] == 'tvshows',
      );
    }).toList();
    return data;
  }

  @override
  Future<List<Season>> seasons(String id) async {
    final res = await _dio.get('/episodes', queryParameters: {'post_id': id});
    final List<Episode> episodes = res.data['data'].map<Episode>((e) {
      return Episode(
        id: e['_id'].toString(),
        seasonNumber: e['season_number'],
        episodeNumber: e['episode_number'],
      );
    }).toList();

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
  Future<List<Link>> getLinks(String postId) async {
    final res = await _dio.get('/player?post_id=$postId&_any=1');

    final embeds = res.data['data']['embeds'].map((e) {
      return Link(url: e['url']);
    });

    final downloads = res.data['data']['downloads'].map((e) {
      return Link(url: e['url']);
    });
    return [...embeds, ...downloads];
  }
}
