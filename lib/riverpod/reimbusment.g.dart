// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reimbusment.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$reimbursementExpenseNotifierHash() =>
    r'39848e62cffa9cebca436d20b578b012b5fdc65d';

/// See also [ReimbursementExpenseNotifier].
@ProviderFor(ReimbursementExpenseNotifier)
final reimbursementExpenseNotifierProvider = AutoDisposeNotifierProvider<
    ReimbursementExpenseNotifier, List<ExpensesModel>>.internal(
  ReimbursementExpenseNotifier.new,
  name: r'reimbursementExpenseNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$reimbursementExpenseNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ReimbursementExpenseNotifier
    = AutoDisposeNotifier<List<ExpensesModel>>;
String _$expenseListHash() => r'f76a0e310fdfab83fbf9dd82ad8d46556b73b957';

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

abstract class _$ExpenseList
    extends BuildlessAutoDisposeAsyncNotifier<List<DropdownModel>> {
  late final BuildContext context;

  FutureOr<List<DropdownModel>> build(
    BuildContext context,
  );
}

/// See also [ExpenseList].
@ProviderFor(ExpenseList)
const expenseListProvider = ExpenseListFamily();

/// See also [ExpenseList].
class ExpenseListFamily extends Family<AsyncValue<List<DropdownModel>>> {
  /// See also [ExpenseList].
  const ExpenseListFamily();

  /// See also [ExpenseList].
  ExpenseListProvider call(
    BuildContext context,
  ) {
    return ExpenseListProvider(
      context,
    );
  }

  @override
  ExpenseListProvider getProviderOverride(
    covariant ExpenseListProvider provider,
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
  String? get name => r'expenseListProvider';
}

/// See also [ExpenseList].
class ExpenseListProvider extends AutoDisposeAsyncNotifierProviderImpl<
    ExpenseList, List<DropdownModel>> {
  /// See also [ExpenseList].
  ExpenseListProvider(
    BuildContext context,
  ) : this._internal(
          () => ExpenseList()..context = context,
          from: expenseListProvider,
          name: r'expenseListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$expenseListHash,
          dependencies: ExpenseListFamily._dependencies,
          allTransitiveDependencies:
              ExpenseListFamily._allTransitiveDependencies,
          context: context,
        );

  ExpenseListProvider._internal(
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
  FutureOr<List<DropdownModel>> runNotifierBuild(
    covariant ExpenseList notifier,
  ) {
    return notifier.build(
      context,
    );
  }

  @override
  Override overrideWith(ExpenseList Function() create) {
    return ProviderOverride(
      origin: this,
      override: ExpenseListProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<ExpenseList, List<DropdownModel>>
      createElement() {
    return _ExpenseListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ExpenseListProvider && other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ExpenseListRef
    on AutoDisposeAsyncNotifierProviderRef<List<DropdownModel>> {
  /// The parameter `context` of this provider.
  BuildContext get context;
}

class _ExpenseListProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ExpenseList,
        List<DropdownModel>> with ExpenseListRef {
  _ExpenseListProviderElement(super.provider);

  @override
  BuildContext get context => (origin as ExpenseListProvider).context;
}

String _$reimbusmentTypeHash() => r'50e2747f947218d3177f08ab13c375503086cd4a';

abstract class _$ReimbusmentType
    extends BuildlessAutoDisposeAsyncNotifier<List<DropdownModel>> {
  late final BuildContext context;
  late final String value;

  FutureOr<List<DropdownModel>> build(
    BuildContext context,
    String value,
  );
}

/// See also [ReimbusmentType].
@ProviderFor(ReimbusmentType)
const reimbusmentTypeProvider = ReimbusmentTypeFamily();

/// See also [ReimbusmentType].
class ReimbusmentTypeFamily extends Family<AsyncValue<List<DropdownModel>>> {
  /// See also [ReimbusmentType].
  const ReimbusmentTypeFamily();

  /// See also [ReimbusmentType].
  ReimbusmentTypeProvider call(
    BuildContext context,
    String value,
  ) {
    return ReimbusmentTypeProvider(
      context,
      value,
    );
  }

  @override
  ReimbusmentTypeProvider getProviderOverride(
    covariant ReimbusmentTypeProvider provider,
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
  String? get name => r'reimbusmentTypeProvider';
}

/// See also [ReimbusmentType].
class ReimbusmentTypeProvider extends AutoDisposeAsyncNotifierProviderImpl<
    ReimbusmentType, List<DropdownModel>> {
  /// See also [ReimbusmentType].
  ReimbusmentTypeProvider(
    BuildContext context,
    String value,
  ) : this._internal(
          () => ReimbusmentType()
            ..context = context
            ..value = value,
          from: reimbusmentTypeProvider,
          name: r'reimbusmentTypeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$reimbusmentTypeHash,
          dependencies: ReimbusmentTypeFamily._dependencies,
          allTransitiveDependencies:
              ReimbusmentTypeFamily._allTransitiveDependencies,
          context: context,
          value: value,
        );

  ReimbusmentTypeProvider._internal(
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
    covariant ReimbusmentType notifier,
  ) {
    return notifier.build(
      context,
      value,
    );
  }

  @override
  Override overrideWith(ReimbusmentType Function() create) {
    return ProviderOverride(
      origin: this,
      override: ReimbusmentTypeProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<ReimbusmentType, List<DropdownModel>>
      createElement() {
    return _ReimbusmentTypeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ReimbusmentTypeProvider &&
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

mixin ReimbusmentTypeRef
    on AutoDisposeAsyncNotifierProviderRef<List<DropdownModel>> {
  /// The parameter `context` of this provider.
  BuildContext get context;

  /// The parameter `value` of this provider.
  String get value;
}

class _ReimbusmentTypeProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ReimbusmentType,
        List<DropdownModel>> with ReimbusmentTypeRef {
  _ReimbusmentTypeProviderElement(super.provider);

  @override
  BuildContext get context => (origin as ReimbusmentTypeProvider).context;
  @override
  String get value => (origin as ReimbusmentTypeProvider).value;
}

String _$reimbursementImageHash() =>
    r'42489dc05e919835a34a76b70ed1bc4caf340daa';

/// See also [ReimbursementImage].
@ProviderFor(ReimbursementImage)
final reimbursementImageProvider = AutoDisposeNotifierProvider<
    ReimbursementImage, List<PlatformFile>>.internal(
  ReimbursementImage.new,
  name: r'reimbursementImageProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$reimbursementImageHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ReimbursementImage = AutoDisposeNotifier<List<PlatformFile>>;
String _$reimbusmentSaveDataHash() =>
    r'7c46a4979e913c63fc8baef6c13892e1f900f578';

abstract class _$ReimbusmentSaveData
    extends BuildlessAutoDisposeAsyncNotifier<Response?> {
  late final BuildContext context;

  FutureOr<Response?> build(
    BuildContext context,
  );
}

/// See also [ReimbusmentSaveData].
@ProviderFor(ReimbusmentSaveData)
const reimbusmentSaveDataProvider = ReimbusmentSaveDataFamily();

/// See also [ReimbusmentSaveData].
class ReimbusmentSaveDataFamily extends Family<AsyncValue<Response?>> {
  /// See also [ReimbusmentSaveData].
  const ReimbusmentSaveDataFamily();

  /// See also [ReimbusmentSaveData].
  ReimbusmentSaveDataProvider call(
    BuildContext context,
  ) {
    return ReimbusmentSaveDataProvider(
      context,
    );
  }

  @override
  ReimbusmentSaveDataProvider getProviderOverride(
    covariant ReimbusmentSaveDataProvider provider,
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
  String? get name => r'reimbusmentSaveDataProvider';
}

/// See also [ReimbusmentSaveData].
class ReimbusmentSaveDataProvider extends AutoDisposeAsyncNotifierProviderImpl<
    ReimbusmentSaveData, Response?> {
  /// See also [ReimbusmentSaveData].
  ReimbusmentSaveDataProvider(
    BuildContext context,
  ) : this._internal(
          () => ReimbusmentSaveData()..context = context,
          from: reimbusmentSaveDataProvider,
          name: r'reimbusmentSaveDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$reimbusmentSaveDataHash,
          dependencies: ReimbusmentSaveDataFamily._dependencies,
          allTransitiveDependencies:
              ReimbusmentSaveDataFamily._allTransitiveDependencies,
          context: context,
        );

  ReimbusmentSaveDataProvider._internal(
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
    covariant ReimbusmentSaveData notifier,
  ) {
    return notifier.build(
      context,
    );
  }

  @override
  Override overrideWith(ReimbusmentSaveData Function() create) {
    return ProviderOverride(
      origin: this,
      override: ReimbusmentSaveDataProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<ReimbusmentSaveData, Response?>
      createElement() {
    return _ReimbusmentSaveDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ReimbusmentSaveDataProvider && other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ReimbusmentSaveDataRef on AutoDisposeAsyncNotifierProviderRef<Response?> {
  /// The parameter `context` of this provider.
  BuildContext get context;
}

class _ReimbusmentSaveDataProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ReimbusmentSaveData,
        Response?> with ReimbusmentSaveDataRef {
  _ReimbusmentSaveDataProviderElement(super.provider);

  @override
  BuildContext get context => (origin as ReimbusmentSaveDataProvider).context;
}

String _$reimbusmentPaginationHash() =>
    r'01bcd125ec9bd04a29e71e7108a83011fd186d1a';

/// See also [ReimbusmentPagination].
@ProviderFor(ReimbusmentPagination)
final reimbusmentPaginationProvider =
    AutoDisposeAsyncNotifierProvider<ReimbusmentPagination, void>.internal(
  ReimbusmentPagination.new,
  name: r'reimbusmentPaginationProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$reimbusmentPaginationHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ReimbusmentPagination = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
