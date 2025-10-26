import 'package:botsito/providers/source_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchInput extends HookConsumerWidget {
  const SearchInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchNotifier = ref.read(searchProvider.notifier);
    final searchInput = useState('');
    final loading = useState(false);

    final debouncedInput = useDebounced(
      searchInput.value,
      Duration(seconds: 1),
    );

    useEffect(() {
      if (searchInput.value.isNotEmpty) {
        loading.value = true;
        searchNotifier
            .search(searchInput.value)
            .whenComplete(() => loading.value = false);
      }
      return null;
    }, [debouncedInput]);

    void onChanged(String value) async {
      searchInput.value = value;
    }

    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Buscar',
        prefixIcon: Icon(Icons.search),
        suffixIcon: loading.value
            ? Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              )
            : null,
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
