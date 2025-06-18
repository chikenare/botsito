import 'package:botsito/models/setting/domain.dart';
import 'package:botsito/providers/setting_provider.dart';
import 'package:botsito/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditDomainPage extends HookConsumerWidget {
  const EditDomainPage({super.key, required this.domain});
  final Domain domain;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final nameController = useTextEditingController(text: domain.name);
    final newReplaceDomainController = useTextEditingController();
    final replaceDomains = useState<List<String>>(domain.replaceBy);
    final ignore = useState(domain.ignore);
    return Scaffold(
      appBar: AppBar(title: Text('Editar')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 30),
              TextFormField(
                controller: nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Dominio requerido';
                  }
                  if (!domainRegex.hasMatch(value)) {
                    return 'Dominio no valido';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Dominio',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                      width: 1.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                      width: 1.0,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 20.0,
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: newReplaceDomainController,
                validator: (value) {
                  if (value == null || value.isEmpty) return null;
                  if (!domainRegex.hasMatch(value)) {
                    return 'Dominio no valido';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      if (!replaceDomains.value.contains(
                        newReplaceDomainController.text,
                      )) {
                        replaceDomains.value = [
                          ...replaceDomains.value,
                          newReplaceDomainController.text.toLowerCase(),
                        ];
                      }
                      newReplaceDomainController.clear();
                    },
                    icon: Icon(Icons.add),
                  ),
                  hintText: 'Reemplazar por',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                      width: 1.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                      width: 1.0,
                    ),
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 20.0,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Wrap(
                spacing: 4,
                children: replaceDomains.value
                    .map(
                      (e) => Chip(
                        label: Text(e),
                        onDeleted: () {
                          replaceDomains.value = replaceDomains.value
                              .where((listDomain) => listDomain != e)
                              .toList();
                        },
                      ),
                    )
                    .toList(),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Switch(
                    value: ignore.value,
                    onChanged: (a) => ignore.value = a,
                  ),
                  Text('Ignorar'),
                ],
              ),
              SizedBox(height: 30),
              FilledButton(
                onPressed: () async {
                  if (formKey.currentState?.validate() ?? false) {
                    final setting = await ref.read(settingPProvider.future);
                    if (setting == null) return;

                    final edited = Domain(
                      id: domain.id.toLowerCase(),
                      name: domain.name,
                      ignore: ignore.value,
                      replaceBy: replaceDomains.value,
                    );

                    final index = setting.domains.indexWhere(
                      (e) => e.id == domain.id,
                    );
                    setting.domains.removeAt(index);
                    setting.domains.insert(index, edited);

                    ref.read(settingPProvider.notifier).updateSetting(setting);

                    if (context.mounted) {
                      Navigator.pop(context, domain);
                    }
                  }
                },
                child: Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
