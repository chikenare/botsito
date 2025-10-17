import 'package:botsito/providers/source_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchInput extends HookConsumerWidget {
  const SearchInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchNotifier = ref.read(searchProvider.notifier);

    return TextField(
      onChanged: (value) {
        if (value.length >= 3) {
          searchNotifier.search(value);
        }
      },
      decoration: InputDecoration(
        hintText: 'Buscar',
        prefixIcon: Icon(Icons.search),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        filled: true,
      ),
    );
  }
}
