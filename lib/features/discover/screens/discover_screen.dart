import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/breakpoints.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/utils.dart';

final tabs = [
  "Top",
  "Users",
  "Videos",
  "Sounds",
  "LIVE",
  "Shopping",
  "Brands",
];

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  void _onSearchChanged(String value) {
    print(value);
  }

  void _onSearchSubmitted(String value) {
    print(value);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 1,
          title: ConstrainedBox(
            //Container도 constraints 사용할 수 있음
            constraints: const BoxConstraints(maxWidth: Breakpoints.sm),
            child: CupertinoSearchTextField(
              controller: TextEditingController(),
              onChanged: _onSearchChanged,
              onSubmitted: _onSearchSubmitted,
              style: TextStyle(
                color: isDarkMode(context) ? Colors.white : Colors.black,
              ),
            ),
          ),
          bottom: TabBar(
            onTap: (value) {
              FocusScope.of(context).unfocus();
            },
            splashFactory: NoSplash.splashFactory,
            isScrollable: true,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Sizes.size16,
            ),
            indicatorColor: Theme.of(context).tabBarTheme.indicatorColor,
            tabs: [for (var tab in tabs) Tab(text: tab)],
          ),
        ),
        body: TabBarView(
          children: [
            GridView.builder(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.all(
                Sizes.size6,
              ),
              itemCount: 20,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: width > Breakpoints.lg ? 5 : 2,
                crossAxisSpacing: Sizes.size10,
                mainAxisSpacing: Sizes.size10,
                childAspectRatio: 9 / 21,
              ),
              itemBuilder: (context, index) => LayoutBuilder(
                builder: (context, constraints) => Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 9 / 16,
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Sizes.size4),
                        ),
                        child: FadeInImage.assetNetwork(
                          placeholder: "assets/images/ocean.jpeg",
                          image:
                              "https://img1.daumcdn.net/thumb/R800x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2F6CEcF%2FbtqxVzYzsYJ%2FhW9z8hX5DgILkKPk8AYr70%2Fimg.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Gaps.v10,
                    const Text(
                      "Longgggg textttttttt titleeeeee hahahahahah hohohohho ",
                      style: TextStyle(
                        fontSize: Sizes.size16 + Sizes.size2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Gaps.v8,
                    DefaultTextStyle(
                      style: TextStyle(
                        color: isDarkMode(context)
                            ? Colors.grey.shade300
                            : Colors.grey.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 12,
                            backgroundImage: NetworkImage(
                                "https://avatars.githubusercontent.com/u/25199891?v=4"),
                          ),
                          Gaps.h4,
                          const Expanded(
                            child: Text(
                              "Myavatar is going to be very long",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Gaps.h4,
                          FaIcon(
                            FontAwesomeIcons.heart,
                            size: Sizes.size16,
                            color: Colors.grey.shade600,
                          ),
                          Gaps.h2,
                          const Text(
                            "2.5M",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            for (var tab in tabs.skip(1))
              Center(
                  child: Text(tab,
                      style: const TextStyle(
                        fontSize: Sizes.size28,
                      )))
          ],
        ),
      ),
    );
  }
}
