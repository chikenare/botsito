import 'package:botsito/pages/setting/hosts_page.dart';
import 'package:botsito/providers/setting_provider.dart';
import 'package:botsito/util/snackbar.dart';
import 'package:flutter/material.dart';
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
                  showSnackbar(context, title: 'Pronto habrá más 🥵');
                },
                title: Text('Source'),
                subtitle: Text(setting.source),
              ),
              HostsPage(),
              SwitchListTile(
                onChanged: (value) {
                  ref
                      .read(settingPProvider.notifier)
                      .updateSetting(setting.copyWith(forceInclude: value));
                },
                value: setting.forceInclude,
                title: Text('Forzar enlace'),
                subtitle: Text('Incluir enlaces sín dominio verificado'),
              ),
            ],
          );
        },
      ),
    );
  }
}
