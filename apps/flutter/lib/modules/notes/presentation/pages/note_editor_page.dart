// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami
library;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nyrex/design_system/tokens/tokens.dart';
import 'package:nyrex/modules/notes/presentation/providers/notes_provider.dart';
import 'package:nyrex/modules/vault/presentation/providers/vault_auth_provider.dart';

class NoteEditorPage extends ConsumerStatefulWidget {
  final int? noteId;
  const NoteEditorPage({super.key, this.noteId});

  @override
  ConsumerState<NoteEditorPage> createState() => _NoteEditorPageState();
}

class _NoteEditorPageState extends ConsumerState<NoteEditorPage>
    with SingleTickerProviderStateMixin {
  late final TextEditingController _titleController;
  late final TextEditingController _contentController;
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _contentController = TextEditingController();
    _tabController = TabController(length: 2, vsync: this);

    if (widget.noteId != null) {
      final notes = ref.read(notesStateProvider).value ?? [];
      final note = notes.firstWhere((n) => n.id == widget.noteId);
      _titleController.text = note.title;
      _contentController.text = note.content;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final title = _titleController.text;
    final content = _contentController.text;

    if (widget.noteId == null) {
      await ref.read(notesStateProvider.notifier).addNote(title, content);
    } else {
      await ref
          .read(notesStateProvider.notifier)
          .updateNote(widget.noteId!, title, content);
    }

    if (mounted) context.go('/home');
  }

  Future<void> _pickAttachment() async {
    if (widget.noteId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please save the note first before adding attachments.',
          ),
        ),
      );
      return;
    }

    try {
      // FORCE DYNAMIC BYPASS: The Windows compiler is failing to resolve the static member 'platform'.
      // This is a last-resort workaround for a known issue in some Flutter Windows toolchains.
      final result = await (FilePicker as dynamic).platform.pickFiles(
        withData: true,
        type: FileType.any,
      );

      if (result != null && result.files.single.bytes != null) {
        final file = result.files.single;

        await ref
            .read(notesStateProvider.notifier)
            .addVaultEntry(
              noteId: widget.noteId!,
              fileName: file.name,
              fileBytes: file.bytes!,
              mimeType: file.extension ?? 'application/octet-stream',
            );

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Attachment "${file.name}" added and encrypted.'),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error picking file: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = NxColors.of(context);
    return Listener(
      onPointerDown: (_) => ref.read(vaultAuthStateProvider.notifier).poke(),
      child: Scaffold(
        backgroundColor: c.bg0,
        appBar: AppBar(
          title: Text(widget.noteId == null ? 'New Note' : 'Edit Note'),
          actions: [
            if (widget.noteId != null)
              IconButton(
                icon: const Icon(Icons.attach_file),
                onPressed: _pickAttachment,
              ),
            IconButton(
              icon: const Icon(Icons.check, color: kColorPrimary),
              onPressed: _save,
            ),
          ],
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Edit'),
              Tab(text: 'Preview'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            Padding(
              padding: const EdgeInsets.all(kSpaceLg),
              child: Column(
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      hintText: 'Title',
                      border: InputBorder.none,
                      filled: false,
                    ),
                    style: nxH1().copyWith(color: c.textHigh),
                  ),
                  const Divider(),
                  Expanded(
                    child: TextField(
                      controller: _contentController,
                      decoration: const InputDecoration(
                        hintText: 'Start writing your thoughts...',
                        border: InputBorder.none,
                        filled: false,
                      ),
                      maxLines: null,
                      expands: true,
                      style: nxBody().copyWith(color: c.textHigh),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(kSpaceLg),
              child: Markdown(
                data: _contentController.text.isEmpty
                    ? '*No content to preview*'
                    : _contentController.text,
                styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
