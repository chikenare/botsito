import 'package:botsito/providers/source_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Botsito'),
        actions: [
          IconButton(
            onPressed: () => context.push('/settings'),
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (value) {
              if (value.length >= 2) {
                ref.read(searchProvider.notifier).search(value);
              }
            },
            decoration: InputDecoration(
              hintText: 'Buscar',
              prefixIcon: Icon(Icons.search),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400, width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400, width: 1.0),
              ),
              filled: true,
              contentPadding: EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 20.0,
              ),
            ),
          ),
          ref
              .watch(searchProvider)
              .when(
                data: (content) => Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.all(8.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                                '/links/${item.id}?title=${item.title}',
                              ),
                        child: ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(4.0),
                          child: Image.network(
                            item.image,
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
      ),
    );
  }
}
