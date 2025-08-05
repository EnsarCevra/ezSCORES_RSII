import 'package:flutter/material.dart';
import 'pagination_controller.dart';

class PaginationControls extends StatelessWidget {
  final PaginationController controller;

  const PaginationControls({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: controller.hasPrevious ? controller.previousPage : null,
        ),
        Text("Page ${controller.displayPage} of ${controller.totalPages}"),
        IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: controller.hasNext ? controller.nextPage : null,
        ),
      ],
    );
  }
}
