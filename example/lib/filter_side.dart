import 'package:flutter/material.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
enum MenuItemId {
  name,
  setting,
  info,
  access,
  accessibility,
  ac
}


class FilterSide extends StatelessWidget {
  const FilterSide({Key? key}) : super(key: key);


  final _navItems = const [
    NavItemModel(name: 'Item 1', icon: Icons.home, enu: MenuItemId.name),
    NavItemModel(name: 'Item 2', icon: Icons.settings, enu: MenuItemId.setting),
    NavItemModel(name: 'Item 3', icon: Icons.info, enu: MenuItemId.info),
  ];
  final _accountItems = const [
    NavItemModel(name: 'Item 4', icon: Icons.access_alarms_sharp, enu: MenuItemId.access),
    NavItemModel(name: 'Item 5', icon: Icons.accessibility_new_sharp,enu: MenuItemId.accessibility),
    NavItemModel(name: 'Item 6', icon: Icons.ac_unit_sharp,enu: MenuItemId.ac),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: Row(
            children: [
              Expanded(
                child: Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: Text(
                    'body',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
              ),
              VerticalDivider(
                width: 1,
                thickness: 1,
                color: Colors.grey.shade300,
              ),
              SideMenu(
                mode: SideMenuMode.open,
                position: SideMenuPosition.right,
                hasResizer: false,
                hasResizerToggle: false,
                builder: (data) {
                  return SideMenuData(
                    header: Column(
                      children: [
                        const ListTile(
                          title: Text('View Option',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            border: Border.all(
                              color: Colors.grey.shade300,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const ListTile(
                            title: Text('Default View'),
                          ),
                        ),
                        const ListTile(
                          leading: Icon(Icons.filter_alt_outlined),
                          title: Text('Filter'),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                        const ListTile(
                          leading: Icon(Icons.sort),
                          title: Text('Sort'),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                        const ListTile(
                          leading: Icon(Icons.access_alarm),
                          title: Text('Alarm'),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                        const Divider()
                      ],
                    ),
                    items: [
                      ..._navItems
                          .asMap()
                          .entries
                          .map(
                            (e) => SideMenuItemDataTile(
                              id:e.value.enu,
                              title: e.value.name,
                              icon: Icon(
                                e.value.icon,
                                color: const Color(0xff0055c3),
                              ),
                            ),
                          )
                          .toList(),
                      SideMenuItemDataDivider(divider: const Divider()),
                      SideMenuItemDataTitle(title: 'Account'),
                      ..._accountItems
                          .asMap()
                          .entries
                          .map(
                            (e) => SideMenuItemDataTile(
                              id:e.value.enu,
                              title: e.value.name,
                              icon: Icon(
                                e.value.icon,
                                color: const Color(0xff8e8e8e),
                              ),
                              badgeContent: const Text(
                                '23',
                                style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.white,
                                ),
                              ).showOrNull(data.isOpen),
                            ),
                          )
                          .toList(),
                    ],
                    footer: ListTile(
                      title: const Text('Foo Bar').showOrNull(data.isOpen),
                      subtitle: const Text('Foo Bar').showOrNull(data.isOpen),
                      leading: const Icon(Icons.person_pin),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension on Widget {
  Widget? showOrNull(bool isShow) => isShow ? this : null;
}

class NavItemModel {
  const NavItemModel({
    required this.name,
    required this.icon,
    required this.enu,
  });

  final String name;
  final dynamic enu;
  final IconData icon;
}
