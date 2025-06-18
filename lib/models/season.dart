import 'package:botsito/models/episode.dart';

class Season {
  final int seasonNumber;
  final List<Episode> episodes;

  const Season({required this.seasonNumber, required this.episodes});
}
