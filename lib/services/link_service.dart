import 'dart:convert';

import 'package:botsito/models/link.dart';
import 'package:flutter/services.dart';

class LinkService {
  static Future<void> copyLinks(List<Link> links) async {
    final linksData = jsonEncode(links.map((e) => e.toJson()).toList());

    await Clipboard.setData(ClipboardData(text: linksData));
  }

  static List<String> getLanguages(String language) {
    switch (language) {
      case 'Latino':
      case 'LATINO':
      case 'EspañolLatino':
        return ['es'];
      case 'Latino/Inglés':
        return ['es', 'en'];
      case 'Subtitulado':
      case 'SUBTITULADO':
        return ['en'];
      case 'Castellano':
      case 'CASTELLANO':
        return ['es-ES'];
      default:
        return [];
    }
  }
}
