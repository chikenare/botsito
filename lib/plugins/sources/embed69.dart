import 'dart:convert';

import 'package:botsito/models/content.dart';
import 'package:botsito/models/episode.dart';
import 'package:botsito/models/link.dart';
import 'package:botsito/models/season.dart';
import 'package:botsito/plugins/sources/provider_base.dart';
import 'package:botsito/util/get_ua.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:html/parser.dart';

part 'embed69.freezed.dart';
part 'embed69.g.dart';

@freezed
abstract class _FileEmbed with _$FileEmbed {
  const factory _FileEmbed({required List<_Item> items}) = FileEmbed;

  factory _FileEmbed.fromJson(Map<String, dynamic> json) =>
      _$FileEmbedFromJson(json);
}

@freezed
abstract class _Item with _$Item {
  const factory _Item({
    @JsonKey(name: 'file_id') required String fileId,
    @JsonKey(name: 'video_language') required String language,
    required List<_SortedEmbed> sortedEmbeds,
  }) = Item;

  factory _Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}

@freezed
abstract class _SortedEmbed with _$SortedEmbed {
  const factory _SortedEmbed({
    required String servername,
    required String link,
    required String type,
  }) = SortedEmbed;

  factory _SortedEmbed.fromJson(Map<String, dynamic> json) =>
      _$SortedEmbedFromJson(json);
}

class Embed69 implements ProviderBase {
  static const _urlBase = 'https://embed69.org';
  Dio get _dio => Dio(
    BaseOptions(
      baseUrl: _urlBase,
      headers: {'user-agent': getUA(), 'origin': _urlBase},
    ),
  );
  @override
  Future<List<Link>> getLinks(String id) async {
    final res = await _dio.get('/f/$id');

    final reg = RegExp('let dataLink = (.*);');
    final data = reg.firstMatch(res.data)?.group(1);

    if (data == null) {
      throw Exception('No data');
    }
    final rawLinks = jsonDecode(data);
    final filesData = FileEmbed.fromJson({'items': rawLinks});

    final linksData = await _getDecryptedLinks(data: filesData, filePath: id);

    final List<Link> links = [];

    for (final item in linksData.items) {
      item.language;
      for (final itemxd in item.sortedEmbeds) {
        links.add(
          Link(url: itemxd.link, language: item.language, isDownload: false),
        );
      }
    }

    return links;
  }

  Future<FileEmbed> _getDecryptedLinks({
    required FileEmbed data,
    required String filePath,
  }) async {
    final links = data._items
        .expand((e) => e.sortedEmbeds.map((x) => x.link))
        .toList();
    final res = await _dio.post('/api/decrypt', data: {'links': links});

    final linksDecrypted = res.data['links'].map((e) => e['link']).toList();

    int index = 0;
    final updatedItems = data.items.map((item) {
      final updatedEmbeds = item.sortedEmbeds.map((embed) {
        final newEmbed = embed.copyWith(link: linksDecrypted[index]);
        index++;
        return newEmbed;
      }).toList();

      return item.copyWith(sortedEmbeds: updatedEmbeds);
    }).toList();

    return data.copyWith(items: updatedItems);
  }

  @override
  Future<List<Content>> search(String query) async {
    final res = await Dio().get('https://www.imdb.com/es/find/?q=$query');

    final List<Content> contents = [];

    final html = parse(res.data);

    final items = html.querySelectorAll(
      '[data-testid="find-results-section-title"] li',
    );

    for (final item in items) {
      final path = item.querySelector('a')?.attributes['href'];
      if (path == null) continue;
      final url = 'https://www.imdb.com$path';
      final res = await Dio().get(url);

      final contentHtml = parse(res.data);
      final isSerie =
          contentHtml
              .querySelector('meta[property="og:type"]')
              ?.attributes['content'] ==
          'video.tv_show';
      final image = contentHtml
          .querySelector('meta[property="og:image"]')!
          .attributes['content']!;

      final regExp = RegExp(r'tt\d+');

      final id = regExp.firstMatch(url)?.group(0);
      if (id == null) continue;

      contents.add(
        Content(
          id: id,
          slug: 'slug',
          title: '',
          image: image,
          isSerie: isSerie,
        ),
      );
    }

    return contents;
  }

  @override
  Future<List<Season>> seasons(String id) async {
    final List<Season> seasons = [];
    final res = await Dio().get('https://www.imdb.com/es/title/$id/episodes');

    final html = parse(res.data);
    final totalSeasons = html
        .querySelectorAll('[data-testid="tab-season-entry"]')
        .length;

    for (int sE = 1; sE <= totalSeasons; sE++) {
      final res2 = await Dio().get(
        'https://www.imdb.com/es/title/$id/episodes?season=$sE',
      );
      final html2 = parse(res2.data);
      final List<Episode> episodes = [];
      final totalSeasons = html2
          .querySelectorAll('.episode-item-wrapper')
          .length;

      for (int eN = 1; eN <= totalSeasons; eN++) {
        final episodeId = _buildId(id: id, seasonNumber: sE, episodeNumber: eN);
        episodes.add(
          Episode(id: episodeId, seasonNumber: sE, episodeNumber: eN),
        );
      }
      seasons.add(Season(seasonNumber: sE, episodes: episodes));
    }

    return seasons;
  }

  String _buildId({required String id, int? seasonNumber, int? episodeNumber}) {
    if (seasonNumber == null || episodeNumber == null) return id;
    if (id.isEmpty) throw ArgumentError('id no puede estar vacío');
    if (seasonNumber < 0) throw ArgumentError('seasonNumber inválido');
    if (episodeNumber < 0) throw ArgumentError('episodeNumber inválido');

    final ep = episodeNumber.toString().padLeft(2, '0');

    final season = seasonNumber.toString();

    return '$id-${season}x$ep';
  }
}
