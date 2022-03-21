import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mentor_coclen/constants.dart';
import 'package:mentor_coclen/page/app.dart';

class MenuFooter extends StatefulWidget implements PreferredSizeWidget {
  @override
  _MenuFooter createState() => _MenuFooter();
  late final TabItem currentTab;
  late final ValueChanged<TabItem> onSelectTab;

  MenuFooter({required this.currentTab, required this.onSelectTab});
  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _MenuFooter extends State<MenuFooter> {
  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    return BottomNavigationBarItem(
      icon: Icon(tabIcon[tabItem]),
      label: tabName[tabItem],
    );
  }

  BottomNavigationBarItem _buildNofication(TabItem tabItem) {
    return BottomNavigationBarItem(
      icon: Icon(tabIcon[tabItem]),
      label: tabName[tabItem],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: true,
      showUnselectedLabels: true,
      unselectedItemColor: Colors.grey,
      selectedIconTheme: IconThemeData(color: MaterialColors.primary),
      type: BottomNavigationBarType.fixed,
      currentIndex: widget.currentTab.index,
      selectedItemColor: MaterialColors.primary,
      items: [
        _buildItem(TabItem.home),
        _buildNofication(TabItem.assignment_rounded),
        _buildItem(TabItem.assignment_turned_in_outlined),
        _buildItem(TabItem.account),
      ],
      onTap: (index) => widget.onSelectTab(
        TabItem.values[index],
      ),
    );
  }
}
