import 'package:botsito/models/link.dart';
import 'package:botsito/providers/source_provider.dart';
import 'package:botsito/util/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LinksPage extends StatelessWidget {
  const LinksPage({super.key, required this.id});
  final String id;

  void _copy(BuildContext context, List<Link> links) {
    final data = links.where((e) => e.include);
    final dataString = data.map((e) => e.url).join('\n');
    Clipboard.setData(ClipboardData(text: dataString));

    if (context.mounted) {
      showSnackbar(context, title: 'Enlaces copiados (${data.length})');
    }
  }

  @override
  Widget build(BuildContext context) {
    final title =
        GoRouter.of(context).state.uri.queryParameters['title'] ?? 'No title';
    return Consumer(
      builder: (context, ref, child) {
        final provider = ref.watch(linkProvider(id));

        if (provider.isLoading) {
          return Material(child: Center(child: CircularProgressIndicator()));
        }
        if (provider.hasError) {
          return Center(
            child: Material(child: Text(provider.error.toString())),
          );
        }
        final links = provider.value ?? [];
        return Scaffold(
          appBar: AppBar(
            title: Text(title),
            actions: [
              IconButton(
                onPressed: () => _copy(context, links),
                icon: Icon(Icons.copy_all),
              ),
            ],
          ),
          body: ListView.builder(
            shrinkWrap: true,
            itemCount: links.length,
            itemBuilder: (context, index) {
              final item = links[index];
              return ListTile(
                enabled: item.include,
                onTap: () {
                  launchUrlString(
                    item.url,
                    mode: LaunchMode.externalApplication,
                  );
                },
                title: Text(item.hostname),
              );
            },
          ),
        );
      },
    );
  }
}
