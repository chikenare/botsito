import 'package:botsito/pages/home/widgets/search_input.dart';
import 'package:botsito/providers/source_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('Botsito')),
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
                          itemBuilder: (context, index) {
                            final item = content[index];
                            return GestureDetector(
                              onTap: () => item.isSerie
                                  ? context.push('/contents', extra: item)
                                  : context.push(
                                      '/links/${Uri.encodeComponent(item.id)}?title=${item.title}',
                                    ),
                              child: ClipRRect(
                                borderRadius: BorderRadiusGeometry.circular(
                                  12.0,
                                ),
                                child: Image.network(
                                  item.image,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            );
                          },
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
