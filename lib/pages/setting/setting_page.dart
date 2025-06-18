import 'package:botsito/models/setting/domain.dart';
import 'package:botsito/pages/setting/domains_page.dart';
import 'package:botsito/providers/setting_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Configuración')),
      body: Consumer(
        builder: (context, ref, child) {
          final provider = ref.watch(settingPProvider);

          if (provider.hasError) {
            return Text(provider.error.toString());
          }

          if (provider.isLoading || !provider.hasValue) {
            return SizedBox.shrink();
          }

          final setting = provider.value!;

          return Column(
            children: [
              ListTile(
                onTap: () {
                  Fluttertoast.showToast(msg: 'Pronto habrá más 🥵');
                },
                title: Text('Source'),
                subtitle: Text(setting.source),
              ),
              ListTile(
                onTap: () async {
                  final res = await Navigator.push<Domain?>(
                    context,
                    MaterialPageRoute(builder: (_) => DomainsPage()),
                  );
                  if (res != null) {
                    setting.domains.add(res);
                    ref.read(settingPProvider.notifier).updateSetting(setting);
                  }
                },
                title: Text('Dominios'),
                subtitle: Text(setting.domains.length.toString()),
              ),
            ],
          );
        },
      ),
    );
  }
}
