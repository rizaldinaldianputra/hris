// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userDataHash() => r'0e021dbc8b6a6d074fecf5d4956efa66c787b222';

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

abstract class _$UserData
    extends BuildlessAutoDisposeAsyncNotifier<UserModel?> {
  late final BuildContext context;

  FutureOr<UserModel?> build(
    BuildContext context,
  );
}

/// See also [UserData].
@ProviderFor(UserData)
const userDataProvider = UserDataFamily();

/// See also [UserData].
class UserDataFamily extends Family<AsyncValue<UserModel?>> {
  /// See also [UserData].
  const UserDataFamily();

  /// See also [UserData].
  UserDataProvider call(
    BuildContext context,
  ) {
    return UserDataProvider(
      context,
    );
  }

  @override
  UserDataProvider getProviderOverride(
    covariant UserDataProvider provider,
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
  String? get name => r'userDataProvider';
}

/// See also [UserData].
class UserDataProvider
    extends AutoDisposeAsyncNotifierProviderImpl<UserData, UserModel?> {
  /// See also [UserData].
  UserDataProvider(
    BuildContext context,
  ) : this._internal(
          () => UserData()..context = context,
          from: userDataProvider,
          name: r'userDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userDataHash,
          dependencies: UserDataFamily._dependencies,
          allTransitiveDependencies: UserDataFamily._allTransitiveDependencies,
          context: context,
        );

  UserDataProvider._internal(
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
  FutureOr<UserModel?> runNotifierBuild(
    covariant UserData notifier,
  ) {
    return notifier.build(
      context,
    );
  }

  @override
  Override overrideWith(UserData Function() create) {
    return ProviderOverride(
      origin: this,
      override: UserDataProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<UserData, UserModel?>
      createElement() {
    return _UserDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserDataProvider && other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UserDataRef on AutoDisposeAsyncNotifierProviderRef<UserModel?> {
  /// The parameter `context` of this provider.
  BuildContext get context;
}

class _UserDataProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<UserData, UserModel?>
    with UserDataRef {
  _UserDataProviderElement(super.provider);

  @override
  BuildContext get context => (origin as UserDataProvider).context;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
