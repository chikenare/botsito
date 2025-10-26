import 'dart:convert';

import 'package:botsito/models/content.dart';
import 'package:botsito/models/episode.dart';
import 'package:botsito/models/link.dart';
import 'package:botsito/models/season.dart';
import 'package:botsito/plugins/sources/provider_base.dart';
import 'package:botsito/util/get_ua.dart';
import 'package:dio/dio.dart';
import 'package:html/parser.dart';

class Cuevana implements ProviderBase {
  final _urlBase = 'https://cuevana.biz';
  Dio get _dio =>
      Dio(BaseOptions(baseUrl: _urlBase, headers: {'User-Agent': getUA()}));

  @override
  Future<List<Link>> getLinks(String id) async {
    final res = await _dio.get(id);

    final html = parse(res.data);

    final List<Link> links = [];

    for (final e in html.querySelectorAll('.open_submenu')) {
      final language = e
          .querySelectorAll('span')[1]
          .text
          .replaceAll(RegExp('CALIDAD|HD'), '')
          .trim();

      for (final li in e.querySelectorAll('li')) {
        final tmpUrl = li.attributes['data-tr']!;
        final url = await _getUrl(tmpUrl);
        links.add(Link(url: url, language: language, isDownload: false));
      }
    }
    return links;
  }

  Future<String> _getUrl(String tmpUrl) async {
    final res = await _dio.get(tmpUrl);
    final reg = RegExp("var url = '(.*)';");

    final match = reg.firstMatch(res.data);
    final url = match?.group(1);

    return url ?? 'Wee';
  }

  @override
  Future<List<Content>> search(String query) async {
    final res = await _dio.get('/search?q=$query');
    final html = parse(res.data);

    final items = html.querySelectorAll('li.TPostMv').map((e) {
      final id = e.querySelector('a')!.attributes['href']!;
      final image = '$_urlBase${e.querySelector('img')!.attributes['src']!}';
      final title = e.querySelector('span.Title')!.text;
      final isSerie = id.contains('ver-serie');

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

    final html = parse(res.data);
    final scriptTag = html.querySelector('#__NEXT_DATA__');
    if (scriptTag == null) return [];
    final jsonData = jsonDecode(scriptTag.text);
    final pageProps = jsonData['props']['pageProps'];

    final List<Season> seasons = pageProps['thisSerie']['seasons'].map<Season>((
      e,
    ) {
      final seasonNumber = e['number'];

      final List<Episode> episodes = e['episodes'].map<Episode>((ep) {
        final id = '$_urlBase/${ep['url']['slug']}'
            .replaceFirst('/series', '/ver-serie')
            .replaceFirst('/seasons', '/temporada')
            .replaceFirst('/episodes', '/episodio');
        return Episode(
          id: id,
          seasonNumber: seasonNumber,
          episodeNumber: e['number'],
        );
      }).toList();
      return Season(seasonNumber: seasonNumber, episodes: episodes);
    }).toList();

    return seasons;
  }
}
