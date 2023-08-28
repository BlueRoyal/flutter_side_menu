import "package:auto_size_text/auto_size_text.dart";
import "package:flutter/material.dart";
import "package:flutter_side_menu/flutter_side_menu.dart";
import "package:flutter_side_menu/src/data/side_menu_item_data.dart";

class SideMenuItemTitle extends StatelessWidget {
  SideMenuItemTitle({
    Key? key,
    required this.data,
  }) : super(key: key ?? ValueKey(data.title));
  final SideMenuItemDataTitle data;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: data.padding,
      child: _title(context: context),
    );
  }

  Widget _title({
    required BuildContext context,
  }) {
    final titleStyle = data.titleStyle ?? Theme.of(context).textTheme.bodyLarge;
    return AutoSizeText(
      data.title,
      style: titleStyle,
      maxLines: 1,
      textAlign: data.textAlign,
      overflow: TextOverflow.ellipsis,
    );
  }
}
