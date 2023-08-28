import "package:flutter/material.dart";
import "package:flutter_side_menu/flutter_side_menu.dart";

class SideMenuProvider with ChangeNotifier {
  final List<Key> _selectedTileIds = [];
  final List<SideMenuItemDataTile> _titles = [];

  void selectTile(Key id, SideMenuItemDataTile data) {
    _selectedTileIds.clear();
    _titles.clear();
    _selectedTileIds.add(id);
    _titles.add(data);
    notifyListeners();
  }

  bool isSelected(Key id) {
    return _selectedTileIds.contains(id);
  }

  bool shouldExpand(List<SideMenuItemDataTile> children) {
    for (final child in children) {
      if (_selectedTileIds.contains(child.key)) {
        return true;
      }
    }
    return false;
  }

  Key getSelectedTile() {
    return _selectedTileIds.first;
  }

  SideMenuItemDataTile getSelectedTileData() {
    return _titles.first;
  }

  List<Key> get selectedTileIds {
    return _selectedTileIds;
  }
}
