import 'package:botsito/providers/setting_provider.dart';
import 'package:botsito/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
                  showModalBottomSheet(
                    context: context,
                    showDragHandle: true,
                    builder: (_) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics:
                            const NeverScrollableScrollPhysics(), // Para evitar conflicto de scroll
                        itemCount: sources.length,
                        itemBuilder: (_, i) => ListTile(
                          selectedTileColor: Colors.blue.shade700,
                          selected: setting.source == sources[i].name,
                          selectedColor: Colors.white,
                          onTap: () {
                            ref
                                .read(settingPProvider.notifier)
                                .updateSetting(
                                  setting.copyWith(source: sources[i].name),
                                );
                            context.pop();
                          },
                          leading: ClipOval(
                            child: Image.asset(
                              'assets/sources/${sources[i].icon}',
                              width: 24,
                            ),
                          ),
                          title: Text(sources[i].name),
                          subtitle: Text(sources[i].domains.join(', ')),
                        ),
                      ),
                    ),
                  );
                },
                title: Text('Source'),
                subtitle: Text(setting.source),
              ),
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
