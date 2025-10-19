import 'dart:async';

import 'package:botsito/providers/source_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchInput extends HookConsumerWidget {
  const SearchInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchNotifier = ref.read(searchProvider.notifier);
    final searchText = useState('');
    final debounceTimer = useState<Timer?>(null);

    useEffect(() {
      return () {
        debounceTimer.value?.cancel();
      };
    }, []);

    void onChanged(String value) {
      if (value.isEmpty) return;
      searchText.value = value;
      debounceTimer.value?.cancel();
      debounceTimer.value = Timer(const Duration(milliseconds: 400), () {
        searchNotifier.search(value);
      });
    }

    return TextField(
      onChanged: onChanged,
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
