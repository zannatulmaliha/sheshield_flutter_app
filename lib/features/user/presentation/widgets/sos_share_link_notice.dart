import 'package:flutter/material.dart';

class SosShareLinkNotice extends StatelessWidget {
  const SosShareLinkNotice({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Row(
        children: [
          Icon(Icons.podcasts_rounded, color: Colors.white, size: 18),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'They can watch your live location and hear an alarm at the link in the text.',
              style: TextStyle(color: Colors.white70, fontSize: 12.5, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}
