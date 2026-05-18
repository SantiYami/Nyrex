// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Exposes the resolved [ThemeData] for the current variant.
/// Built on top of [themeVariantProvider].

@ProviderFor(themeVariant)
final themeVariantProvider = ThemeVariantProvider._();

/// Exposes the resolved [ThemeData] for the current variant.
/// Built on top of [themeVariantProvider].

final class ThemeVariantProvider
    extends
        $FunctionalProvider<
          NyrexThemeVariant,
          NyrexThemeVariant,
          NyrexThemeVariant
        >
    with $Provider<NyrexThemeVariant> {
  /// Exposes the resolved [ThemeData] for the current variant.
  /// Built on top of [themeVariantProvider].
  ThemeVariantProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'themeVariantProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$themeVariantHash();

  @$internal
  @override
  $ProviderElement<NyrexThemeVariant> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NyrexThemeVariant create(Ref ref) {
    return themeVariant(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NyrexThemeVariant value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NyrexThemeVariant>(value),
    );
  }
}

String _$themeVariantHash() => r'184258fad0ba30143b7de7e1aeaee777eb0bf8da';

/// Manages persistence and state changes for the theme variant.

@ProviderFor(ThemeNotifier)
final themeProvider = ThemeNotifierProvider._();

/// Manages persistence and state changes for the theme variant.
final class ThemeNotifierProvider
    extends $NotifierProvider<ThemeNotifier, NyrexThemeVariant> {
  /// Manages persistence and state changes for the theme variant.
  ThemeNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'themeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$themeNotifierHash();

  @$internal
  @override
  ThemeNotifier create() => ThemeNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NyrexThemeVariant value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NyrexThemeVariant>(value),
    );
  }
}

String _$themeNotifierHash() => r'e58d4ea82619a0e9e9d9ea4a8ce5b77df1367e2d';

/// Manages persistence and state changes for the theme variant.

abstract class _$ThemeNotifier extends $Notifier<NyrexThemeVariant> {
  NyrexThemeVariant build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<NyrexThemeVariant, NyrexThemeVariant>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<NyrexThemeVariant, NyrexThemeVariant>,
              NyrexThemeVariant,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
