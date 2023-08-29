import "package:auto_size_text/auto_size_text.dart";
import "package:flutter/material.dart";
import "package:flutter_side_menu/flutter_side_menu.dart";
import "package:flutter_side_menu/src/provider/SideMenuProvider.dart";
import "package:provider/provider.dart";

class SideMenuExpansionTile extends StatefulWidget {
  const SideMenuExpansionTile({
    super.key,
    required this.data,
    required this.isOpen,
    required this.minWidth,
    this.backgroundColor,
    this.selectedColor,
    this.selectedHeaderColor,
    this.onTileSelected,
  });

  final bool isOpen;
  final double minWidth;
  final SideMenuItemDataTile data;
  final Color? backgroundColor;
  final Color? selectedColor;
  final Color? selectedHeaderColor;
  final Function(SideMenuItemDataTile tile)? onTileSelected;
  @override
  SideMenuExpansionTileState createState() => SideMenuExpansionTileState();
}

class SideMenuExpansionTileState extends State<SideMenuExpansionTile> {
  OutlinedBorder shape(BuildContext context) {
    return widget.data.borderRadius != null
        ? RoundedRectangleBorder(borderRadius: widget.data.borderRadius!)
        : Theme.of(context).useMaterial3
            ? const StadiumBorder()
            : RoundedRectangleBorder(borderRadius: BorderRadius.circular(4));
  }

  Color getSelectedColor(BuildContext context) {
    final provider = Provider.of<SideMenuProvider>(context, listen: false);
    return provider.isSelected(widget.key!)
        ? widget.data.selectedTitleStyle?.color ??
            Theme.of(context).colorScheme.onSecondaryContainer
        : widget.data.titleStyle?.color ??
            Theme.of(context).colorScheme.onSurfaceVariant;
  }

  Widget? getSelectedIcon(BuildContext context) {
    final provider = Provider.of<SideMenuProvider>(context, listen: false);
    return provider.isSelected(widget.key!) && widget.data.selectedIcon != null
        ? widget.data.selectedIcon
        : widget.data.icon;
  }

  Widget _title({
    required BuildContext context,
  }) {
    final titleStyle =
        widget.data.titleStyle ?? Theme.of(context).textTheme.bodyLarge;
    final selectedTitleStyle =
        widget.data.selectedTitleStyle ?? Theme.of(context).textTheme.bodyLarge;
    final provider = Provider.of<SideMenuProvider>(context, listen: false);
    return AutoSizeText(
      widget.data.title,
      style: provider.isSelected(widget.key!)
          ? selectedTitleStyle?.copyWith(color: getSelectedColor(context))
          : titleStyle?.copyWith(color: getSelectedColor(context)),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SideMenuProvider>(context);
    return ExpansionTile(
      initiallyExpanded: provider.shouldExpand(widget.data.children!),
      onExpansionChanged: (value) {
        provider.selectTile(widget.key!, widget.data);
        widget.onTileSelected?.call(widget.data);
      },
      leading: widget.data.icon,
      shape: shape(context),
      textColor: Colors.white,
      title: _title(context: context),
      children: widget.data.children!
          .asMap()
          .entries
          .map(
            (child) => Container(
              color: provider.isSelected(child.value.mykey)
                  ? widget.data.highlightSelectedColor ??
                      Theme.of(context).colorScheme.secondaryContainer
                  : null,
              child: SideMenuItemTile(
                id: child.value.id,
                onTileSelected: widget.onTileSelected,
                isOpen: widget.isOpen,
                minWidth: widget.minWidth,
                data: child.value,
              ),
            ),
          )
          .toList(),
    );
  }
}
