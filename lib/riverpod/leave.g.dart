// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$leaveListHash() => r'527bca7d6edc5574a7866cbe5bca02f68e076280';

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

abstract class _$LeaveList
    extends BuildlessAutoDisposeNotifier<PagingController<int, LeaveModel>> {
  late final BuildContext context;

  PagingController<int, LeaveModel> build(
    BuildContext context,
  );
}

/// See also [LeaveList].
@ProviderFor(LeaveList)
const leaveListProvider = LeaveListFamily();

/// See also [LeaveList].
class LeaveListFamily extends Family<PagingController<int, LeaveModel>> {
  /// See also [LeaveList].
  const LeaveListFamily();

  /// See also [LeaveList].
  LeaveListProvider call(
    BuildContext context,
  ) {
    return LeaveListProvider(
      context,
    );
  }

  @override
  LeaveListProvider getProviderOverride(
    covariant LeaveListProvider provider,
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
  String? get name => r'leaveListProvider';
}

/// See also [LeaveList].
class LeaveListProvider extends AutoDisposeNotifierProviderImpl<LeaveList,
    PagingController<int, LeaveModel>> {
  /// See also [LeaveList].
  LeaveListProvider(
    BuildContext context,
  ) : this._internal(
          () => LeaveList()..context = context,
          from: leaveListProvider,
          name: r'leaveListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$leaveListHash,
          dependencies: LeaveListFamily._dependencies,
          allTransitiveDependencies: LeaveListFamily._allTransitiveDependencies,
          context: context,
        );

  LeaveListProvider._internal(
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
  PagingController<int, LeaveModel> runNotifierBuild(
    covariant LeaveList notifier,
  ) {
    return notifier.build(
      context,
    );
  }

  @override
  Override overrideWith(LeaveList Function() create) {
    return ProviderOverride(
      origin: this,
      override: LeaveListProvider._internal(
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
  AutoDisposeNotifierProviderElement<LeaveList,
      PagingController<int, LeaveModel>> createElement() {
    return _LeaveListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LeaveListProvider && other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin LeaveListRef
    on AutoDisposeNotifierProviderRef<PagingController<int, LeaveModel>> {
  /// The parameter `context` of this provider.
  BuildContext get context;
}

class _LeaveListProviderElement extends AutoDisposeNotifierProviderElement<
    LeaveList, PagingController<int, LeaveModel>> with LeaveListRef {
  _LeaveListProviderElement(super.provider);

  @override
  BuildContext get context => (origin as LeaveListProvider).context;
}

String _$leaveListViewHash() => r'267e225a052967b0370d8cc63cba60888a3b7034';

abstract class _$LeaveListView
    extends BuildlessAutoDisposeAsyncNotifier<List<LeaveModel>> {
  late final BuildContext context;

  FutureOr<List<LeaveModel>> build(
    BuildContext context,
  );
}

/// See also [LeaveListView].
@ProviderFor(LeaveListView)
const leaveListViewProvider = LeaveListViewFamily();

/// See also [LeaveListView].
class LeaveListViewFamily extends Family<AsyncValue<List<LeaveModel>>> {
  /// See also [LeaveListView].
  const LeaveListViewFamily();

  /// See also [LeaveListView].
  LeaveListViewProvider call(
    BuildContext context,
  ) {
    return LeaveListViewProvider(
      context,
    );
  }

  @override
  LeaveListViewProvider getProviderOverride(
    covariant LeaveListViewProvider provider,
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
  String? get name => r'leaveListViewProvider';
}

/// See also [LeaveListView].
class LeaveListViewProvider extends AutoDisposeAsyncNotifierProviderImpl<
    LeaveListView, List<LeaveModel>> {
  /// See also [LeaveListView].
  LeaveListViewProvider(
    BuildContext context,
  ) : this._internal(
          () => LeaveListView()..context = context,
          from: leaveListViewProvider,
          name: r'leaveListViewProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$leaveListViewHash,
          dependencies: LeaveListViewFamily._dependencies,
          allTransitiveDependencies:
              LeaveListViewFamily._allTransitiveDependencies,
          context: context,
        );

  LeaveListViewProvider._internal(
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
  FutureOr<List<LeaveModel>> runNotifierBuild(
    covariant LeaveListView notifier,
  ) {
    return notifier.build(
      context,
    );
  }

  @override
  Override overrideWith(LeaveListView Function() create) {
    return ProviderOverride(
      origin: this,
      override: LeaveListViewProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<LeaveListView, List<LeaveModel>>
      createElement() {
    return _LeaveListViewProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LeaveListViewProvider && other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin LeaveListViewRef
    on AutoDisposeAsyncNotifierProviderRef<List<LeaveModel>> {
  /// The parameter `context` of this provider.
  BuildContext get context;
}

class _LeaveListViewProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<LeaveListView,
        List<LeaveModel>> with LeaveListViewRef {
  _LeaveListViewProviderElement(super.provider);

  @override
  BuildContext get context => (origin as LeaveListViewProvider).context;
}

String _$leaveTypeHash() => r'd16aea06b071df624b7c14f20cfcefeb57bee1a8';

abstract class _$LeaveType
    extends BuildlessAutoDisposeAsyncNotifier<List<DropdownModel>> {
  late final BuildContext context;
  late final String value;

  FutureOr<List<DropdownModel>> build(
    BuildContext context,
    String value,
  );
}

/// See also [LeaveType].
@ProviderFor(LeaveType)
const leaveTypeProvider = LeaveTypeFamily();

/// See also [LeaveType].
class LeaveTypeFamily extends Family<AsyncValue<List<DropdownModel>>> {
  /// See also [LeaveType].
  const LeaveTypeFamily();

  /// See also [LeaveType].
  LeaveTypeProvider call(
    BuildContext context,
    String value,
  ) {
    return LeaveTypeProvider(
      context,
      value,
    );
  }

  @override
  LeaveTypeProvider getProviderOverride(
    covariant LeaveTypeProvider provider,
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
  String? get name => r'leaveTypeProvider';
}

/// See also [LeaveType].
class LeaveTypeProvider extends AutoDisposeAsyncNotifierProviderImpl<LeaveType,
    List<DropdownModel>> {
  /// See also [LeaveType].
  LeaveTypeProvider(
    BuildContext context,
    String value,
  ) : this._internal(
          () => LeaveType()
            ..context = context
            ..value = value,
          from: leaveTypeProvider,
          name: r'leaveTypeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$leaveTypeHash,
          dependencies: LeaveTypeFamily._dependencies,
          allTransitiveDependencies: LeaveTypeFamily._allTransitiveDependencies,
          context: context,
          value: value,
        );

  LeaveTypeProvider._internal(
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
    covariant LeaveType notifier,
  ) {
    return notifier.build(
      context,
      value,
    );
  }

  @override
  Override overrideWith(LeaveType Function() create) {
    return ProviderOverride(
      origin: this,
      override: LeaveTypeProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<LeaveType, List<DropdownModel>>
      createElement() {
    return _LeaveTypeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LeaveTypeProvider &&
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

mixin LeaveTypeRef on AutoDisposeAsyncNotifierProviderRef<List<DropdownModel>> {
  /// The parameter `context` of this provider.
  BuildContext get context;

  /// The parameter `value` of this provider.
  String get value;
}

class _LeaveTypeProviderElement extends AutoDisposeAsyncNotifierProviderElement<
    LeaveType, List<DropdownModel>> with LeaveTypeRef {
  _LeaveTypeProviderElement(super.provider);

  @override
  BuildContext get context => (origin as LeaveTypeProvider).context;
  @override
  String get value => (origin as LeaveTypeProvider).value;
}

String _$leaveSaveDataHash() => r'c34bd774792cff30d654be1f86a27df242bb07dd';

abstract class _$LeaveSaveData
    extends BuildlessAutoDisposeAsyncNotifier<Response?> {
  late final BuildContext context;

  FutureOr<Response?> build(
    BuildContext context,
  );
}

/// See also [LeaveSaveData].
@ProviderFor(LeaveSaveData)
const leaveSaveDataProvider = LeaveSaveDataFamily();

/// See also [LeaveSaveData].
class LeaveSaveDataFamily extends Family<AsyncValue<Response?>> {
  /// See also [LeaveSaveData].
  const LeaveSaveDataFamily();

  /// See also [LeaveSaveData].
  LeaveSaveDataProvider call(
    BuildContext context,
  ) {
    return LeaveSaveDataProvider(
      context,
    );
  }

  @override
  LeaveSaveDataProvider getProviderOverride(
    covariant LeaveSaveDataProvider provider,
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
  String? get name => r'leaveSaveDataProvider';
}

/// See also [LeaveSaveData].
class LeaveSaveDataProvider
    extends AutoDisposeAsyncNotifierProviderImpl<LeaveSaveData, Response?> {
  /// See also [LeaveSaveData].
  LeaveSaveDataProvider(
    BuildContext context,
  ) : this._internal(
          () => LeaveSaveData()..context = context,
          from: leaveSaveDataProvider,
          name: r'leaveSaveDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$leaveSaveDataHash,
          dependencies: LeaveSaveDataFamily._dependencies,
          allTransitiveDependencies:
              LeaveSaveDataFamily._allTransitiveDependencies,
          context: context,
        );

  LeaveSaveDataProvider._internal(
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
    covariant LeaveSaveData notifier,
  ) {
    return notifier.build(
      context,
    );
  }

  @override
  Override overrideWith(LeaveSaveData Function() create) {
    return ProviderOverride(
      origin: this,
      override: LeaveSaveDataProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<LeaveSaveData, Response?>
      createElement() {
    return _LeaveSaveDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LeaveSaveDataProvider && other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin LeaveSaveDataRef on AutoDisposeAsyncNotifierProviderRef<Response?> {
  /// The parameter `context` of this provider.
  BuildContext get context;
}

class _LeaveSaveDataProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<LeaveSaveData, Response?>
    with LeaveSaveDataRef {
  _LeaveSaveDataProviderElement(super.provider);

  @override
  BuildContext get context => (origin as LeaveSaveDataProvider).context;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
