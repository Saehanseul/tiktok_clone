import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/settings/screens/settings_screen.dart';
import 'package:tiktok_clone/features/users/view_models/users_view_model.dart';
import 'package:tiktok_clone/features/users/views/widgets/avatar.dart';
import 'package:tiktok_clone/features/users/views/widgets/persistent_tab_bar.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  final String username;
  final String tab;

  const UserProfileScreen(
      {super.key, required this.username, required this.tab});

  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  void _onEditPressed() {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text("Edit profile"),
        content: const CupertinoTextField(),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          CupertinoDialogAction(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _onGearPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(usersProvider).when(
        error: (error, StackTrace) => Center(
              child: Text(error.toString()),
            ),
        loading: () =>
            const Center(child: CircularProgressIndicator.adaptive()),
        data: (data) {
          return Scaffold(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            body: SafeArea(
              child: DefaultTabController(
                initialIndex: widget.tab == "likes" ? 1 : 0,
                length: 2,
                child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      // SliverAppBar(
                      //   // floating: true,
                      //   stretch: true,
                      //   // snap: true,
                      //   pinned: true,
                      //   backgroundColor: Colors.teal,
                      //   title: const Text("Profile"),
                      //   collapsedHeight: 80,
                      //   expandedHeight: 200,
                      //   flexibleSpace: FlexibleSpaceBar(
                      //       stretchModes: const [
                      //         StretchMode.blurBackground,
                      //         StretchMode.fadeTitle,
                      //         StretchMode.zoomBackground,
                      //       ],
                      //       background: Image.asset("assets/images/ocean.jpeg"),
                      //       title: const Text("Flexible")),
                      // ),
                      // const SliverToBoxAdapter(
                      //   child: Column(
                      //     children: [
                      //       CircleAvatar(
                      //         foregroundColor: Colors.yellow,
                      //       )
                      //     ],
                      //   ),
                      // ),
                      // SliverFixedExtentList(
                      //   delegate: SliverChildBuilderDelegate(
                      //     childCount: 50,
                      //     (context, index) => Container(
                      //       color: Colors.teal[100 * (index % 9)],
                      //       child: Text("Item $index"),
                      //     ),
                      //   ),
                      //   itemExtent: 100,
                      // ),
                      // SliverPersistentHeader(
                      //   delegate: CustomDelegate(),
                      //   pinned: true,
                      // ),
                      // SliverGrid(
                      //   delegate: SliverChildBuilderDelegate(
                      //     childCount: 50,
                      //     (context, index) => Container(
                      //       color: Colors.teal[100 * (index % 9)],
                      //       child: Text("Item $index"),
                      //     ),
                      //   ),
                      //   gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      //     maxCrossAxisExtent: 100,
                      //     mainAxisSpacing: Sizes.size20,
                      //     crossAxisSpacing: Sizes.size20,
                      //     childAspectRatio: 1,
                      //   ),
                      // ),
                      SliverAppBar(
                        title: Text(data.name),
                        actions: [
                          IconButton(
                            onPressed: _onEditPressed,
                            icon: const FaIcon(
                              FontAwesomeIcons.penToSquare,
                              size: Sizes.size20,
                            ),
                          ),
                          IconButton(
                            onPressed: _onGearPressed,
                            icon: const FaIcon(
                              FontAwesomeIcons.gear,
                              size: Sizes.size20,
                            ),
                          ),
                        ],
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            Gaps.v20,
                            Avatar(
                              uid: data.uid,
                              name: data.name,
                              hasAvatar: data.hasAvatar,
                            ),
                            Gaps.v20,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "@${data.name}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: Sizes.size18,
                                  ),
                                ),
                                Gaps.h5,
                                FaIcon(
                                  FontAwesomeIcons.solidCircleCheck,
                                  size: Sizes.size16,
                                  color: Colors.blue.shade500,
                                ),
                              ],
                            ),
                            Gaps.v24,
                            SizedBox(
                              height: Sizes.size48,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "97",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: Sizes.size18,
                                        ),
                                      ),
                                      Gaps.v5,
                                      Text(
                                        "Following",
                                        style: TextStyle(
                                          color: Colors.grey.shade500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  VerticalDivider(
                                    width: Sizes.size32,
                                    thickness: Sizes.size1,
                                    color: Colors.grey.shade500,
                                    indent: Sizes.size14,
                                    endIndent: Sizes.size14,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "10M",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: Sizes.size18,
                                        ),
                                      ),
                                      Gaps.v5,
                                      Text(
                                        "Followers",
                                        style: TextStyle(
                                          color: Colors.grey.shade500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  VerticalDivider(
                                    width: Sizes.size32,
                                    thickness: Sizes.size1,
                                    color: Colors.grey.shade500,
                                    indent: Sizes.size14,
                                    endIndent: Sizes.size14,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "194.3M",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: Sizes.size18,
                                        ),
                                      ),
                                      Gaps.v3,
                                      Text(
                                        "Likes",
                                        style: TextStyle(
                                          color: Colors.grey.shade500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Gaps.v14,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Flexible(
                                  child: FractionallySizedBox(
                                    widthFactor: 0.43,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: Sizes.size12,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(Sizes.size4),
                                        ),
                                      ),
                                      child: const Text(
                                        "Follow",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                                Gaps.h4,
                                Container(
                                  width: Sizes.size40 + Sizes.size2,
                                  height: Sizes.size40 + Sizes.size2,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(Sizes.size4),
                                    ),
                                    border: Border.all(
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                  child: const FaIcon(
                                    FontAwesomeIcons.youtube,
                                    size: Sizes.size20,
                                  ),
                                ),
                                Gaps.h4,
                                Container(
                                  width: Sizes.size40 + Sizes.size2,
                                  height: Sizes.size40 + Sizes.size2,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(Sizes.size4),
                                    ),
                                    border: Border.all(
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                  child: const FaIcon(
                                    FontAwesomeIcons.caretDown,
                                    size: Sizes.size20,
                                  ),
                                ),
                              ],
                            ),
                            Gaps.v14,
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: Sizes.size32,
                              ),
                              child: Text(
                                "All highlights and where to watch live matches on FIFA+I wonder how it would loook",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Gaps.v14,
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.link,
                                  size: Sizes.size12,
                                ),
                                Gaps.h4,
                                Text(
                                  "https://nomadcoders.co",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Gaps.v20,
                          ],
                        ),
                      ),
                      SliverPersistentHeader(
                        delegate: PersistentTabBar(),
                        pinned: true,
                      ),
                    ];
                  },
                  body: TabBarView(
                    children: [
                      GridView.builder(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        itemCount: 20,
                        padding: EdgeInsets.zero,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: Sizes.size2,
                          mainAxisSpacing: Sizes.size2,
                          childAspectRatio: 9 / 14,
                        ),
                        itemBuilder: (context, index) => Column(
                          children: [
                            Stack(
                              children: [
                                AspectRatio(
                                  aspectRatio: 9 / 14,
                                  child: ColorFiltered(
                                    colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.2),
                                      BlendMode.srcOver,
                                    ),
                                    child: FadeInImage.assetNetwork(
                                      placeholder: "assets/images/ocean.jpeg",
                                      image:
                                          "https://img1.daumcdn.net/thumb/R800x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2F6CEcF%2FbtqxVzYzsYJ%2FhW9z8hX5DgILkKPk8AYr70%2Fimg.png",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const Positioned(
                                  bottom: 0,
                                  child: Padding(
                                    padding: EdgeInsets.all(Sizes.size5),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.play,
                                          size: Sizes.size12,
                                          color: Colors.white,
                                        ),
                                        Gaps.h6,
                                        Text(
                                          "4.1M",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Center(
                        child: Text("Page two"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

// class CustomDelegate extends SliverPersistentHeaderDelegate {
//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return Container(
//       color: Colors.indigo,
//       child: const FractionallySizedBox(
//         heightFactor: 1,
//         child: Center(
//           child: Text(
//             "Title",
//             style: TextStyle(
//               color: Colors.white,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   double get maxExtent => 150;

//   @override
//   double get minExtent => 80;

//   @override
//   bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
//     // throw UnimplementedError();
//     return false;
//   }
// }
