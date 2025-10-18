// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'source_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SourceP)
const sourcePProvider = SourcePProvider._();

final class SourcePProvider extends $NotifierProvider<SourceP, String> {
  const SourcePProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sourcePProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sourcePHash();

  @$internal
  @override
  SourceP create() => SourceP();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$sourcePHash() => r'a23d8a3c56af56804a26d4d511b2e41c6309c9b7';

abstract class _$SourceP extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(getSourceInstance)
const getSourceInstanceProvider = GetSourceInstanceProvider._();

final class GetSourceInstanceProvider
    extends $FunctionalProvider<dynamic, dynamic, dynamic>
    with $Provider<dynamic> {
  const GetSourceInstanceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getSourceInstanceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getSourceInstanceHash();

  @$internal
  @override
  $ProviderElement<dynamic> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  dynamic create(Ref ref) {
    return getSourceInstance(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(dynamic value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<dynamic>(value),
    );
  }
}

String _$getSourceInstanceHash() => r'a89a946a782b07faabf3605cfb0182f935c7cf92';

@ProviderFor(Search)
const searchProvider = SearchProvider._();

final class SearchProvider
    extends $AsyncNotifierProvider<Search, List<Content>> {
  const SearchProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchHash();

  @$internal
  @override
  Search create() => Search();
}

String _$searchHash() => r'f1c4c9a2a1a4bf087980f19075423ecef9f2b6dc';

abstract class _$Search extends $AsyncNotifier<List<Content>> {
  FutureOr<List<Content>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<Content>>, List<Content>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Content>>, List<Content>>,
              AsyncValue<List<Content>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(link)
const linkProvider = LinkFamily._();

final class LinkProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Link>>,
          List<Link>,
          FutureOr<List<Link>>
        >
    with $FutureModifier<List<Link>>, $FutureProvider<List<Link>> {
  const LinkProvider._({
    required LinkFamily super.from,
    required (String, {int? seasonNumber, int? episodeNumber}) super.argument,
  }) : super(
         retry: null,
         name: r'linkProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$linkHash();

  @override
  String toString() {
    return r'linkProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<Link>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Link>> create(Ref ref) {
    final argument =
        this.argument as (String, {int? seasonNumber, int? episodeNumber});
    return link(
      ref,
      argument.$1,
      seasonNumber: argument.seasonNumber,
      episodeNumber: argument.episodeNumber,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is LinkProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$linkHash() => r'a855d99e882653b016ad7eff004783c73df6e1b1';

final class LinkFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<Link>>,
          (String, {int? seasonNumber, int? episodeNumber})
        > {
  const LinkFamily._()
    : super(
        retry: null,
        name: r'linkProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  LinkProvider call(String id, {int? seasonNumber, int? episodeNumber}) =>
      LinkProvider._(
        argument: (
          id,
          seasonNumber: seasonNumber,
          episodeNumber: episodeNumber,
        ),
        from: this,
      );

  @override
  String toString() => r'linkProvider';
}

@ProviderFor(season)
const seasonProvider = SeasonFamily._();

final class SeasonProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Season>>,
          List<Season>,
          FutureOr<List<Season>>
        >
    with $FutureModifier<List<Season>>, $FutureProvider<List<Season>> {
  const SeasonProvider._({
    required SeasonFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'seasonProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$seasonHash();

  @override
  String toString() {
    return r'seasonProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Season>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Season>> create(Ref ref) {
    final argument = this.argument as String;
    return season(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SeasonProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$seasonHash() => r'16a2dbe727614397a369adc529bd713fe895e2d6';

final class SeasonFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Season>>, String> {
  const SeasonFamily._()
    : super(
        retry: null,
        name: r'seasonProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SeasonProvider call(String id) => SeasonProvider._(argument: id, from: this);

  @override
  String toString() => r'seasonProvider';
}
