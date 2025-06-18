import 'package:botsito/models/content.dart';
import 'package:botsito/models/season.dart';
import 'package:botsito/pages/content/widgets/episode_item.dart';
import 'package:botsito/providers/source_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ContentPage extends HookConsumerWidget {
  const ContentPage({super.key, required this.content});
  final Content content;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSeason = useState<Season?>(null);

    final isLoading = useState(false);
    final currentProgress = useState(0.0);

    return Scaffold(
      appBar: AppBar(title: Text(content.title)),
      body: Consumer(
        builder: (context, ref, child) {
          final provider = ref.watch(seasonProvider(content.id));

          if (provider.isLoading) {
            return SizedBox.shrink();
          }

          if (provider.hasError) {
            return Text(provider.error.toString());
          }

          final seasons = provider.value ?? [];

          if (seasons.isEmpty) {
            return Text('Empty we');
          }

          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        icon: Icon(Icons.arrow_drop_down_rounded),
                        dropdownColor: Colors.white,
                        value: currentSeason.value,
                        hint: Text('Temporada'),
                        items: seasons
                            .map(
                              (season) => DropdownMenuItem(
                                value: season,
                                child: Text('Temporada ${season.seasonNumber}'),
                              ),
                            )
                            .toList(),
                        onChanged: (s) {
                          currentSeason.value = s;
                        },
                      ),
                    ),
                  ),
                  if (currentSeason.value != null)
                    IconButton(
                      onPressed: () async {
                        currentProgress.value = 0.0;
                        isLoading.value = true;
                        final List<String> links = [];

                        for (final episode in currentSeason.value!.episodes) {
                          final data = await ref.read(
                            linkProvider(episode.id).future,
                          );
                          for (final l in data) {
                            links.add(
                              '${l.url} From botsito ${episode.getVid()}',
                            );
                          }

                          currentProgress.value++;
                        }

                        Clipboard.setData(
                          ClipboardData(text: links.join('\n')),
                        );

                        isLoading.value = false;
                      },
                      icon: isLoading.value
                          ? SizedBox.square(
                              dimension: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                value:
                                    currentProgress.value /
                                    currentSeason.value!.episodes.length,
                              ),
                            )
                          : Icon(Icons.copy),
                      tooltip: 'Copiar enlaces temporada',
                    ),
                ],
              ),
              if (currentSeason.value != null)
                Expanded(
                  child: ListView.builder(
                    itemCount: currentSeason.value!.episodes.length,
                    itemBuilder: (_, index) {
                      return EpisodeItem(
                        episode: currentSeason.value!.episodes[index],
                      );
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
