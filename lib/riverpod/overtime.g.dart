// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'overtime.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$overtimePendingHash() => r'17f638af87e936add8646674d85e74dcb13cd71b';

/// See also [OvertimePending].
@ProviderFor(OvertimePending)
final overtimePendingProvider =
    AutoDisposeAsyncNotifierProvider<OvertimePending, void>.internal(
  OvertimePending.new,
  name: r'overtimePendingProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$overtimePendingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$OvertimePending = AutoDisposeAsyncNotifier<void>;
String _$overtimeApprovedHash() => r'6d4b380dd38ce4301bb867ace845edce9c9f2773';

/// See also [OvertimeApproved].
@ProviderFor(OvertimeApproved)
final overtimeApprovedProvider =
    AutoDisposeAsyncNotifierProvider<OvertimeApproved, void>.internal(
  OvertimeApproved.new,
  name: r'overtimeApprovedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$overtimeApprovedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$OvertimeApproved = AutoDisposeAsyncNotifier<void>;
String _$overtimeListViewHash() => r'fdd52f3f171e5e56bd579f3b35d0ec05476fb134';

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

abstract class _$OvertimeListView
    extends BuildlessAutoDisposeAsyncNotifier<List<Overtime>> {
  late final BuildContext context;

  FutureOr<List<Overtime>> build(
    BuildContext context,
  );
}

/// See also [OvertimeListView].
@ProviderFor(OvertimeListView)
const overtimeListViewProvider = OvertimeListViewFamily();

/// See also [OvertimeListView].
class OvertimeListViewFamily extends Family<AsyncValue<List<Overtime>>> {
  /// See also [OvertimeListView].
  const OvertimeListViewFamily();

  /// See also [OvertimeListView].
  OvertimeListViewProvider call(
    BuildContext context,
  ) {
    return OvertimeListViewProvider(
      context,
    );
  }

  @override
  OvertimeListViewProvider getProviderOverride(
    covariant OvertimeListViewProvider provider,
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
  String? get name => r'overtimeListViewProvider';
}

/// See also [OvertimeListView].
class OvertimeListViewProvider extends AutoDisposeAsyncNotifierProviderImpl<
    OvertimeListView, List<Overtime>> {
  /// See also [OvertimeListView].
  OvertimeListViewProvider(
    BuildContext context,
  ) : this._internal(
          () => OvertimeListView()..context = context,
          from: overtimeListViewProvider,
          name: r'overtimeListViewProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$overtimeListViewHash,
          dependencies: OvertimeListViewFamily._dependencies,
          allTransitiveDependencies:
              OvertimeListViewFamily._allTransitiveDependencies,
          context: context,
        );

  OvertimeListViewProvider._internal(
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
  FutureOr<List<Overtime>> runNotifierBuild(
    covariant OvertimeListView notifier,
  ) {
    return notifier.build(
      context,
    );
  }

  @override
  Override overrideWith(OvertimeListView Function() create) {
    return ProviderOverride(
      origin: this,
      override: OvertimeListViewProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<OvertimeListView, List<Overtime>>
      createElement() {
    return _OvertimeListViewProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OvertimeListViewProvider && other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin OvertimeListViewRef
    on AutoDisposeAsyncNotifierProviderRef<List<Overtime>> {
  /// The parameter `context` of this provider.
  BuildContext get context;
}

class _OvertimeListViewProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<OvertimeListView,
        List<Overtime>> with OvertimeListViewRef {
  _OvertimeListViewProviderElement(super.provider);

  @override
  BuildContext get context => (origin as OvertimeListViewProvider).context;
}

String _$overtimeTypeHash() => r'bb445bc4945ca4781a6e86284acfd82671071da7';

abstract class _$OvertimeType
    extends BuildlessAutoDisposeAsyncNotifier<List<DropdownModel>> {
  late final BuildContext context;
  late final String value;

  FutureOr<List<DropdownModel>> build(
    BuildContext context,
    String value,
  );
}

/// See also [OvertimeType].
@ProviderFor(OvertimeType)
const overtimeTypeProvider = OvertimeTypeFamily();

/// See also [OvertimeType].
class OvertimeTypeFamily extends Family<AsyncValue<List<DropdownModel>>> {
  /// See also [OvertimeType].
  const OvertimeTypeFamily();

  /// See also [OvertimeType].
  OvertimeTypeProvider call(
    BuildContext context,
    String value,
  ) {
    return OvertimeTypeProvider(
      context,
      value,
    );
  }

  @override
  OvertimeTypeProvider getProviderOverride(
    covariant OvertimeTypeProvider provider,
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
  String? get name => r'overtimeTypeProvider';
}

/// See also [OvertimeType].
class OvertimeTypeProvider extends AutoDisposeAsyncNotifierProviderImpl<
    OvertimeType, List<DropdownModel>> {
  /// See also [OvertimeType].
  OvertimeTypeProvider(
    BuildContext context,
    String value,
  ) : this._internal(
          () => OvertimeType()
            ..context = context
            ..value = value,
          from: overtimeTypeProvider,
          name: r'overtimeTypeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$overtimeTypeHash,
          dependencies: OvertimeTypeFamily._dependencies,
          allTransitiveDependencies:
              OvertimeTypeFamily._allTransitiveDependencies,
          context: context,
          value: value,
        );

  OvertimeTypeProvider._internal(
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
  FutureOr<List<DropdownModel>> runNotifierBuild(
    covariant OvertimeType notifier,
  ) {
    return notifier.build(
      context,
      value,
    );
  }

  @override
  Override overrideWith(OvertimeType Function() create) {
    return ProviderOverride(
      origin: this,
      override: OvertimeTypeProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<OvertimeType, List<DropdownModel>>
      createElement() {
    return _OvertimeTypeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OvertimeTypeProvider &&
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

mixin OvertimeTypeRef
    on AutoDisposeAsyncNotifierProviderRef<List<DropdownModel>> {
  /// The parameter `context` of this provider.
  BuildContext get context;

  /// The parameter `value` of this provider.
  String get value;
}

class _OvertimeTypeProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<OvertimeType,
        List<DropdownModel>> with OvertimeTypeRef {
  _OvertimeTypeProviderElement(super.provider);

  @override
  BuildContext get context => (origin as OvertimeTypeProvider).context;
  @override
  String get value => (origin as OvertimeTypeProvider).value;
}

String _$overtimeSaveDataHash() => r'8c8744a4891c9f87a091ffcef89b97b489095b8f';

abstract class _$OvertimeSaveData
    extends BuildlessAutoDisposeAsyncNotifier<Response?> {
  late final BuildContext context;

  FutureOr<Response?> build(
    BuildContext context,
  );
}

/// See also [OvertimeSaveData].
@ProviderFor(OvertimeSaveData)
const overtimeSaveDataProvider = OvertimeSaveDataFamily();

/// See also [OvertimeSaveData].
class OvertimeSaveDataFamily extends Family<AsyncValue<Response?>> {
  /// See also [OvertimeSaveData].
  const OvertimeSaveDataFamily();

  /// See also [OvertimeSaveData].
  OvertimeSaveDataProvider call(
    BuildContext context,
  ) {
    return OvertimeSaveDataProvider(
      context,
    );
  }

  @override
  OvertimeSaveDataProvider getProviderOverride(
    covariant OvertimeSaveDataProvider provider,
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
  String? get name => r'overtimeSaveDataProvider';
}

/// See also [OvertimeSaveData].
class OvertimeSaveDataProvider
    extends AutoDisposeAsyncNotifierProviderImpl<OvertimeSaveData, Response?> {
  /// See also [OvertimeSaveData].
  OvertimeSaveDataProvider(
    BuildContext context,
  ) : this._internal(
          () => OvertimeSaveData()..context = context,
          from: overtimeSaveDataProvider,
          name: r'overtimeSaveDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$overtimeSaveDataHash,
          dependencies: OvertimeSaveDataFamily._dependencies,
          allTransitiveDependencies:
              OvertimeSaveDataFamily._allTransitiveDependencies,
          context: context,
        );

  OvertimeSaveDataProvider._internal(
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
  FutureOr<Response?> runNotifierBuild(
    covariant OvertimeSaveData notifier,
  ) {
    return notifier.build(
      context,
    );
  }

  @override
  Override overrideWith(OvertimeSaveData Function() create) {
    return ProviderOverride(
      origin: this,
      override: OvertimeSaveDataProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<OvertimeSaveData, Response?>
      createElement() {
    return _OvertimeSaveDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OvertimeSaveDataProvider && other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin OvertimeSaveDataRef on AutoDisposeAsyncNotifierProviderRef<Response?> {
  /// The parameter `context` of this provider.
  BuildContext get context;
}

class _OvertimeSaveDataProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<OvertimeSaveData, Response?>
    with OvertimeSaveDataRef {
  _OvertimeSaveDataProviderElement(super.provider);

  @override
  BuildContext get context => (origin as OvertimeSaveDataProvider).context;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
