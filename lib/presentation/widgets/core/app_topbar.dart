import 'package:flutter/material.dart';

class AppTopBar extends StatelessWidget {
  const AppTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            Icon(Icons.menu, color: Colors.black87),
            const SizedBox(width: 12),
            Text(
              'Medibook',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
          ],
        ),
        const Spacer(),
        _RoundedIcon(icon: Icons.wifi),
        const SizedBox(width: 8),
        _RoundedIcon(icon: Icons.dark_mode, muted: true),
        const SizedBox(width: 12),
        const _LangToggle(),
        const SizedBox(width: 12),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add),
          label: const Text('Create New'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal[800],
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 2,
          ),
        ),
        const SizedBox(width: 12),
        _ProfileChip(name: 'SuperAnaam'),
      ],
    );
  }
}

class _RoundedIcon extends StatelessWidget {
  final IconData icon;
  final bool muted;
  const _RoundedIcon({required this.icon, this.muted = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      width: 36,
      decoration: BoxDecoration(
        color: muted ? Colors.grey[200] : Colors.teal[50],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: muted ? Colors.grey[300]! : Colors.teal[100]!,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(icon, size: 18, color: Colors.black87),
    );
  }
}

class _LangToggle extends StatelessWidget {
  const _LangToggle();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _langSegment(context, selected: true, text: 'EN'),
          Container(width: 1, height: 20, color: Colors.grey[300]),
          _langSegment(context, selected: false, text: 'ID'),
        ],
      ),
    );
  }

  Widget _langSegment(
    BuildContext context, {
    required bool selected,
    required String text,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: selected ? Colors.lightBlue[100] : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.language, size: 14, color: Colors.black87),
          const SizedBox(width: 6),
          Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _ProfileChip extends StatelessWidget {
  final String name;
  const _ProfileChip({required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircleAvatar(radius: 14, child: Icon(Icons.person, size: 16)),
          const SizedBox(width: 8),
          Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(width: 6),
          const Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }
}
