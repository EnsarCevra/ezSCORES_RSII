import 'package:flutter/material.dart';

class StepProgressBar extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const StepProgressBar({
    super.key,
    required this.currentStep,
    this.totalSteps = 3,
  });

  @override
  Widget build(BuildContext context) {
    double progress = currentStep / totalSteps;

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LinearProgressIndicator(
            value: progress,
            minHeight: 6,
            borderRadius: BorderRadius.circular(12),
            backgroundColor: Colors.grey.shade300,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          const SizedBox(height: 6),
          Text(
            "Korak $currentStep od $totalSteps",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
          ),
        ],
      ),
    );
  }
}
