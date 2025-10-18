import 'package:botsito/models/content.dart';
import 'package:botsito/pages/content/content_page.dart';
import 'package:botsito/providers/source_provider.dart';
import 'package:botsito/services/link_service.dart';
import 'package:botsito/util/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ContentItem extends HookConsumerWidget {
  const ContentItem({super.key, required this.content});
  final Content content;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = useState(false);

    void getLinks(String id) async {
      isLoading.value = true;
      try {
        final links = await ref.read(linkProvider(id).future);
        await LinkService.copyLinks(links);
        if (context.mounted) {
          showSnackbar(context, title: 'Copiado');
        }
      } catch (e) {
        if (context.mounted) {
          showSnackbar(context, title: e.toString(), color: Colors.red);
        }
      } finally {
        isLoading.value = false;
      }
    }

    return GestureDetector(
      onTap: () {
        if (!content.isSerie) {
          getLinks(content.id);
          return;
        }

        showModalBottomSheet(
          context: context,
          builder: (_) => ContentPage(content: content),
        );
      },
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(12.0),
              child: Image.network(
                content.image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
              ),
            ),
          ),
          if (isLoading.value)
            Padding(
              padding: EdgeInsetsGeometry.all(8.0),
              child: SizedBox.square(
                dimension: 14.0,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
        ],
      ),
    );
  }
}
