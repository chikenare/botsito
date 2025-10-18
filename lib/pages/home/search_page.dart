import 'package:botsito/pages/home/widgets/content_item.dart';
import 'package:botsito/pages/home/widgets/search_input.dart';
import 'package:botsito/providers/source_provider.dart';
import 'package:botsito/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(sourcePProvider);
    return Scaffold(
      appBar: AppBar(
        title: PopupMenuButton<String>(
          tooltip: 'Provider',
          initialValue: provider,
          onSelected: (value) {
            if (value == provider) return;
            ref.read(sourcePProvider.notifier).setProvider(value);
          },
          child: Text(provider),
          itemBuilder: (_) => sources
              .map((e) => PopupMenuItem(value: e.name, child: Text(e.name)))
              .toList(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer(
          builder: (context, ref, child) {
            return Column(
              children: [
                SearchInput(),
                SizedBox(height: 12.0),
                ref
                    .watch(searchProvider)
                    .when(
                      data: (content) => Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 2 / 3,
                                mainAxisSpacing: 8,
                                crossAxisSpacing: 8,
                              ),
                          itemCount: content.length,
                          itemBuilder: (context, index) =>
                              ContentItem(content: content[index]),
                        ),
                      ),
                      error: (error, stackTrace) => Text('Error'),
                      loading: () => CircularProgressIndicator(),
                    ),
              ],
            );
          },
        ),
      ),
    );
  }
}
