// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'masterdropdown.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$masterDropdownListHash() =>
    r'c69ed98449dcb1c2e1d186d39628bc0776d78676';

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

abstract class _$MasterDropdownList
    extends BuildlessAutoDisposeAsyncNotifier<List<String>> {
  late final BuildContext context;
  late final String value;

  FutureOr<List<String>> build(
    BuildContext context,
    String value,
  );
}

/// See also [MasterDropdownList].
@ProviderFor(MasterDropdownList)
const masterDropdownListProvider = MasterDropdownListFamily();

/// See also [MasterDropdownList].
class MasterDropdownListFamily extends Family<AsyncValue<List<String>>> {
  /// See also [MasterDropdownList].
  const MasterDropdownListFamily();

  /// See also [MasterDropdownList].
  MasterDropdownListProvider call(
    BuildContext context,
    String value,
  ) {
    return MasterDropdownListProvider(
      context,
      value,
    );
  }

  @override
  MasterDropdownListProvider getProviderOverride(
    covariant MasterDropdownListProvider provider,
  ) {
    return call(
      provider.context,
      provider.value,
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
  String? get name => r'masterDropdownListProvider';
}

/// See also [MasterDropdownList].
class MasterDropdownListProvider extends AutoDisposeAsyncNotifierProviderImpl<
    MasterDropdownList, List<String>> {
  /// See also [MasterDropdownList].
  MasterDropdownListProvider(
    BuildContext context,
    String value,
  ) : this._internal(
          () => MasterDropdownList()
            ..context = context
            ..value = value,
          from: masterDropdownListProvider,
          name: r'masterDropdownListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$masterDropdownListHash,
          dependencies: MasterDropdownListFamily._dependencies,
          allTransitiveDependencies:
              MasterDropdownListFamily._allTransitiveDependencies,
          context: context,
          value: value,
        );

  MasterDropdownListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.context,
    required this.value,
  }) : super.internal();

  final BuildContext context;
  final String value;

  @override
  FutureOr<List<String>> runNotifierBuild(
    covariant MasterDropdownList notifier,
  ) {
    return notifier.build(
      context,
      value,
    );
  }

  @override
  Override overrideWith(MasterDropdownList Function() create) {
    return ProviderOverride(
      origin: this,
      override: MasterDropdownListProvider._internal(
        () => create()
          ..context = context
          ..value = value,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        context: context,
        value: value,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<MasterDropdownList, List<String>>
      createElement() {
    return _MasterDropdownListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MasterDropdownListProvider &&
        other.context == context &&
        other.value == value;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);
    hash = _SystemHash.combine(hash, value.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin MasterDropdownListRef
    on AutoDisposeAsyncNotifierProviderRef<List<String>> {
  /// The parameter `context` of this provider.
  BuildContext get context;

  /// The parameter `value` of this provider.
  String get value;
}

class _MasterDropdownListProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<MasterDropdownList,
        List<String>> with MasterDropdownListRef {
  _MasterDropdownListProviderElement(super.provider);

  @override
  BuildContext get context => (origin as MasterDropdownListProvider).context;
  @override
  String get value => (origin as MasterDropdownListProvider).value;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
