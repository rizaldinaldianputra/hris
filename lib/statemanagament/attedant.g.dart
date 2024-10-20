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

String _$attedantListLogsHash() => r'28e88983df1cc93717e3e4194b5e6f56798c76bb';

abstract class _$AttedantListLogs
    extends BuildlessAutoDisposeAsyncNotifier<List<AttendanceListLogsModel>> {
  late final BuildContext context;

  FutureOr<List<AttendanceListLogsModel>> build(
    BuildContext context,
  );
}

/// See also [AttedantListLogs].
@ProviderFor(AttedantListLogs)
const attedantListLogsProvider = AttedantListLogsFamily();

/// See also [AttedantListLogs].
class AttedantListLogsFamily
    extends Family<AsyncValue<List<AttendanceListLogsModel>>> {
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
    AttedantListLogs, List<AttendanceListLogsModel>> {
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
  FutureOr<List<AttendanceListLogsModel>> runNotifierBuild(
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
      List<AttendanceListLogsModel>> createElement() {
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
    on AutoDisposeAsyncNotifierProviderRef<List<AttendanceListLogsModel>> {
  /// The parameter `context` of this provider.
  BuildContext get context;
}

class _AttedantListLogsProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<AttedantListLogs,
        List<AttendanceListLogsModel>> with AttedantListLogsRef {
  _AttedantListLogsProviderElement(super.provider);

  @override
  BuildContext get context => (origin as AttedantListLogsProvider).context;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
