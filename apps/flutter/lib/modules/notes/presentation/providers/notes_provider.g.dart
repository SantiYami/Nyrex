// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(saveNoteUseCase)
final saveNoteUseCaseProvider = SaveNoteUseCaseProvider._();

final class SaveNoteUseCaseProvider
    extends
        $FunctionalProvider<SaveNoteUseCase, SaveNoteUseCase, SaveNoteUseCase>
    with $Provider<SaveNoteUseCase> {
  SaveNoteUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'saveNoteUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$saveNoteUseCaseHash();

  @$internal
  @override
  $ProviderElement<SaveNoteUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SaveNoteUseCase create(Ref ref) {
    return saveNoteUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SaveNoteUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SaveNoteUseCase>(value),
    );
  }
}

String _$saveNoteUseCaseHash() => r'92d900adc58f9d3d836b2391f436e24350add8a5';

@ProviderFor(updateNoteUseCase)
final updateNoteUseCaseProvider = UpdateNoteUseCaseProvider._();

final class UpdateNoteUseCaseProvider
    extends
        $FunctionalProvider<
          UpdateNoteUseCase,
          UpdateNoteUseCase,
          UpdateNoteUseCase
        >
    with $Provider<UpdateNoteUseCase> {
  UpdateNoteUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateNoteUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateNoteUseCaseHash();

  @$internal
  @override
  $ProviderElement<UpdateNoteUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UpdateNoteUseCase create(Ref ref) {
    return updateNoteUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateNoteUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdateNoteUseCase>(value),
    );
  }
}

String _$updateNoteUseCaseHash() => r'2a344f9698660e69640f9444d5b16e76df1463c2';

@ProviderFor(deleteNoteUseCase)
final deleteNoteUseCaseProvider = DeleteNoteUseCaseProvider._();

final class DeleteNoteUseCaseProvider
    extends
        $FunctionalProvider<
          DeleteNoteUseCase,
          DeleteNoteUseCase,
          DeleteNoteUseCase
        >
    with $Provider<DeleteNoteUseCase> {
  DeleteNoteUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deleteNoteUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deleteNoteUseCaseHash();

  @$internal
  @override
  $ProviderElement<DeleteNoteUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeleteNoteUseCase create(Ref ref) {
    return deleteNoteUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeleteNoteUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeleteNoteUseCase>(value),
    );
  }
}

String _$deleteNoteUseCaseHash() => r'77d7af94613e4e485b96552af825c7775b94b12f';

@ProviderFor(NotesState)
final notesStateProvider = NotesStateProvider._();

final class NotesStateProvider
    extends $AsyncNotifierProvider<NotesState, List<NoteModel>> {
  NotesStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notesStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notesStateHash();

  @$internal
  @override
  NotesState create() => NotesState();
}

String _$notesStateHash() => r'dd6880a22580da8bf03312d17abd276fab3ad62c';

abstract class _$NotesState extends $AsyncNotifier<List<NoteModel>> {
  FutureOr<List<NoteModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<NoteModel>>, List<NoteModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<NoteModel>>, List<NoteModel>>,
              AsyncValue<List<NoteModel>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
