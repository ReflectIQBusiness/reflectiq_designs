import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:reflectiq_designs/screens/finance/home_page.dart';
import 'package:reflectiq_designs/screens/finance/investement_page.dart';
import 'package:reflectiq_designs/screens/finance/wallet_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  _SelectedTab _selectedTab = _SelectedTab.home;

  final List _pages = [
    const HomePage(),
    const WalletPage(),
    const InvestementPage(),
  ];

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff25272d),
      appBar: createAppBar(),
      extendBody: true,
      body: _pages[_SelectedTab.values.indexOf(_selectedTab)],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: CrystalNavigationBar(
          currentIndex: _SelectedTab.values.indexOf(_selectedTab),
          paddingR: const EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 5),
          unselectedItemColor: Colors.white70,
          backgroundColor: Colors.white.withOpacity(0.1),
          enableFloatingNavBar: true,
          indicatorColor: Colors.white,
          outlineBorderColor: Colors.transparent,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.16),
              blurRadius: 50,
            ),
          ],
          onTap: _handleIndexChanged,
          items: [
            CrystalNavigationBarItem(
              icon: IconlyBold.home,
              unselectedIcon: IconlyLight.home,
              selectedColor: Colors.white,
            ),
            CrystalNavigationBarItem(
              icon: IconlyBold.wallet,
              unselectedIcon: IconlyLight.wallet,
              selectedColor: Colors.white,
            ),
            CrystalNavigationBarItem(
              icon: IconlyBold.activity,
              unselectedIcon: IconlyLight.activity,
              selectedColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  AppBar createAppBar() {
    return AppBar(
      elevation: 0,
      leadingWidth: 80,
      backgroundColor: const Color(0xff25272d),
      leading: const Padding(
        padding: EdgeInsets.only(left: 20),
        child: CircleAvatar(
          backgroundImage: NetworkImage('https://avatars.githubusercontent.com/u/9606964?v=4'),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            IconlyBold.setting,
            color: Colors.white54,
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white24),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              IconlyBold.notification,
              color: Color(0xff25272d),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white54),
            ),
          ),
        ),
      ],
    );
  }
}

enum _SelectedTab { home, wallet, activity }
// Scaffold(
//       extendBody: true,
//       appBar: createAppBar(),
//       backgroundColor: const Color(0xff25272d),
//       body: _pages[_SelectedTab.values.indexOf(_selectedTab)],
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.only(bottom: 10),
//         child: CrystalNavigationBar(
//           currentIndex: _SelectedTab.values.indexOf(_selectedTab),
//           paddingR: const EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 5),
//           // indicatorColor: Colors.white,
//           unselectedItemColor: Colors.white70,
//           backgroundColor: Colors.white.withOpacity(0.1),
//           enableFloatingNavBar: true,
//           indicatorColor: Colors.white,
//           outlineBorderColor: Colors.transparent,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.16),
//               blurRadius: 50,
//             ),
//           ],
//           // outlineBorderColor: Colors.black.withOpacity(0.1),
//           onTap: _handleIndexChanged,
//           items: [
//             /// Home
//             CrystalNavigationBarItem(
//               icon: IconlyBold.home,
//               unselectedIcon: IconlyLight.home,
//               selectedColor: Colors.white,
//             ),

//             /// Favourite
//             CrystalNavigationBarItem(
//               icon: IconlyBold.wallet,
//               unselectedIcon: IconlyLight.wallet,
//               selectedColor: Colors.white,
//             ),

//             /// Add
//             CrystalNavigationBarItem(
//               icon: IconlyBold.activity,
//               unselectedIcon: IconlyLight.activity,
//               selectedColor: Colors.white,
//             ),

//             /// Search
//           ],
//         ),
//       ),
//     );