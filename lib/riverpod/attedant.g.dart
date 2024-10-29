// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attedant.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$attedantSumamryHash() => r'f8f4109ba4156d0ee6c301ce4a905a0760864f1d';

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

abstract class _$AttedantSumamry
    extends BuildlessAutoDisposeAsyncNotifier<AttedanceSummaryModel> {
  late final BuildContext context;

  FutureOr<AttedanceSummaryModel> build(
    BuildContext context,
  );
}

/// See also [AttedantSumamry].
@ProviderFor(AttedantSumamry)
const attedantSumamryProvider = AttedantSumamryFamily();

/// See also [AttedantSumamry].
class AttedantSumamryFamily extends Family<AsyncValue<AttedanceSummaryModel>> {
  /// See also [AttedantSumamry].
  const AttedantSumamryFamily();

  /// See also [AttedantSumamry].
  AttedantSumamryProvider call(
    BuildContext context,
  ) {
    return AttedantSumamryProvider(
      context,
    );
  }

  @override
  AttedantSumamryProvider getProviderOverride(
    covariant AttedantSumamryProvider provider,
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
  String? get name => r'attedantSumamryProvider';
}

/// See also [AttedantSumamry].
class AttedantSumamryProvider extends AutoDisposeAsyncNotifierProviderImpl<
    AttedantSumamry, AttedanceSummaryModel> {
  /// See also [AttedantSumamry].
  AttedantSumamryProvider(
    BuildContext context,
  ) : this._internal(
          () => AttedantSumamry()..context = context,
          from: attedantSumamryProvider,
          name: r'attedantSumamryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$attedantSumamryHash,
          dependencies: AttedantSumamryFamily._dependencies,
          allTransitiveDependencies:
              AttedantSumamryFamily._allTransitiveDependencies,
          context: context,
        );

  AttedantSumamryProvider._internal(
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
  FutureOr<AttedanceSummaryModel> runNotifierBuild(
    covariant AttedantSumamry notifier,
  ) {
    return notifier.build(
      context,
    );
  }

  @override
  Override overrideWith(AttedantSumamry Function() create) {
    return ProviderOverride(
      origin: this,
      override: AttedantSumamryProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<AttedantSumamry,
      AttedanceSummaryModel> createElement() {
    return _AttedantSumamryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AttedantSumamryProvider && other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AttedantSumamryRef
    on AutoDisposeAsyncNotifierProviderRef<AttedanceSummaryModel> {
  /// The parameter `context` of this provider.
  BuildContext get context;
}

class _AttedantSumamryProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<AttedantSumamry,
        AttedanceSummaryModel> with AttedantSumamryRef {
  _AttedantSumamryProviderElement(super.provider);

  @override
  BuildContext get context => (origin as AttedantSumamryProvider).context;
}

String _$attedantListLogsHash() => r'a5c0dbd3d4779baf5ddbd5ef9b3cd1b373b14bd9';

abstract class _$AttedantListLogs
    extends BuildlessAutoDisposeAsyncNotifier<List<AttendanceModel>> {
  late final BuildContext context;

  FutureOr<List<AttendanceModel>> build(
    BuildContext context,
  );
}

/// See also [AttedantListLogs].
@ProviderFor(AttedantListLogs)
const attedantListLogsProvider = AttedantListLogsFamily();

/// See also [AttedantListLogs].
class AttedantListLogsFamily extends Family<AsyncValue<List<AttendanceModel>>> {
  /// See also [AttedantListLogs].
  const AttedantListLogsFamily();

  /// See also [AttedantListLogs].
  AttedantListLogsProvider call(
    BuildContext context,
  ) {
    return AttedantListLogsProvider(
      context,
    );
  }

  @override
  AttedantListLogsProvider getProviderOverride(
    covariant AttedantListLogsProvider provider,
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
  String? get name => r'attedantListLogsProvider';
}

/// See also [AttedantListLogs].
class AttedantListLogsProvider extends AutoDisposeAsyncNotifierProviderImpl<
    AttedantListLogs, List<AttendanceModel>> {
  /// See also [AttedantListLogs].
  AttedantListLogsProvider(
    BuildContext context,
  ) : this._internal(
          () => AttedantListLogs()..context = context,
          from: attedantListLogsProvider,
          name: r'attedantListLogsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$attedantListLogsHash,
          dependencies: AttedantListLogsFamily._dependencies,
          allTransitiveDependencies:
              AttedantListLogsFamily._allTransitiveDependencies,
          context: context,
        );

  AttedantListLogsProvider._internal(
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
  FutureOr<List<AttendanceModel>> runNotifierBuild(
    covariant AttedantListLogs notifier,
  ) {
    return notifier.build(
      context,
    );
  }

  @override
  Override overrideWith(AttedantListLogs Function() create) {
    return ProviderOverride(
      origin: this,
      override: AttedantListLogsProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<AttedantListLogs,
      List<AttendanceModel>> createElement() {
    return _AttedantListLogsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AttedantListLogsProvider && other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AttedantListLogsRef
    on AutoDisposeAsyncNotifierProviderRef<List<AttendanceModel>> {
  /// The parameter `context` of this provider.
  BuildContext get context;
}

class _AttedantListLogsProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<AttedantListLogs,
        List<AttendanceModel>> with AttedantListLogsRef {
  _AttedantListLogsProviderElement(super.provider);

  @override
  BuildContext get context => (origin as AttedantListLogsProvider).context;
}

String _$attendanceLogPaginationNotifierHash() =>
    r'34ac29353a95e54f90a00f5dfd3305d190cca36f';

/// See also [AttendanceLogPaginationNotifier].
@ProviderFor(AttendanceLogPaginationNotifier)
final attendanceLogPaginationNotifierProvider =
    AutoDisposeAsyncNotifierProvider<AttendanceLogPaginationNotifier,
        void>.internal(
  AttendanceLogPaginationNotifier.new,
  name: r'attendanceLogPaginationNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$attendanceLogPaginationNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AttendanceLogPaginationNotifier = AutoDisposeAsyncNotifier<void>;
String _$attedanceStatusHash() => r'519f9927ec5dc70d247c70798da63e5fb4dbba27';

abstract class _$AttedanceStatus
    extends BuildlessAutoDisposeAsyncNotifier<AttendanceModel?> {
  late final BuildContext context;

  FutureOr<AttendanceModel?> build(
    BuildContext context,
  );
}

/// See also [AttedanceStatus].
@ProviderFor(AttedanceStatus)
const attedanceStatusProvider = AttedanceStatusFamily();

/// See also [AttedanceStatus].
class AttedanceStatusFamily extends Family<AsyncValue<AttendanceModel?>> {
  /// See also [AttedanceStatus].
  const AttedanceStatusFamily();

  /// See also [AttedanceStatus].
  AttedanceStatusProvider call(
    BuildContext context,
  ) {
    return AttedanceStatusProvider(
      context,
    );
  }

  @override
  AttedanceStatusProvider getProviderOverride(
    covariant AttedanceStatusProvider provider,
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
  String? get name => r'attedanceStatusProvider';
}

/// See also [AttedanceStatus].
class AttedanceStatusProvider extends AutoDisposeAsyncNotifierProviderImpl<
    AttedanceStatus, AttendanceModel?> {
  /// See also [AttedanceStatus].
  AttedanceStatusProvider(
    BuildContext context,
  ) : this._internal(
          () => AttedanceStatus()..context = context,
          from: attedanceStatusProvider,
          name: r'attedanceStatusProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$attedanceStatusHash,
          dependencies: AttedanceStatusFamily._dependencies,
          allTransitiveDependencies:
              AttedanceStatusFamily._allTransitiveDependencies,
          context: context,
        );

  AttedanceStatusProvider._internal(
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
  FutureOr<AttendanceModel?> runNotifierBuild(
    covariant AttedanceStatus notifier,
  ) {
    return notifier.build(
      context,
    );
  }

  @override
  Override overrideWith(AttedanceStatus Function() create) {
    return ProviderOverride(
      origin: this,
      override: AttedanceStatusProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<AttedanceStatus, AttendanceModel?>
      createElement() {
    return _AttedanceStatusProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AttedanceStatusProvider && other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AttedanceStatusRef
    on AutoDisposeAsyncNotifierProviderRef<AttendanceModel?> {
  /// The parameter `context` of this provider.
  BuildContext get context;
}

class _AttedanceStatusProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<AttedanceStatus,
        AttendanceModel?> with AttedanceStatusRef {
  _AttedanceStatusProviderElement(super.provider);

  @override
  BuildContext get context => (origin as AttedanceStatusProvider).context;
}

String _$attedantSaveHash() => r'01dc7de7ac6d37ebbd7d3d637597c0d6355883cc';

abstract class _$AttedantSave
    extends BuildlessAutoDisposeAsyncNotifier<Response?> {
  late final BuildContext context;

  FutureOr<Response?> build(
    BuildContext context,
  );
}

/// See also [AttedantSave].
@ProviderFor(AttedantSave)
const attedantSaveProvider = AttedantSaveFamily();

/// See also [AttedantSave].
class AttedantSaveFamily extends Family<AsyncValue<Response?>> {
  /// See also [AttedantSave].
  const AttedantSaveFamily();

  /// See also [AttedantSave].
  AttedantSaveProvider call(
    BuildContext context,
  ) {
    return AttedantSaveProvider(
      context,
    );
  }

  @override
  AttedantSaveProvider getProviderOverride(
    covariant AttedantSaveProvider provider,
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
  String? get name => r'attedantSaveProvider';
}

/// See also [AttedantSave].
class AttedantSaveProvider
    extends AutoDisposeAsyncNotifierProviderImpl<AttedantSave, Response?> {
  /// See also [AttedantSave].
  AttedantSaveProvider(
    BuildContext context,
  ) : this._internal(
          () => AttedantSave()..context = context,
          from: attedantSaveProvider,
          name: r'attedantSaveProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$attedantSaveHash,
          dependencies: AttedantSaveFamily._dependencies,
          allTransitiveDependencies:
              AttedantSaveFamily._allTransitiveDependencies,
          context: context,
        );

  AttedantSaveProvider._internal(
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
    covariant AttedantSave notifier,
  ) {
    return notifier.build(
      context,
    );
  }

  @override
  Override overrideWith(AttedantSave Function() create) {
    return ProviderOverride(
      origin: this,
      override: AttedantSaveProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<AttedantSave, Response?>
      createElement() {
    return _AttedantSaveProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AttedantSaveProvider && other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AttedantSaveRef on AutoDisposeAsyncNotifierProviderRef<Response?> {
  /// The parameter `context` of this provider.
  BuildContext get context;
}

class _AttedantSaveProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<AttedantSave, Response?>
    with AttedantSaveRef {
  _AttedantSaveProviderElement(super.provider);

  @override
  BuildContext get context => (origin as AttedantSaveProvider).context;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
