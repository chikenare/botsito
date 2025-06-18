// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'source_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$linkHash() => r'1eef25314964eeea6b2edb1e04e8301f11c72204';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [link].
@ProviderFor(link)
const linkProvider = LinkFamily();

/// See also [link].
class LinkFamily extends Family<AsyncValue<List<Link>>> {
  /// See also [link].
  const LinkFamily();

  /// See also [link].
  LinkProvider call(String id) {
    return LinkProvider(id);
  }

  @override
  LinkProvider getProviderOverride(covariant LinkProvider provider) {
    return call(provider.id);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'linkProvider';
}

/// See also [link].
class LinkProvider extends AutoDisposeFutureProvider<List<Link>> {
  /// See also [link].
  LinkProvider(String id)
    : this._internal(
        (ref) => link(ref as LinkRef, id),
        from: linkProvider,
        name: r'linkProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$linkHash,
        dependencies: LinkFamily._dependencies,
        allTransitiveDependencies: LinkFamily._allTransitiveDependencies,
        id: id,
      );

  LinkProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<List<Link>> Function(LinkRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LinkProvider._internal(
        (ref) => create(ref as LinkRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Link>> createElement() {
    return _LinkProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LinkProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin LinkRef on AutoDisposeFutureProviderRef<List<Link>> {
  /// The parameter `id` of this provider.
  String get id;
}

class _LinkProviderElement extends AutoDisposeFutureProviderElement<List<Link>>
    with LinkRef {
  _LinkProviderElement(super.provider);

  @override
  String get id => (origin as LinkProvider).id;
}

String _$seasonHash() => r'3f4f6627eec7ef9bba1d61f8aa8d87d54a3144ad';

/// See also [season].
@ProviderFor(season)
const seasonProvider = SeasonFamily();

/// See also [season].
class SeasonFamily extends Family<AsyncValue<List<Season>>> {
  /// See also [season].
  const SeasonFamily();

  /// See also [season].
  SeasonProvider call(String id) {
    return SeasonProvider(id);
  }

  @override
  SeasonProvider getProviderOverride(covariant SeasonProvider provider) {
    return call(provider.id);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'seasonProvider';
}

/// See also [season].
class SeasonProvider extends AutoDisposeFutureProvider<List<Season>> {
  /// See also [season].
  SeasonProvider(String id)
    : this._internal(
        (ref) => season(ref as SeasonRef, id),
        from: seasonProvider,
        name: r'seasonProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$seasonHash,
        dependencies: SeasonFamily._dependencies,
        allTransitiveDependencies: SeasonFamily._allTransitiveDependencies,
        id: id,
      );

  SeasonProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<List<Season>> Function(SeasonRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SeasonProvider._internal(
        (ref) => create(ref as SeasonRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Season>> createElement() {
    return _SeasonProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SeasonProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SeasonRef on AutoDisposeFutureProviderRef<List<Season>> {
  /// The parameter `id` of this provider.
  String get id;
}

class _SeasonProviderElement
    extends AutoDisposeFutureProviderElement<List<Season>>
    with SeasonRef {
  _SeasonProviderElement(super.provider);

  @override
  String get id => (origin as SeasonProvider).id;
}

String _$searchHash() => r'8fb9ff3155f7582040a7b2c7d3f2ab78254dc198';

/// See also [Search].
@ProviderFor(Search)
final searchProvider =
    AutoDisposeAsyncNotifierProvider<Search, List<Content>>.internal(
      Search.new,
      name: r'searchProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$searchHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$Search = AutoDisposeAsyncNotifier<List<Content>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
