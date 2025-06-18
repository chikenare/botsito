import 'package:botsito/models/link.dart';
import 'package:botsito/providers/source_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LinksPage extends StatelessWidget {
  const LinksPage({super.key, required this.id});
  final String id;

  void _copy(List<Link> links) {
    final data = links.map((e) => e.url).join('\n');
    Clipboard.setData(ClipboardData(text: data));

    Fluttertoast.showToast(msg: 'Copiado');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final provider = ref.watch(linkProvider(id));

        if (provider.isLoading) {
          return Material(child: Center(child: CircularProgressIndicator()));
        }
        if (provider.hasError) {
          return Text(provider.error.toString());
        }
        final links = provider.value ?? [];
        return Scaffold(
          appBar: AppBar(
            title: Text('Links (${links.length})'),
            actions: [
              TextButton.icon(
                onPressed: () => _copy(links),
                label: Text('Copiar'),
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
