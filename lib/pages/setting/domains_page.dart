import 'package:botsito/models/setting/domain.dart';
import 'package:botsito/pages/setting/edit_domain_page.dart';
import 'package:botsito/pages/setting/new_domain_page.dart';
import 'package:botsito/providers/setting_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DomainsPage extends ConsumerWidget {
  const DomainsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(settingPProvider);
    final settingNotifier = ref.read(settingPProvider.notifier);

    if (!provider.hasValue || provider.isLoading) return SizedBox.shrink();

    final setting = provider.value!;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final domain = await Navigator.push<Domain?>(
            context,
            MaterialPageRoute(builder: (context) => NewDomainPage()),
          );
          if (domain != null) {
            setting.domains.add(domain);
            settingNotifier.updateSetting(setting);
          }
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(title: Text('Dominios')),
      body: setting.domains.isEmpty
          ? Center(
              child: Text(
                'Agrega un dominio',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            )
          : ListView.builder(
              itemCount: setting.domains.length,
              shrinkWrap: true,
              itemBuilder: (context, index) => Dismissible(
                onDismissed: (direction) {
                  setting.domains.removeWhere(
                    (e) => e.name == setting.domains[index].name,
                  );
                  settingNotifier.updateSetting(setting);
                },
                key: Key(index.toString()),
                background: Container(
                  padding: EdgeInsets.only(left: 10),
                  color: Colors.red,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Eliminar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                direction: DismissDirection.startToEnd,
                child: ListTile(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          EditDomainPage(domain: setting.domains[index]),
                    ),
                  ),
                  title: Text(setting.domains[index].name),
                ),
              ),
            ),
    );
  }
}
