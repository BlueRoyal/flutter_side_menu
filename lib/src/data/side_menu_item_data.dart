import "package:badges/badges.dart";
import "package:flutter/material.dart";
import "package:flutter_side_menu/src/utils/constants.dart";

abstract class SideMenuItemData {
  const SideMenuItemData({required this.key});
  final Key key;

  Key get mykey => key;
}

class SideMenuItemDataTile extends SideMenuItemData {
  SideMenuItemDataTile({
    Key? key,
    this.onTap,
    this.icon,
    required this.title,
    this.titleStyle,
    this.selectedTitleStyle,
    this.tooltip,
    this.badgeContent,
    this.hasSelectedLine = true,
    this.selectedLineSize = const Size(
      Constants.itemSelectedLineWidth,
      Constants.itemSelectedLineHeight,
    ),
    this.itemHeight = Constants.itemHeight,
    this.margin = Constants.itemMargin,
    this.borderRadius,
    this.selectedIcon,
    this.highlightSelectedColor,
    this.hoverColor,
    this.badgePosition,
    this.badgeStyle,
    this.children,
  })  : assert(itemHeight >= 0.0),
        assert(icon != null),
        super(key: key ?? ValueKey(title));

  final bool hasSelectedLine;
  final void Function()? onTap;
  final Size selectedLineSize;
  final String title;
  final TextStyle? titleStyle;
  final TextStyle? selectedTitleStyle;
  final String? tooltip;
  final Widget? badgeContent;
  final BadgePosition? badgePosition;
  final BadgeStyle? badgeStyle;
  final Widget? icon;
  final Widget? selectedIcon;
  final double itemHeight;
  final EdgeInsetsDirectional margin;
  final BorderRadiusGeometry? borderRadius;
  final List<SideMenuItemDataTile>? children;
  final Color? hoverColor, highlightSelectedColor;
}

class SideMenuItemDataTitle extends SideMenuItemData {
  SideMenuItemDataTitle({
    required this.title,
    this.titleStyle,
    this.textAlign,
    this.padding = Constants.itemMargin,
  }) : super(key: ValueKey(title));

  final String title;
  final TextStyle? titleStyle;
  final TextAlign? textAlign;
  final EdgeInsetsDirectional padding;
}

class SideMenuItemDataDivider extends SideMenuItemData {
  SideMenuItemDataDivider({
    required this.divider,
    this.padding = Constants.itemMargin,
  }) : super(key: ValueKey(divider));

  final Divider divider;
  final EdgeInsetsDirectional padding;
}
