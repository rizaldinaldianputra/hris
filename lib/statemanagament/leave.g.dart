// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$leaveListHash() => r'c130e1377907c03c9dc743a8c9200b34c7557e5a';

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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
