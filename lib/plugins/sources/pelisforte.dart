import 'package:botsito/models/content.dart';
import 'package:botsito/models/link.dart';
import 'package:botsito/models/season.dart';
import 'package:botsito/plugins/sources/provider_base.dart';
import 'package:dio/dio.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

class Pelisforte implements ProviderBase {
  static Dio get _dio =>
      Dio(BaseOptions(baseUrl: 'https://www2.pelisforte.se'));

  @override
  Future<List<Content>> search(String query) async {
    final res = await _dio.get('/', queryParameters: {'s': query});

    final html = parse(res.data);

    final items = html.querySelectorAll('ul.post-lst li');

    return items.map((e) {
      final id = e.querySelector('a')!.attributes['href']!;
      final image = e.querySelector('img')!.attributes['src']!;
      final title = e.querySelector('h2.entry-title')!.text;
      final isSerie = !id.contains('pelicula');
      return Content(
        id: id,
        slug: 'slug',
        title: title,
        image: image,
        isSerie: isSerie,
      );
    }).toList();
  }

  @override
  Future<List<Season>> seasons(String id) async {
    return [];
  }

  @override
  Future<List<Link>> getLinks(String id) async {
    final res = await _dio.get(id);
    final html = parse(res.data);

    final List<Link> links = [];

    for (final e in html.querySelectorAll('.video')) {
      final iframe = e.querySelector('iframe');
      final urlEncrypted = iframe?.attributes['data-src'];
      final keyForLang = e.attributes['id'];
      if (urlEncrypted == null || keyForLang == null) continue;
      final language = _getLanguage(keyForLang, html);

      if (language == null) continue;

      final uri = Uri.parse(urlEncrypted);
      final token = uri.queryParameters['h'];
      final url = 'https://${uri.host}/r.php?h=$token';
      final res = await _dio.get(url);
      final finalUrl = res.redirects.first.location.toString();

      links.add(Link(url: finalUrl, language: language, isDownload: false));
    }

    return links;
  }

  String? _getLanguage(String key, Document html) {
    for (final i in html.querySelectorAll('.aa-tbs-video a')) {
      if (i.attributes['href'] == '#$key') {
        return i
            .querySelector('span.server')
            ?.text
            .replaceAll(RegExp(r'\s+'), '')
            .trim();
      }
    }
    return null;
  }
}
