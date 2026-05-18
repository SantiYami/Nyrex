// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vault_auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(unlockVaultUseCase)
final unlockVaultUseCaseProvider = UnlockVaultUseCaseProvider._();

final class UnlockVaultUseCaseProvider
    extends
        $FunctionalProvider<
          UnlockVaultUseCase,
          UnlockVaultUseCase,
          UnlockVaultUseCase
        >
    with $Provider<UnlockVaultUseCase> {
  UnlockVaultUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'unlockVaultUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$unlockVaultUseCaseHash();

  @$internal
  @override
  $ProviderElement<UnlockVaultUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UnlockVaultUseCase create(Ref ref) {
    return unlockVaultUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UnlockVaultUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UnlockVaultUseCase>(value),
    );
  }
}

String _$unlockVaultUseCaseHash() =>
    r'fd0e0a33b6950f52de1a15233fd8d7067bba574e';

@ProviderFor(saveVaultEntryUseCase)
final saveVaultEntryUseCaseProvider = SaveVaultEntryUseCaseProvider._();

final class SaveVaultEntryUseCaseProvider
    extends
        $FunctionalProvider<
          SaveVaultEntryUseCase,
          SaveVaultEntryUseCase,
          SaveVaultEntryUseCase
        >
    with $Provider<SaveVaultEntryUseCase> {
  SaveVaultEntryUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'saveVaultEntryUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$saveVaultEntryUseCaseHash();

  @$internal
  @override
  $ProviderElement<SaveVaultEntryUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SaveVaultEntryUseCase create(Ref ref) {
    return saveVaultEntryUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SaveVaultEntryUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SaveVaultEntryUseCase>(value),
    );
  }
}

String _$saveVaultEntryUseCaseHash() =>
    r'7512f51aebce819af344d7eebf4fd9174986c3ed';

@ProviderFor(VaultAuthState)
final vaultAuthStateProvider = VaultAuthStateProvider._();

final class VaultAuthStateProvider
    extends $NotifierProvider<VaultAuthState, SecretKey?> {
  VaultAuthStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vaultAuthStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vaultAuthStateHash();

  @$internal
  @override
  VaultAuthState create() => VaultAuthState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SecretKey? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SecretKey?>(value),
    );
  }
}

String _$vaultAuthStateHash() => r'1dd3382d3f5efa091bd2ae33d1afd9b3b4ad5117';

abstract class _$VaultAuthState extends $Notifier<SecretKey?> {
  SecretKey? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<SecretKey?, SecretKey?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SecretKey?, SecretKey?>,
              SecretKey?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
