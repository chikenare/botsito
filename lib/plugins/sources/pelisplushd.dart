import 'package:botsito/models/content.dart';
import 'package:botsito/models/episode.dart';
import 'package:botsito/models/link.dart';
import 'package:botsito/models/season.dart';
import 'package:botsito/plugins/sources/provider_base.dart';
import 'package:botsito/util/get_ua.dart';
import 'package:dio/dio.dart';
import 'package:html/parser.dart';

class Pelisplushd implements ProviderBase {
  final urlBase = 'https://www.pelisplushd.ms';

  Dio get _dio =>
      Dio(BaseOptions(baseUrl: urlBase, headers: {'User-Agent': getUA()}));

  @override
  Future<List<Link>> getLinks(String id) async {
    final res = await _dio.get(id);
    final doc = parse(res.data);

    final items = id.contains('temporada-')
        ? doc.querySelectorAll('#link_url span').map((e) {
            final url = e.attributes['url']!;
            return Link(url: url, language: 'Latino', isDownload: false);
          }).toList()
        : doc.querySelectorAll('ul.TbVideoNv li').map((e) {
            final url = e.attributes['data-url']!;
            final language = e.attributes['data-name']!;
            return Link(url: url, language: language, isDownload: false);
          }).toList();
    return items;
  }

  @override
  Future<List<Content>> search(String query) async {
    final res = await _dio.get('/search?s=$query');
    final document = parse(res.data);

    final items = document.querySelectorAll('.Posters a').map((e) {
      final id = '$urlBase${e.attributes['href']}';
      final image = '$urlBase${e.querySelector('img')?.attributes['src']}';
      final title = e.querySelector('.listing-content p')!.text;

      final isSerie = id.contains('/serie');

      return Content(
        id: id,
        slug: '',
        title: title,
        image: image,
        isSerie: isSerie,
      );
    }).toList();
    return items;
  }

  @override
  Future<List<Season>> seasons(String id) async {
    final res = await _dio.get(id);
    final doc = parse(res.data);
    final episodes = doc.querySelectorAll('#pills-vertical-1 a').map((e) {
      final path = e.attributes['href']!;
      final url = '$urlBase$path';
      final data = path.split('-');

      final seasonNumber = int.parse(data[data.length - 3]);
      final episodeNumber = int.parse(data[data.length - 1]);
      return Episode(
        id: url,
        seasonNumber: seasonNumber,
        episodeNumber: episodeNumber,
      );
    }).toList();
    final seasons = _groupEpisodesBySeason(episodes);

    return seasons;
  }

  List<Season> _groupEpisodesBySeason(List<Episode> episodes) {
    final Map<int, List<Episode>> seasonMap = {};

    for (var episode in episodes) {
      seasonMap.putIfAbsent(episode.seasonNumber, () => []);
      seasonMap[episode.seasonNumber]!.add(episode);
    }

    final List<Season> seasons = seasonMap.entries.map((entry) {
      entry.value.sort((a, b) => a.episodeNumber.compareTo(b.episodeNumber));

      return Season(seasonNumber: entry.key, episodes: entry.value);
    }).toList();

    seasons.sort((a, b) => a.seasonNumber.compareTo(b.seasonNumber));

    return seasons;
  }
}
