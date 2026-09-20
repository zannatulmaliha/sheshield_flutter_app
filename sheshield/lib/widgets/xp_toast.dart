import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

void showXpToast(BuildContext context, int amount, {String? label}) {
  final messenger = ScaffoldMessenger.of(context);
  messenger.hideCurrentSnackBar();
  messenger.showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.textPrimary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 100),
      duration: const Duration(milliseconds: 1600),
      content: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.bolt_rounded, color: Color(0xFFFFD166), size: 18),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              '+$amount XP${label != null ? ' · $label' : ''}',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13),
            ),
          ),
        ],
      ),
    ),
  );
}
