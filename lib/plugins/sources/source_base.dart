import 'package:botsito/models/content.dart';
import 'package:botsito/models/link.dart';
import 'package:botsito/models/season.dart';

abstract class SourceBase {
  Future<List<Content>> search(String query);
  Future<List<Season>> seasons(String id);
  Future<List<Link>> getLinks(String id);
}
