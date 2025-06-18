import 'package:botsito/models/episode.dart';
import 'package:botsito/providers/source_provider.dart';
import 'package:botsito/util/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EpisodeItem extends HookConsumerWidget {
  const EpisodeItem({super.key, required this.episode});
  final Episode episode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = useState(false);

    return ListTile(
      onTap: () async {
        isLoading.value = true;
        final links = await ref.read(linkProvider(episode.id).future);
        final data = links
            .map((e) => e.url)
            .join(' From botsito ${episode.getVid()} \n');
        Clipboard.setData(ClipboardData(text: data));
        isLoading.value = false;
        if (context.mounted) {
          showSnackbar(context, title: 'Enlaces copiados (${links.length})');
        }
      },
      trailing: isLoading.value
          ? SizedBox.square(
              dimension: 10,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : null,
      title: Text('Episodio ${episode.episodeNumber}'),
    );
  }
}
