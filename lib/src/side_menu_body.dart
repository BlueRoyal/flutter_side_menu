import "package:flutter/material.dart";
import "package:flutter_side_menu/flutter_side_menu.dart";

class SideMenuBody extends StatelessWidget {
  const SideMenuBody({
    super.key,
    required this.minWidth,
    required this.isOpen,
    required this.data,
    this.onTileSelected,
  });
  final double minWidth;
  final bool isOpen;
  final SideMenuData data;
  final Function(SideMenuItemDataTile tile)? onTileSelected;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      if (data.header != null) data.header!,
      if (data.customChild != null) Expanded(child: data.customChild!),
      if (data.items != null)
        Expanded(
          child: ListView.builder(
            controller: ScrollController(),
            itemCount: data.items!.length,
            itemBuilder: (context, index) {
              final item = data.items![index];
              if (item is SideMenuItemDataTile) {
                return SideMenuItemTile(
                  id: item.id,
                  onTileSelected: onTileSelected,
                  minWidth: minWidth,
                  isOpen: isOpen,
                  data: item,
                );
              } else if (item is SideMenuItemDataTitle) {
                return SideMenuItemTitle(
                  data: item,
                );
              } else if (item is SideMenuItemDataDivider) {
                return SideMenuItemDivider(
                  data: item,
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      if (data.footer != null) data.footer!,
    ]);
  }
}
