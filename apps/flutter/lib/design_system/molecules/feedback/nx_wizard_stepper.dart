// SPDX-License-Identifier: CC-BY-NC-SA-4.0
// Copyright (c) 2026 SantiYami

/// NxWizardStepper — Multi-step progress indicator.
///
/// Composition: Step dots + labels.
/// Styling: Active gets violet underline. Completed gets teal check.
library;

import 'package:flutter/material.dart';
import 'package:nyrex/design_system/tokens/tokens.dart';

class NxWizardStep {
  const NxWizardStep({required this.title, this.isCompleted = false});

  final String title;
  final bool isCompleted;
}

class NxWizardStepper extends StatelessWidget {
  const NxWizardStepper({
    super.key,
    required this.steps,
    required this.currentStepIndex,
  });

  final List<NxWizardStep> steps;
  final int currentStepIndex;

  @override
  Widget build(BuildContext context) {
    final c = NxColors.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(steps.length * 2 - 1, (index) {
        if (index.isOdd) {
          // Separator line
          return _buildSeparator(c);
        }

        final stepIndex = index ~/ 2;
        final step = steps[stepIndex];
        final isActive = stepIndex == currentStepIndex;
        final isCompleted = step.isCompleted || stepIndex < currentStepIndex;

        return _buildStep(step, isActive, isCompleted, c);
      }),
    );
  }

  Widget _buildStep(
    NxWizardStep step,
    bool isActive,
    bool isCompleted,
    NxColors c,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Indicator
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: isCompleted
                ? kColorConfirmation
                : (isActive ? kColorPrimary : c.bg1),
            shape: BoxShape.circle,
            border: isCompleted || isActive
                ? null
                : Border.all(color: c.border, width: 1),
          ),
          child: Center(
            child: isCompleted
                ? const Icon(Icons.check, size: 14, color: Colors.white)
                : (isActive
                      ? Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        )
                      : null),
          ),
        ),
        const SizedBox(height: kSpaceSm),

        // Label
        Text(
          step.title,
          style: nxCaption().copyWith(
            color: isActive
                ? kColorPrimary
                : (isCompleted ? c.textHigh : c.textMedium),
            fontWeight: isActive ? kWeightSemiBold : kWeightRegular,
          ),
        ),
      ],
    );
  }

  Widget _buildSeparator(NxColors c) {
    return Expanded(
      child: Container(
        height: 1,
        margin: const EdgeInsets.symmetric(horizontal: kSpaceSm),
        color: c.border,
      ),
    );
  }
}
