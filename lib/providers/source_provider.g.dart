// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'source_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getSourceInstance)
const getSourceInstanceProvider = GetSourceInstanceProvider._();

final class GetSourceInstanceProvider
    extends $FunctionalProvider<AsyncValue<dynamic>, dynamic, FutureOr<dynamic>>
    with $FutureModifier<dynamic>, $FutureProvider<dynamic> {
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
  $FutureProviderElement<dynamic> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<dynamic> create(Ref ref) {
    return getSourceInstance(ref);
  }
}

String _$getSourceInstanceHash() => r'a4b98b3af3c5a0fa444dd1327d2ec66866f416d8';

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

String _$searchHash() => r'324900c8728b0f95d88681bb0b3980c9b0d9feb9';

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
    required String super.argument,
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
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Link>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Link>> create(Ref ref) {
    final argument = this.argument as String;
    return link(ref, argument);
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

String _$linkHash() => r'a922c2e88737f79dd7bff933dc0ec716677e73cc';

final class LinkFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Link>>, String> {
  const LinkFamily._()
    : super(
        retry: null,
        name: r'linkProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  LinkProvider call(String id) => LinkProvider._(argument: id, from: this);

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

String _$seasonHash() => r'556495bf2dc783ad4f665957559fa5d3fa03bfbe';

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
