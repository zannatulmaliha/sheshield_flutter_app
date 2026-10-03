import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheshield/core/theme/app_palette.dart';

class NavItemData {
  const NavItemData(this.icon, this.activeIcon, this.label);
  final IconData icon;
  final IconData activeIcon;
  final String label;
}

const List<NavItemData> navItems = [
  NavItemData(Icons.home_outlined, Icons.home_rounded, 'Home'),
  NavItemData(Icons.people_alt_outlined, Icons.people_alt_rounded, 'Contacts'),
  NavItemData(
      Icons.auto_awesome_outlined, Icons.auto_awesome_rounded, 'AI Mode',),
  NavItemData(Icons.person_outline_rounded, Icons.person_rounded, 'Profile'),
];

/// Floating bottom bar shared by the User tabs and the Helper tabs (pass
/// [items] for the helper set). Sits low on the screen and uses a lighter,
/// more opaque fill with a pink outline so it stands out from the
/// background instead of blending into it.
class AppBottomNav extends ConsumerWidget {
  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.items = navItems,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<NavItemData> items;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = resolvePalette(context, ref);
    final isDark = colors == AppPalette.dark;
    final barColor = isDark ? const Color(0xFF42293A) : Colors.white;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 6),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            height: 68,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: barColor.withValues(alpha: 0.97),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                  color: colors.primary.withValues(alpha: 0.45), width: 1.2,),
              boxShadow: [
                BoxShadow(
                  color: colors.primary.withValues(alpha: 0.28),
                  blurRadius: 22,
                  offset: const Offset(0, 6),
                ),
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.35),
                  blurRadius: 14,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: List.generate(items.length, (index) {
                final item = items[index];
                final isActive = index == currentIndex;
                return Expanded(
                  flex: isActive ? 2 : 1,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(24),
                    onTap: () => onTap(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      curve: Curves.easeOutCubic,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 3,),
                      padding:
                          EdgeInsets.symmetric(horizontal: isActive ? 8 : 0),
                      decoration: BoxDecoration(
                        color: isActive
                            ? colors.primary.withValues(alpha: 0.2)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isActive ? item.activeIcon : item.icon,
                            color: isActive
                                ? colors.primary
                                : colors.textSecondary,
                            size: 24,
                          ),
                          Flexible(
                            child: AnimatedSize(
                              duration: const Duration(milliseconds: 220),
                              curve: Curves.easeOutCubic,
                              child: isActive
                                  ? Padding(
                                      padding: const EdgeInsets.only(left: 6),
                                      child: Text(
                                        item.label,
                                        maxLines: 1,
                                        softWrap: false,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: colors.primary,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 13,
                                        ),
                                      ),
                                    )
                                  : const SizedBox(width: 0, height: 0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}