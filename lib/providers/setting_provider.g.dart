// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SettingP)
const settingPProvider = SettingPProvider._();

final class SettingPProvider
    extends $AsyncNotifierProvider<SettingP, Setting?> {
  const SettingPProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingPProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingPHash();

  @$internal
  @override
  SettingP create() => SettingP();
}

String _$settingPHash() => r'e4567e313d251368fe96fc33bd237a75ee12e3ac';

abstract class _$SettingP extends $AsyncNotifier<Setting?> {
  FutureOr<Setting?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<Setting?>, Setting?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Setting?>, Setting?>,
              AsyncValue<Setting?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
