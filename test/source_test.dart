import 'dart:developer';

import 'package:botsito/plugins/sources/cinecalidad.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Test source', () async {
    final instance = Cinecalidad();

    final search = await instance.search('el ');

    final id = search.first.id;

    // final seasons = await instance.seasons(id);
    // final links = await instance.getLinks(search.first.id);

    log(id);

    // for (final l in links) {
    //   log(l.url);
    // }

    // log(links.length.toString());
  });
}
