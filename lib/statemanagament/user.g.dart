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

String _$userLogoutHash() => r'd01b755c00cd4b550425d6652d11828863955b33';

abstract class _$UserLogout extends BuildlessAutoDisposeAsyncNotifier<String?> {
  late final BuildContext context;

  FutureOr<String?> build(
    BuildContext context,
  );
}

/// See also [UserLogout].
@ProviderFor(UserLogout)
const userLogoutProvider = UserLogoutFamily();

/// See also [UserLogout].
class UserLogoutFamily extends Family<AsyncValue<String?>> {
  /// See also [UserLogout].
  const UserLogoutFamily();

  /// See also [UserLogout].
  UserLogoutProvider call(
    BuildContext context,
  ) {
    return UserLogoutProvider(
      context,
    );
  }

  @override
  UserLogoutProvider getProviderOverride(
    covariant UserLogoutProvider provider,
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
  String? get name => r'userLogoutProvider';
}

/// See also [UserLogout].
class UserLogoutProvider
    extends AutoDisposeAsyncNotifierProviderImpl<UserLogout, String?> {
  /// See also [UserLogout].
  UserLogoutProvider(
    BuildContext context,
  ) : this._internal(
          () => UserLogout()..context = context,
          from: userLogoutProvider,
          name: r'userLogoutProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userLogoutHash,
          dependencies: UserLogoutFamily._dependencies,
          allTransitiveDependencies:
              UserLogoutFamily._allTransitiveDependencies,
          context: context,
        );

  UserLogoutProvider._internal(
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
  FutureOr<String?> runNotifierBuild(
    covariant UserLogout notifier,
  ) {
    return notifier.build(
      context,
    );
  }

  @override
  Override overrideWith(UserLogout Function() create) {
    return ProviderOverride(
      origin: this,
      override: UserLogoutProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<UserLogout, String?> createElement() {
    return _UserLogoutProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserLogoutProvider && other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UserLogoutRef on AutoDisposeAsyncNotifierProviderRef<String?> {
  /// The parameter `context` of this provider.
  BuildContext get context;
}

class _UserLogoutProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<UserLogout, String?>
    with UserLogoutRef {
  _UserLogoutProviderElement(super.provider);

  @override
  BuildContext get context => (origin as UserLogoutProvider).context;
}

String _$userUpdateHash() => r'83eff8ab4d2a1639b703e0a35a59daab99e2e066';

abstract class _$UserUpdate
    extends BuildlessAutoDisposeAsyncNotifier<Response?> {
  late final BuildContext context;

  FutureOr<Response?> build(
    BuildContext context,
  );
}

/// See also [UserUpdate].
@ProviderFor(UserUpdate)
const userUpdateProvider = UserUpdateFamily();

/// See also [UserUpdate].
class UserUpdateFamily extends Family<AsyncValue<Response?>> {
  /// See also [UserUpdate].
  const UserUpdateFamily();

  /// See also [UserUpdate].
  UserUpdateProvider call(
    BuildContext context,
  ) {
    return UserUpdateProvider(
      context,
    );
  }

  @override
  UserUpdateProvider getProviderOverride(
    covariant UserUpdateProvider provider,
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
  String? get name => r'userUpdateProvider';
}

/// See also [UserUpdate].
class UserUpdateProvider
    extends AutoDisposeAsyncNotifierProviderImpl<UserUpdate, Response?> {
  /// See also [UserUpdate].
  UserUpdateProvider(
    BuildContext context,
  ) : this._internal(
          () => UserUpdate()..context = context,
          from: userUpdateProvider,
          name: r'userUpdateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userUpdateHash,
          dependencies: UserUpdateFamily._dependencies,
          allTransitiveDependencies:
              UserUpdateFamily._allTransitiveDependencies,
          context: context,
        );

  UserUpdateProvider._internal(
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
    covariant UserUpdate notifier,
  ) {
    return notifier.build(
      context,
    );
  }

  @override
  Override overrideWith(UserUpdate Function() create) {
    return ProviderOverride(
      origin: this,
      override: UserUpdateProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<UserUpdate, Response?>
      createElement() {
    return _UserUpdateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserUpdateProvider && other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UserUpdateRef on AutoDisposeAsyncNotifierProviderRef<Response?> {
  /// The parameter `context` of this provider.
  BuildContext get context;
}

class _UserUpdateProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<UserUpdate, Response?>
    with UserUpdateRef {
  _UserUpdateProviderElement(super.provider);

  @override
  BuildContext get context => (origin as UserUpdateProvider).context;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
