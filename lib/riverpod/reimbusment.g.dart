// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reimbusment.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$reimbursementExpenseNotifierHash() =>
    r'14346a711807d72e6940a958720997c827ed9af2';

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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
