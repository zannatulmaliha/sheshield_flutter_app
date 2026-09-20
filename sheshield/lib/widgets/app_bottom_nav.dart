import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class NavItemData {
  const NavItemData(this.icon, this.activeIcon, this.label);
  final IconData icon;
  final IconData activeIcon;
  final String label;
}

const List<NavItemData> navItems = [
  NavItemData(Icons.home_outlined, Icons.home_rounded, 'Home'),
  NavItemData(Icons.people_alt_outlined, Icons.people_alt_rounded, 'Contacts'),
  NavItemData(Icons.auto_awesome_outlined, Icons.auto_awesome_rounded, 'AI Mode'),
  NavItemData(Icons.person_outline_rounded, Icons.person_rounded, 'Profile'),
];

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({super.key, required this.currentIndex, required this.onTap});

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Container(
        height: 72,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: softShadow(opacity: 0.14),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(navItems.length, (index) {
            final item = navItems[index];
            final isActive = index == currentIndex;
            return Expanded(
              child: InkWell(
                borderRadius: BorderRadius.circular(24),
                onTap: () => onTap(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOutCubic,
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                  padding: EdgeInsets.symmetric(horizontal: isActive ? 14 : 0),
                  decoration: BoxDecoration(
                    color: isActive ? AppColors.chipBackground : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isActive ? item.activeIcon : item.icon,
                        color: isActive ? AppColors.primary : AppColors.textSecondary,
                        size: 24,
                      ),
                      AnimatedSize(
                        duration: const Duration(milliseconds: 220),
                        curve: Curves.easeOutCubic,
                        child: isActive
                            ? Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(
                                  item.label,
                                  style: const TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                  ),
                                ),
                              )
                            : const SizedBox(width: 0, height: 0),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
