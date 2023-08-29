import "package:flutter/material.dart";
import "package:flutter_side_menu/flutter_side_menu.dart";

class SideMenuProvider with ChangeNotifier {
  final List<dynamic> _selectedTileIds = [];
  final List<SideMenuItemDataTile> _titles = [];

  void selectTile(dynamic id, SideMenuItemDataTile data) {
    _selectedTileIds.clear();
    _titles.clear();
    _selectedTileIds.add(id);
    _titles.add(data);
    notifyListeners();
  }

  bool isSelected(dynamic id) {
    return _selectedTileIds.contains(id);
  }

  bool shouldExpand(List<SideMenuItemDataTile> children) {
    for (final child in children) {
      if (_selectedTileIds.contains(child.id)) {
        return true;
      }
    }
    return false;
  }

  dynamic getSelectedTile() {
    return _selectedTileIds.first;
  }

  SideMenuItemDataTile getSelectedTileData() {
    return _titles.first;
  }

  List<dynamic> get selectedTileIds {
    return _selectedTileIds;
  }
}