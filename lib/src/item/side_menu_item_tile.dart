import "package:auto_size_text/auto_size_text.dart";
import "package:badges/badges.dart" as badges;
import "package:flutter/material.dart";
import "package:flutter_side_menu/flutter_side_menu.dart";
import "package:flutter_side_menu/src/provider/SideMenuProvider.dart";
import "package:flutter_side_menu/src/utils/constants.dart";
import "package:provider/provider.dart";

class SideMenuItemTile extends StatefulWidget {
  SideMenuItemTile({
    Key? key,
    required this.isOpen,
    required this.minWidth,
    required this.data,
    this.onTileSelected,
  }) : super(key: key ?? ValueKey(data.title));
  final SideMenuItemDataTile data;
  final bool isOpen;
  final double minWidth;
  final Function(SideMenuItemDataTile tile)? onTileSelected;
  @override
  State<SideMenuItemTile> createState() => _SideMenuItemTileState();
}

class _SideMenuItemTileState extends State<SideMenuItemTile> {
  @override
  Widget build(BuildContext context) {
    return _buildContent(context);
  }

  @override
  void initState() {
    super.initState();
  }

  Widget _buildContent(BuildContext context) {
    final provider = Provider.of<SideMenuProvider>(context);
    if (widget.data.children?.isEmpty ?? true) {
      return Container(
        height: 50,
        margin: widget.data.margin,
        decoration: ShapeDecoration(
          shape: shape(context),
          color: provider.isSelected(widget.key!)
              ? widget.data.highlightSelectedColor ??
                  Theme.of(context).colorScheme.secondaryContainer
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          clipBehavior: Clip.hardEdge,
          shape: shape(context),
          child: InkWell(
            onTap: () {
              provider.selectTile(widget.key!, widget.data);
              widget.data.onTap!();
              widget.onTileSelected?.call(widget.data);
            },
            hoverColor: widget.data.hoverColor,
            child: _createView(context: context),
          ),
        ),
      );
    } else {
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

  Widget _createView({
    required BuildContext context,
  }) {
    final content = _hasTooltip(
      child: _hasBadge(
        child: _content(
          context: context,
        ),
      ),
    );
    final provider = Provider.of<SideMenuProvider>(context, listen: false);
    return provider.isSelected(widget.key!) && widget.data.hasSelectedLine
        ? _hasSelectedLine(child: content)
        : content;
  }

  Widget _hasTooltip({
    required Widget child,
  }) {
    if (widget.data.tooltip != null) {
      return Tooltip(
        message: widget.data.tooltip,
        child: child,
      );
    }
    return child;
  }

  Widget _hasBadge({
    required Widget child,
  }) {
    if (widget.data.badgeContent != null) {
      return badges.Badge(
        badgeContent: Center(child: widget.data.badgeContent!),
        badgeStyle: widget.data.badgeStyle ?? Constants.badgeStyle,
        position: widget.data.badgePosition ?? Constants.badgePosition,
        child: child,
      );
    }
    return child;
  }

  Widget _content({
    required BuildContext context,
  }) {
    final hasIcon = widget.data.icon != null;
    if (hasIcon) {
      return Row(
        children: [
          _icon(),
          if (widget.isOpen)
            Expanded(
              child: _title(context: context),
            ),
        ],
      );
    } else if (hasIcon) {
      return Align(
        alignment: AlignmentDirectional.centerStart,
        child: _icon(),
      );
    } else {
      return Container(
        alignment: AlignmentDirectional.centerStart,
        padding: Constants.textStartPadding,
        child: _title(context: context),
      );
    }
  }

  Widget _icon() {
    return widget.data.icon != null
        ? SizedBox(
            width: widget.minWidth - widget.data.margin.horizontal,
            height: double.maxFinite,
            child: IconTheme(
              data: Theme.of(context)
                  .iconTheme
                  .copyWith(color: getSelectedColor(context)),
              child: getSelectedIcon(context)!,
            ),
          )
        : const SizedBox.shrink();
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

  Widget _selectedLine(BuildContext context) {
    return SizedBox.fromSize(
      size: widget.data.selectedLineSize,
      child: ColoredBox(
        color: getSelectedColor(context),
      ),
    );
  }

  Widget _hasSelectedLine({
    required Widget child,
  }) {
    return Stack(
      alignment: AlignmentDirectional.centerStart,
      children: [
        child,
        _selectedLine(context),
      ],
    );
  }
}
