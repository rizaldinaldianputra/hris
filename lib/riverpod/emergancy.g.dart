// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emergancy.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$emergancyListViewHash() => r'92c1f5ee88d9d1bb5ef59474082b639347a4dcd8';

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

abstract class _$EmergancyListView
    extends BuildlessAutoDisposeAsyncNotifier<List<EmergencyModel>> {
  late final BuildContext context;

  FutureOr<List<EmergencyModel>> build(
    BuildContext context,
  );
}

/// See also [EmergancyListView].
@ProviderFor(EmergancyListView)
const emergancyListViewProvider = EmergancyListViewFamily();

/// See also [EmergancyListView].
class EmergancyListViewFamily extends Family<AsyncValue<List<EmergencyModel>>> {
  /// See also [EmergancyListView].
  const EmergancyListViewFamily();

  /// See also [EmergancyListView].
  EmergancyListViewProvider call(
    BuildContext context,
  ) {
    return EmergancyListViewProvider(
      context,
    );
  }

  @override
  EmergancyListViewProvider getProviderOverride(
    covariant EmergancyListViewProvider provider,
  ) {
    return call(
      provider.context,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'emergancyListViewProvider';
}

/// See also [EmergancyListView].
class EmergancyListViewProvider extends AutoDisposeAsyncNotifierProviderImpl<
    EmergancyListView, List<EmergencyModel>> {
  /// See also [EmergancyListView].
  EmergancyListViewProvider(
    BuildContext context,
  ) : this._internal(
          () => EmergancyListView()..context = context,
          from: emergancyListViewProvider,
          name: r'emergancyListViewProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$emergancyListViewHash,
          dependencies: EmergancyListViewFamily._dependencies,
          allTransitiveDependencies:
              EmergancyListViewFamily._allTransitiveDependencies,
          context: context,
        );

  EmergancyListViewProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.context,
  }) : super.internal();

  final BuildContext context;

  @override
  FutureOr<List<EmergencyModel>> runNotifierBuild(
    covariant EmergancyListView notifier,
  ) {
    return notifier.build(
      context,
    );
  }

  @override
  Override overrideWith(EmergancyListView Function() create) {
    return ProviderOverride(
      origin: this,
      override: EmergancyListViewProvider._internal(
        () => create()..context = context,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        context: context,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<EmergancyListView,
      List<EmergencyModel>> createElement() {
    return _EmergancyListViewProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EmergancyListViewProvider && other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin EmergancyListViewRef
    on AutoDisposeAsyncNotifierProviderRef<List<EmergencyModel>> {
  /// The parameter `context` of this provider.
  BuildContext get context;
}

class _EmergancyListViewProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<EmergancyListView,
        List<EmergencyModel>> with EmergancyListViewRef {
  _EmergancyListViewProviderElement(super.provider);

  @override
  BuildContext get context => (origin as EmergancyListViewProvider).context;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
