import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../home/home_page.dart';
import '../moor/moor_page.dart';
import '../save_select/save_select_page.dart';
import 'navigation_view_model.dart';

class NavigationPage extends StatefulHookConsumerWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  NavigationPageState createState() => NavigationPageState();
}

class NavigationPageState extends ConsumerState<NavigationPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      ref.read(navigationViewModelProvider).init();
    });
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final pages = [
      const SaveSelectPage(),
      HomePage(),
      const MoorPage(),
    ];
    final state = ref.watch(navigationViewModelProvider);

    return Scaffold(
        body: pages[state.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: state.currentIndex,
          onTap: state.setCurrenIndex,
          showUnselectedLabels: true,
          // fixedColor: notificationTextColor1,
          selectedFontSize: 10,
          // selectedItemColor: notificationTextColor1,
          // unselectedItemColor: textColor3,
          selectedLabelStyle: const TextStyle(fontSize: 10),
          unselectedFontSize: 10,
// rounded
          // ignore: prefer_const_literals_to_create_immutables
          items: [
            const BottomNavigationBarItem(
              label: '自選',
              icon: Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Icon(Icons.find_in_page_sharp),
              ),
            ),
            const BottomNavigationBarItem(
              label: '總覽',
              icon: Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Icon(Icons.add_chart_rounded),
              ),
            ),
            const BottomNavigationBarItem(
              label: '更多',
              icon: Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Icon(Icons.menu),
              ),
            ),
          ],
        ));
  }
}
