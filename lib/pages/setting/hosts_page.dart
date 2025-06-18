import 'package:botsito/providers/remote_config_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HostsPage extends ConsumerWidget {
  const HostsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(remoteConfigProvider);
    final hosts = provider.value?.hosts ?? [];

    return ListTile(
      onTap: () async {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Hosts'),
            content: SizedBox(
              width: 300,
              child: ListView.builder(
                itemCount: hosts.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => ExpansionTile(
                  title: Text(hosts[index].name),
                  subtitle: Text(hosts[index].domain),
                  children: hosts[index].toReplace
                      .map((e) => ListTile(title: Text(e)))
                      .toList(),
                ),
              ),
            ),
          ),
        );
      },
      title: Text('Dominios'),
      subtitle: Text(provider.value?.hosts.length.toString() ?? '...'),
    );
  }
}
