// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

/// NxCommandPalette — The global ⌘K modal overlay.
///
/// Features (JSX-aligned):
/// - 540px width, 480px max height, border-radius 16
/// - Heavy shadow: 0 20px 60px rgba(0,0,0,.5), accent glow border
/// - Grouped results with uppercase mono section headers
/// - Keyboard navigation (↑↓ to move, ↵ to select, ESC to close)
/// - Selected item: acc-active bg, acc-text color
/// - Footer bar: ↑↓ navigate | ↵ select | NYREX · v1.0
/// - Search highlight: confirm color on matched chars
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nyrex/design_system/tokens/tokens.dart';
import 'package:nyrex/design_system/atoms/atoms.dart';
import 'package:nyrex/design_system/molecules/molecules.dart';
import 'package:nyrex/l10n/generated/app_localizations.dart';

class NxCommandResult {
  const NxCommandResult({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onSelected,
    this.group,
    this.shortcut,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onSelected;
  final String? group;
  final String? shortcut;
}

class NxCommandPalette extends StatefulWidget {
  const NxCommandPalette({
    super.key,
    required this.results,
    this.onQueryChanged,
  });

  final List<NxCommandResult> results;
  final ValueChanged<String>? onQueryChanged;

  /// Utility to show the palette as a dialog.
  static Future<void> show(
    BuildContext context, {
    required List<NxCommandResult> results,
    ValueChanged<String>? onQueryChanged,
  }) {
    return showDialog(
      context: context,
      barrierColor: Colors.black.withAlpha(128),
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        alignment: Alignment.topCenter,
        insetPadding: const EdgeInsets.only(top: 100),
        child: NxCommandPalette(
          results: results,
          onQueryChanged: onQueryChanged,
        ),
      ),
    );
  }

  @override
  State<NxCommandPalette> createState() => _NxCommandPaletteState();
}

class _NxCommandPaletteState extends State<NxCommandPalette> {
  final _searchController = TextEditingController();
  final _focusNode = FocusNode();
  int _selectedIndex = 0;

  List<NxCommandResult> get _flatResults => widget.results;

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleKeyEvent(KeyEvent event) {
    if (event is! KeyDownEvent) return;

    if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      setState(() {
        _selectedIndex = (_selectedIndex + 1) % _flatResults.length;
      });
    } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      setState(() {
        _selectedIndex =
            (_selectedIndex - 1 + _flatResults.length) % _flatResults.length;
      });
    } else if (event.logicalKey == LogicalKeyboardKey.enter) {
      if (_flatResults.isNotEmpty) {
        Navigator.of(context).pop();
        _flatResults[_selectedIndex].onSelected();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final c = NxColors.of(context);

    // Group results
    final groupedResults = <String, List<(int, NxCommandResult)>>{};
    for (var i = 0; i < widget.results.length; i++) {
      final result = widget.results[i];
      final group = result.group ?? l10n.commandPaletteGroupOther;
      groupedResults.putIfAbsent(group, () => []).add((i, result));
    }

    return KeyboardListener(
      focusNode: _focusNode,
      autofocus: true,
      onKeyEvent: _handleKeyEvent,
      child: Container(
        width: 540,
        constraints: const BoxConstraints(maxHeight: 480),
        decoration: BoxDecoration(
          color: c.bg1,
          borderRadius: kRadiusLg,
          border: Border.all(
            color: kColorPrimary.withAlpha(46), // rgba(124,106,247,.18)
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(128), // rgba(0,0,0,.5)
              blurRadius: 60,
              offset: const Offset(0, 20),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Search Input
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kSpaceLg,
                vertical: 14,
              ),
              child: Row(
                children: [
                  Icon(Icons.search, size: 15, color: c.textLow),
                  const SizedBox(width: kSpaceMd),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      autofocus: true,
                      style: nxBody().copyWith(color: c.textHigh, fontSize: 14),
                      decoration: InputDecoration(
                        hintText: l10n.hintCommandPalette,
                        hintStyle: nxBody().copyWith(
                          color: c.textLow,
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                      onChanged: widget.onQueryChanged,
                    ),
                  ),
                  const SizedBox(width: kSpaceMd),
                  const NxKbd(label: 'ESC'),
                ],
              ),
            ),

            const SizedBox(width: kSpaceMd),
            Divider(height: 1, color: c.divider),

            // Results
            if (widget.results.isEmpty)
              Padding(
                padding: EdgeInsets.all(kSpace3xl),
                child: NxEmptyState(
                  icon: Icons.search_off,
                  title: l10n.emptySearchTitle,
                  description: l10n.emptySearchDescription,
                ),
              )
            else
              Flexible(
                child: ListView.builder(
                  padding: const EdgeInsets.all(kSpaceSm),
                  shrinkWrap: true,
                  itemCount: groupedResults.length,
                  itemBuilder: (context, groupIndex) {
                    final groupName = groupedResults.keys.elementAt(groupIndex);
                    final items = groupedResults[groupName]!;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Section header — uppercase mono 10px
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: kSpaceMd,
                            vertical: kSpaceSm,
                          ),
                          child: Text(
                            groupName,
                            style: nxMonoSm().copyWith(
                              color: c.textLow,
                              fontWeight: kWeightSemiBold,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ),
                        ...items.map((entry) {
                          final (flatIndex, result) = entry;
                          final isSelected = flatIndex == _selectedIndex;

                          return InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                              result.onSelected();
                            },
                            borderRadius: kRadiusDefault,
                            child: AnimatedContainer(
                              duration: kDurationFast,
                              padding: const EdgeInsets.symmetric(
                                horizontal: kSpaceSm,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? kColorPrimarySoft
                                    : Colors.transparent,
                                borderRadius: kRadiusDefault,
                              ),
                              child: Row(
                                children: [
                                  // Icon container — 22×22, bg-2, radius 5
                                  Container(
                                    width: 22,
                                    height: 22,
                                    decoration: BoxDecoration(
                                      color: c.bg2,
                                      borderRadius: kRadiusSm,
                                    ),
                                    child: Icon(
                                      result.icon,
                                      size: 13,
                                      color: isSelected
                                          ? kColorAccentText
                                          : c.textMedium,
                                    ),
                                  ),
                                  const SizedBox(width: kSpaceMd),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          result.title,
                                          style: nxSecondary().copyWith(
                                            fontSize: 13.5,
                                            fontWeight: kWeightMedium,
                                            color: isSelected
                                                ? kColorAccentText
                                                : c.textHigh,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (result.shortcut != null)
                                    NxKbd(label: result.shortcut!),
                                ],
                              ),
                            ),
                          );
                        }),
                      ],
                    );
                  },
                ),
              ),

            // Footer bar
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: kSpaceLg,
                vertical: kSpaceSm,
              ),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: c.divider, width: 1)),
              ),
              child: Row(
                children: [
                  Text(
                    l10n.commandPaletteNavigate,
                    style: nxMonoSm().copyWith(color: c.textLow),
                  ),
                  const SizedBox(width: kSpaceLg),
                  Text(
                    l10n.commandPaletteSelect,
                    style: nxMonoSm().copyWith(color: c.textLow),
                  ),
                  const Spacer(),
                  Text(
                    'NYREX · v1.0',
                    style: nxMonoSm().copyWith(
                      color: c.textLow,
                      fontWeight: kWeightSemiBold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
