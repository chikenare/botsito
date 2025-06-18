import 'package:botsito/models/episode.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EpisodeItem extends StatelessWidget {
  const EpisodeItem({super.key, required this.episode});
  final Episode episode;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        context.push(
          '/links/${episode.id}?title=S${episode.seasonNumber}E${episode.episodeNumber}',
        );
      },
      title: Text('Episodio ${episode.episodeNumber}'),
    );
  }
}
