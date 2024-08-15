import 'package:easy_sbp/widgets/sbp_modal.dart';
import 'package:flutter/material.dart';

class SbpButton extends StatelessWidget {
  const SbpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => showSbpModal(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.indigo.shade900,
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.indigo.shade900,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        elevation: 0,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/sbp_logo.png',
            package: 'easy_sbp',
            width: 28,
            height: 28,
          ),
          const SizedBox(width: 8),
          const Text(
            "СБП",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              height: 1,
            ),
          )
        ],
      ),
    );
  }
}
