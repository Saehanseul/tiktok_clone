import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/breakpoints.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/discover/screens/discover_screen.dart';
import 'package:tiktok_clone/features/inbox/screens/inbox_screen.dart';
import 'package:tiktok_clone/features/_archived_main_navigation/widgets/nav_tab.dart';
import 'package:tiktok_clone/features/_archived_main_navigation/widgets/post_video_button.dart';
import 'package:tiktok_clone/features/users/screens/user_profile_screen.dart';
import 'package:tiktok_clone/features/videos/views/screens/video_timeline_screen.dart';
import 'package:tiktok_clone/utils.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 1;

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onPostVideoButtonTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text("Record video"),
          ),
        ),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);

    return Scaffold(
      resizeToAvoidBottomInset: false, // 키보드 올라와도 리사이즈 되서 찌그러지는 것 방지
      backgroundColor:
          _selectedIndex == 0 || isDark ? Colors.black : Colors.white,
      body: Stack(children: [
        Offstage(
          offstage: _selectedIndex != 0,
          child: const VideoTimelineScreen(),
        ),
        Offstage(
          offstage: _selectedIndex != 1,
          child: const DiscoverScreen(),
        ),
        Offstage(
          offstage: _selectedIndex != 3,
          child: const InboxScreen(),
        ),
        Offstage(
          offstage: _selectedIndex != 4,
          child: const UserProfileScreen(username: '31seul', tab: 'likes'),
        ),
      ]),
      bottomNavigationBar: Container(
        color: Colors.amber,
        constraints: const BoxConstraints(maxWidth: Breakpoints.sm),
        child: BottomAppBar(
          color: _selectedIndex == 0 || isDark ? Colors.black : Colors.white,
          child: Padding(
            padding: const EdgeInsetsDirectional.all(Sizes.size12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NavTab(
                  text: "Home",
                  icon: FontAwesomeIcons.house,
                  selectedIcon: FontAwesomeIcons.house,
                  isSelected: _selectedIndex == 0,
                  onTab: () => _onTap(0),
                  selectedIndex: _selectedIndex,
                ),
                NavTab(
                  text: "Discover",
                  icon: FontAwesomeIcons.compass,
                  selectedIcon: FontAwesomeIcons.solidCompass,
                  isSelected: _selectedIndex == 1,
                  onTab: () => _onTap(1),
                  selectedIndex: _selectedIndex,
                ),
                Gaps.h24,
                GestureDetector(
                  onTap: _onPostVideoButtonTap,
                  child: PostVideoButton(inverted: _selectedIndex != 0),
                ),
                Gaps.h24,
                NavTab(
                  text: "Inbox",
                  icon: FontAwesomeIcons.message,
                  selectedIcon: FontAwesomeIcons.solidMessage,
                  isSelected: _selectedIndex == 3,
                  onTab: () => _onTap(3),
                  selectedIndex: _selectedIndex,
                ),
                NavTab(
                  text: "Profile",
                  icon: FontAwesomeIcons.user,
                  selectedIcon: FontAwesomeIcons.solidUser,
                  isSelected: _selectedIndex == 4,
                  onTab: () => _onTap(4),
                  selectedIndex: _selectedIndex,
                ),
              ],
            ),
          ),
        ),
      ),
    );
    // ios 쿠퍼티노 디자인
    // return CupertinoTabScaffold(
    //   tabBar: CupertinoTabBar(items: const [
    //     BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: "Home"),
    //     BottomNavigationBarItem(
    //         icon: Icon(CupertinoIcons.search), label: "Search"),
    //   ]),
    //   tabBuilder: (context, index) => screens[index],
    // );
    // // 머티리얼 디자인
    // // return Scaffold(
    // //   body: screens[_selectedIndex],
    // //   bottomNavigationBar: NavigationBar(
    // //     destinations: const [
    // //       NavigationDestination(
    // //           icon: FaIcon(FontAwesomeIcons.house), label: "Home"),
    // //       Text("2"),
    // //     ],
    // //   ), // 머티리얼 3 디자인
    // //   // 머티리얼 네비게이션 2?
    // //   // bottomNavigationBar: BottomNavigationBar(
    // //   //   currentIndex: _selectedIndex,
    // //   //   onTap: _onTap,
    // //   //   selectedItemColor: Theme.of(context).primaryColor,
    // //   //   items: const [
    // //   //     BottomNavigationBarItem(
    // //   //         icon: FaIcon(
    // //   //           FontAwesomeIcons.house,
    // //   //         ),
    // //   //         label: "Home",
    // //   //         tooltip: "What are you?"),
    // //   //     BottomNavigationBarItem(
    // //   //         icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
    // //   //         label: "Search",
    // //   //         tooltip: "hihi"),
    // //   //     BottomNavigationBarItem(
    // //   //         icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
    // //   //         label: "Search",
    // //   //         tooltip: "hihi"),
    // //   //     BottomNavigationBarItem(
    // //   //         icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
    // //   //         label: "Search",
    // //   //         tooltip: "hihi"),
    // //   //     BottomNavigationBarItem(
    // //   //         icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
    // //   //         label: "Search",
    // //   //         tooltip: "hihi"),
    // //   //   ],
    // //   // ),
    // // );
  }
}
