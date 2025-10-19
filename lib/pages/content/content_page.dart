import 'dart:developer';

import 'package:botsito/models/content.dart';
import 'package:botsito/models/episode.dart';
import 'package:botsito/models/link.dart';
import 'package:botsito/models/season.dart';
import 'package:botsito/providers/source_provider.dart';
import 'package:botsito/services/link_service.dart';
import 'package:botsito/util/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ContentPage extends HookConsumerWidget {
  const ContentPage({super.key, required this.content});
  final Content content;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSeason = useState<Season?>(null);

    final isLoading = useState(false);
    final current = useState(0);
    final List<Link> links = [];
    final selected = useState<List<Episode>>([]);

    void getLinks() async {
      isLoading.value = true;
      for (final e in selected.value) {
        try {
          final res = await ref.read(
            linkProvider(
              e.id,
              seasonNumber: e.seasonNumber,
              episodeNumber: e.episodeNumber,
            ).future,
          );
          current.value++;

          links.addAll(res);
        } catch (e) {
          log(e.toString());
        } finally {
          isLoading.value = false;
        }
      }
      await LinkService.copyLinks(links);
      if (context.mounted) context.pop();

      if (context.mounted) {
        showSnackbar(context, title: '${links.length} enlaces copiados');
      }
    }

    return Material(
      child: Consumer(
        builder: (context, ref, child) {
          final provider = ref.watch(seasonProvider(content.id));

          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (provider.hasError) {
            return Column(
              children: [
                Text(provider.error.toString()),
                Text(provider.stackTrace.toString()),
              ],
            );
          }

          final seasons = provider.value ?? [];

          if (seasons.isEmpty) {
            return Text('Empty we');
          }

          return Column(
            children: [
              Padding(
                padding: EdgeInsetsGeometry.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _selectSeason(
                      currentSeason: currentSeason,
                      seasons: seasons,
                      selected: selected,
                    ),
                    SizedBox(width: 8.0),
                    if (currentSeason.value != null)
                      TextButton.icon(
                        onPressed: isLoading.value ? null : () => getLinks(),
                        label: Text(
                          '${current.value}/${selected.value.length}',
                        ),
                        icon: Icon(Icons.link),
                      ),
                  ],
                ),
              ),
              if (currentSeason.value != null)
                Expanded(
                  child: ListView.builder(
                    itemCount: currentSeason.value!.episodes.length,
                    itemBuilder: (_, index) {
                      final episode = currentSeason.value!.episodes[index];
                      final isSelected = selected.value.any(
                        (e) => e.id == episode.id,
                      );
                      return CheckboxListTile(
                        onChanged: (value) {
                          if (isSelected) {
                            selected.value = selected.value
                                .where((e) => e != episode)
                                .toList();
                          } else {
                            selected.value = [...selected.value, episode];
                          }
                        },
                        value: isSelected,
                        title: Text('Episode ${episode.episodeNumber}'),
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

  Widget _selectSeason({
    required ValueNotifier<Season?> currentSeason,
    required ValueNotifier<List<Episode>> selected,
    required List<Season> seasons,
  }) {
    return DropdownButton(
      icon: Icon(Icons.arrow_drop_down_rounded),
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
        currentSeason.value = s!;
        selected.value = s.episodes;
      },
    );
  }
}
