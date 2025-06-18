import 'dart:developer';

import 'package:botsito/plugins/sources/allcalidad.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Test source', () async {
    final allCalidad = Allcalidad();

    final search = await allCalidad.search('Dune: Prophecy');
    final id = search.first.id;

    final seasons = await allCalidad.seasons(id);
    final links = await allCalidad.getLinks(seasons.first.episodes.first.id);

    log(links.length.toString());
  });
}
