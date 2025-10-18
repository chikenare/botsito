import 'package:botsito/models/link.dart';
import 'package:flutter/services.dart';

class LinkService {
  static Future<void> copyLinks(List<Link> links) async {
    String data = '';

    for (final link in links) {
      String se = '';
      if (link.seasonNumber != null && link.episodeNumber != null) {
        se =
            'S${link.seasonNumber.toString().padLeft(2, '0')}E${link.episodeNumber.toString().padLeft(2, '0')}';
      }
      final languages = getLanguages(link.language);
      data += '${link.url} $se languages="$languages"\n';
    }

    await Clipboard.setData(ClipboardData(text: data));
  }

  static String getLanguages(String language) {
    switch (language) {
      case 'Latino':
        return 'es';
      case 'Latino/Inglés':
        return 'es,en';
      default:
        throw ('Language $language not supported');
    }
  }
}
