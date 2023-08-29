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

class NavigationSide extends StatelessWidget {
  const NavigationSide({Key? key}) : super(key: key);

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
              SideMenu(
                mode: SideMenuMode.open,
                builder: (data) {
                  return SideMenuData(
                    header: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.paypal),
                          title: const Text('PayPal').showOrNull(data.isOpen),
                          trailing:
                              const Icon(Icons.search).showOrNull(data.isOpen),
                        ),
                        if (data.isOpen)
                          const TabBar(
                            labelColor: Colors.black,
                            tabs: [
                              Tab(text: 'Tab 1'),
                              Tab(text: 'Tab 2'),
                            ],
                          )
                        else
                          Switch(value: false, onChanged: (vlaue) {})
                      ],
                    ),
                    items: [
                      ..._navItems
                          .asMap()
                          .entries
                          .map(
                            (e) => SideMenuItemDataTile(
                              id: e.value.enu,
                              onTap: () {},
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
                              id: e.value.enu,
                              onTap: () {},
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
