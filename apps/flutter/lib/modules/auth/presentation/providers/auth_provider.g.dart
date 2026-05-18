// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getSessionUseCase)
final getSessionUseCaseProvider = GetSessionUseCaseProvider._();

final class GetSessionUseCaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<GetSessionUseCase>,
          GetSessionUseCase,
          FutureOr<GetSessionUseCase>
        >
    with
        $FutureModifier<GetSessionUseCase>,
        $FutureProvider<GetSessionUseCase> {
  GetSessionUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getSessionUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getSessionUseCaseHash();

  @$internal
  @override
  $FutureProviderElement<GetSessionUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<GetSessionUseCase> create(Ref ref) {
    return getSessionUseCase(ref);
  }
}

String _$getSessionUseCaseHash() => r'7219fa8730e29fe9cb1b766f81628bb71522fbd2';

@ProviderFor(loginUserUseCase)
final loginUserUseCaseProvider = LoginUserUseCaseProvider._();

final class LoginUserUseCaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<LoginUserUseCase>,
          LoginUserUseCase,
          FutureOr<LoginUserUseCase>
        >
    with $FutureModifier<LoginUserUseCase>, $FutureProvider<LoginUserUseCase> {
  LoginUserUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'loginUserUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$loginUserUseCaseHash();

  @$internal
  @override
  $FutureProviderElement<LoginUserUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<LoginUserUseCase> create(Ref ref) {
    return loginUserUseCase(ref);
  }
}

String _$loginUserUseCaseHash() => r'47c59b23b6d06ba53c58e7dea831d028979d7c19';

@ProviderFor(registerUserUseCase)
final registerUserUseCaseProvider = RegisterUserUseCaseProvider._();

final class RegisterUserUseCaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<RegisterUserUseCase>,
          RegisterUserUseCase,
          FutureOr<RegisterUserUseCase>
        >
    with
        $FutureModifier<RegisterUserUseCase>,
        $FutureProvider<RegisterUserUseCase> {
  RegisterUserUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'registerUserUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$registerUserUseCaseHash();

  @$internal
  @override
  $FutureProviderElement<RegisterUserUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<RegisterUserUseCase> create(Ref ref) {
    return registerUserUseCase(ref);
  }
}

String _$registerUserUseCaseHash() =>
    r'069711fdace323ff4e82750f7a4cc3799e975df6';

@ProviderFor(logoutUserUseCase)
final logoutUserUseCaseProvider = LogoutUserUseCaseProvider._();

final class LogoutUserUseCaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<LogoutUserUseCase>,
          LogoutUserUseCase,
          FutureOr<LogoutUserUseCase>
        >
    with
        $FutureModifier<LogoutUserUseCase>,
        $FutureProvider<LogoutUserUseCase> {
  LogoutUserUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'logoutUserUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$logoutUserUseCaseHash();

  @$internal
  @override
  $FutureProviderElement<LogoutUserUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<LogoutUserUseCase> create(Ref ref) {
    return logoutUserUseCase(ref);
  }
}

String _$logoutUserUseCaseHash() => r'b7e8dfc74d54543970068afaa4d660a547e3d616';

@ProviderFor(AuthState)
final authStateProvider = AuthStateProvider._();

final class AuthStateProvider
    extends $AsyncNotifierProvider<AuthState, AuthSession?> {
  AuthStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authStateHash();

  @$internal
  @override
  AuthState create() => AuthState();
}

String _$authStateHash() => r'5882d8108f4ee300a98fb6f4598474996236db17';

abstract class _$AuthState extends $AsyncNotifier<AuthSession?> {
  FutureOr<AuthSession?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<AuthSession?>, AuthSession?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AuthSession?>, AuthSession?>,
              AsyncValue<AuthSession?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
