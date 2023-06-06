// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'custom_tab_item.dart';

class CustomTab extends HookConsumerWidget {
  const CustomTab({
    Key? key,
    required this.items,
    this.onChanged,
    required this.currentIndex,
  }) : super(key: key);

  final List<CustomTabItem> items;
  final ValueChanged<int>? onChanged;
  final int currentIndex;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: items.length,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items
            .asMap()
            .entries
            .map(
              (e) => Expanded(
                child: GestureDetector(
                  onTap: () {
                    onChanged?.call(e.key);
                  },
                  child: CustomTabTile(
                    isActive: e.key == currentIndex,
                    text: e.value.text,
                    color: e.value.color,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
