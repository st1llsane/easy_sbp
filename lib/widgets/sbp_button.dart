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
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          )),
      child: Row(
        children: [
          // Image.asset('assets/sbp_logo.png', width: 24, height: 24),
          const Text(
            "СБП",
            style: TextStyle(
              fontSize: 18,
            ),
          )
        ],
      ),
    );
  }
}
