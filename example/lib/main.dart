import 'package:flutter/material.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';

void main() {
  runApp(const MyApp());
}

enum MenuItemId {
  sectionHeader,
  item1,
  item2,
  account,
  test,
  test2,
  one,
  one_one,
  two,
  two_one,
  two_one_one,
  two_one_two,
  two_one_three,
  three,
  three_one,
  three_two,
  three_two_one,
  three_two_two,
  three_two_three,
  footer
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _controller = SideMenuController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Row(
          children: [
            SideMenu(
              onTileSelected: (tile) {
              //  print(tile.title);
                print(tile.id);
              },
              controller: _controller,
              backgroundColor: Colors.blueGrey,
              mode: SideMenuMode.open,
              builder: (data) {
                return SideMenuData(
                  header: const Text("Header"),
                  items: [
                    SideMenuItemDataTitle(title: 'Section Header'),
                    SideMenuItemDataTitle(
                      title: 'Section Header',
                    ),
                    SideMenuItemDataTile(
                      id: MenuItemId.item1,
                      title: 'Item 1',
                      hoverColor: Colors.blue,
                      titleStyle: const TextStyle(color: Colors.white),
                      icon: const Icon(Icons.home_outlined),
                      selectedIcon: const Icon(Icons.home),
                      badgeContent: const Text(
                        '23',
                        style: TextStyle(
                          fontSize: 8,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SideMenuItemDataTile(
                      id: MenuItemId.item2,
                      title: 'Item 2',
                      selectedTitleStyle: const TextStyle(
                          fontWeight: FontWeight.w700, color: Colors.yellow),
                      icon: const Icon(Icons.table_bar_outlined),
                      selectedIcon: const Icon(Icons.table_bar),
                      titleStyle:
                          const TextStyle(color: Colors.deepPurpleAccent),
                    ),
                    SideMenuItemDataTitle(
                      title: 'Account',
                      textAlign: TextAlign.center,
                    ),
                    SideMenuItemDataTile(
                      id: MenuItemId.test,
                      badgeContent: const Text(
                        '23',
                        style: TextStyle(
                          fontSize: 8,
                          color: Colors.white,
                        ),
                      ),
                      title: "Test",
                      icon: const Icon(Icons.play_arrow),
                      children: [
                        SideMenuItemDataTile(
                          id: MenuItemId.test2,
                          onTap: () {},
                          title: 'Test 2',
                          icon: const Icon(
                            Icons.home,
                            color: Color(0xff0055c3),
                          ),
                        ),
                      ],
                    ),
                    SideMenuItemDataTile(
                      id: MenuItemId.one,
                      badgeContent: const Text(
                        '23',
                        style: TextStyle(
                          fontSize: 8,
                          color: Colors.white,
                        ),
                      ),
                      title: '1',
                      icon: const Icon(Icons.play_arrow),
                      children: [
                        SideMenuItemDataTile(
                          id: MenuItemId.one_one,
                          onTap: () {},
                          title: '1.1',
                          icon: const Icon(
                            Icons.home,
                            color: Color(0xff0055c3),
                          ),
                          children: [
                            SideMenuItemDataTile(
                              id: MenuItemId.two,
                              onTap: () {},
                              title: '2',
                              icon: const Icon(
                                Icons.home,
                                color: Color(0xff0055c3),
                              ),
                            ),
                            SideMenuItemDataTile(
                              id: MenuItemId.two_one,
                              onTap: () {},
                              title: '2.1',
                              icon: const Icon(
                                Icons.table_chart,
                                color: Color(0xff0055c3),
                              ),
                              children: [
                                SideMenuItemDataTile(
                                  id: MenuItemId.two_one_one,
                                  onTap: () {},
                                  title: '2.1.1',
                                  icon: const Icon(
                                    Icons.home,
                                    color: Color(0xff0055c3),
                                  ),
                                ),
                                SideMenuItemDataTile(
                                  id: MenuItemId.two_one_two,
                                  onTap: () {},
                                  title: '2.1.2',
                                  icon: const Icon(
                                    Icons.table_chart,
                                    color: Color(0xff0055c3),
                                  ),
                                ),
                                SideMenuItemDataTile(
                                  id: MenuItemId.two_one_three,
                                  onTap: () {},
                                  title: '2.1.3',
                                  icon: const Icon(
                                    Icons.table_chart,
                                    color: Color(0xff0055c3),
                                  ),
                                ),
                              ],
                            ),
                            SideMenuItemDataTile(
                              id: MenuItemId.three,
                              onTap: () {},
                              title: "3",
                              icon: const Icon(
                                Icons.table_chart,
                                color: Color(0xff0055c3),
                              ),
                            ),
                          ],
                        ),
                        SideMenuItemDataTile(
                          id: MenuItemId.three_one,
                          onTap: () {},
                          title: '3.1',
                          icon: const Icon(
                            Icons.table_chart,
                            color: Color(0xff0055c3),
                          ),
                        ),
                        SideMenuItemDataTile(
                          id: MenuItemId.three_two,
                          onTap: () {},
                          title: '3.2',
                          icon: const Icon(
                            Icons.table_chart,
                            color: Color(0xff0055c3),
                          ),
                          children: [
                            SideMenuItemDataTile(
                              id: MenuItemId.three_two_one,
                              onTap: () {},
                              title: '3.2.1',
                              icon: const Icon(
                                Icons.home,
                                color: Color(0xff0055c3),
                              ),
                            ),
                            SideMenuItemDataTile(
                              id: MenuItemId.three_two_two,
                              onTap: () {},
                              title: '3.2.2',
                              icon: const Icon(
                                Icons.table_chart,
                                color: Color(0xff0055c3),
                              ),
                            ),
                            SideMenuItemDataTile(
                              id: MenuItemId.three_two_three,
                              onTap: () {},
                              title: '3.2.3',
                              icon: const Icon(
                                Icons.table_chart,
                                color: Color(0xff0055c3),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                  footer: const Text('Footer'),
                );
              },
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'body',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _controller.toggle();
                      },
                      child: const Text('change side menu state'),
                    )
                  ],
                ),
              ),
            ),
            SideMenu(
              position: SideMenuPosition.right,
              builder: (data) => const SideMenuData(
                customChild: Text('custom view'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
