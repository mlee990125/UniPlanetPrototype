import 'package:flutter/rendering.dart';
import 'package:uniplanet_mobile/constants/global_variables.dart';
import 'package:uniplanet_mobile/features/account/screens/account_screen.dart';
import 'package:uniplanet_mobile/features/account/screens/new_account_screen.dart';
import 'package:uniplanet_mobile/features/addProduct/screens/add_product_screen.dart';
import 'package:uniplanet_mobile/features/event/screens/category.dart';
import 'package:uniplanet_mobile/features/chat/screens/chat_layout_screen.dart';
import 'package:uniplanet_mobile/features/home/screens/home_screen.dart';
import 'package:uniplanet_mobile/features/search/screens/search_screen.dart';
import 'package:uniplanet_mobile/providers/user_provider.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniplanet_mobile/repository/user_repo.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home';
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;
  ScrollController? _controller;
  bool _isVisible = true;
  ValueNotifier<double> scaleNotifier = ValueNotifier<double>(1.0);

  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  @override
  void initState() {
    super.initState();

    _controller = ScrollController();
    _controller!.addListener(() {
      if (_controller!.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isVisible == true) {
          setState(() {
            _isVisible = false;
          });
        }
      }
      if (_controller!.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (_isVisible == false) {
          setState(() {
            _isVisible = true;
          });
        }
      }
    });
  }

  void updatePage(int page) {
    if (page == 2) {
      navigateToAddProduct();
      return;
    }
    setState(() {
      _page = page;
    });
  }

  void navigateToSearchScreen() {
    Navigator.pushNamed(context, SearchScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final userLikeLen = UserRepository().getUser.like.length;

    List<Widget> pages = [
      HomeScreen(controller: _controller!),
      const CategoryPage(),
      const AddProductScreen(),
      const ChatList(),
      // const CartScreen(),
      // const AccountScreen(),
      const NewAccountScreen(),
    ];
    return Scaffold(
        body: Stack(
      children: [
        pages[_page],
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          bottom: _isVisible ? -20 : -100,
          left: 0,
          right: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                color: Colors.white,
                padding: _isVisible
                    ? const EdgeInsets.fromLTRB(0, 8, 0, 10)
                    : const EdgeInsets.fromLTRB(0, 8, 0, 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        height: 42,
                        margin: const EdgeInsets.only(left: 15),
                        child: Material(
                          borderRadius: BorderRadius.circular(7),
                          elevation: 1,
                          child: InkWell(
                            // Use InkWell to capture the tap event
                            onTap: () =>
                                navigateToSearchScreen(), // Navigate to search screen on tap
                            child: Container(
                              padding: const EdgeInsets.only(left: 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: Colors.black38, width: 1),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.search,
                                    color: Colors.black54,
                                    size: 23,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Search College Market',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Pulse effect
                        scaleNotifier.value = 1.2; // Increase the scale
                        Future.delayed(Duration(milliseconds: 150), () {
                          scaleNotifier.value = 1.0; // Reset the scale
                          // Show the favorites list page
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.white,
                            builder: (context) {
                              return const FractionallySizedBox(
                                heightFactor: 0.8,
                                child: Center(
                                  child: Text('List of favorited items'),
                                ),
                              );
                            },
                          );
                        });
                      },
                      child: ValueListenableBuilder<double>(
                        valueListenable: scaleNotifier,
                        builder: (context, scale, child) {
                          return Transform.scale(
                            scale: scale,
                            child: Container(
                              color: Colors.white,
                              height: 42,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: 
                                const Icon(Icons.favorite, color: Colors.pink,),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              BottomNavigationBar(
                currentIndex: _page,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: GlobalVariables.selectedNavBarColor,
                unselectedItemColor: GlobalVariables.unselectedNavBarColor,
                backgroundColor: GlobalVariables.backgroundColor,
                iconSize: 28,
                onTap: updatePage,
                items: <BottomNavigationBarItem>[
                  // HOME
                  BottomNavigationBarItem(
                    icon: Container(
                      width: bottomBarWidth,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: _page == 0
                                ? GlobalVariables.selectedNavBarColor
                                : GlobalVariables.backgroundColor,
                            width: bottomBarBorderWidth,
                          ),
                        ),
                      ),
                      child: const Icon(
                        Icons.home_outlined,
                      ),
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Container(
                      width: bottomBarWidth,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: _page == 1
                                ? GlobalVariables.selectedNavBarColor
                                : GlobalVariables.backgroundColor,
                            width: bottomBarBorderWidth,
                          ),
                        ),
                      ),
                      child: const Icon(
                        Icons.menu,
                      ),
                    ),
                    label: '',
                  ),
                  //add
                  BottomNavigationBarItem(
                    icon: SizedBox(
                      width: bottomBarWidth,
                      child: IconButton(
                        onPressed: navigateToAddProduct,
                        icon: const Icon(
                          Icons.add_box_outlined,
                        ),
                      ),
                    ),
                    label: '',
                  ),
                  // CART
                  BottomNavigationBarItem(
                    icon: Container(
                      width: bottomBarWidth,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: _page == 3
                                ? GlobalVariables.selectedNavBarColor
                                : GlobalVariables.backgroundColor,
                            width: bottomBarBorderWidth,
                          ),
                        ),
                      ),
                      child: badges.Badge(
                        badgeContent: Text(userLikeLen.toString()),
                        badgeStyle: const badges.BadgeStyle(
                            badgeColor: Colors.white, elevation: 0),
                        child: const Icon(
                          Icons.chat_bubble_outline,
                        ),
                      ),
                    ),
                    label: '',
                  ),
                  // ACCOUNT
                  BottomNavigationBarItem(
                    icon: Container(
                      width: bottomBarWidth,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: _page == 4
                                ? GlobalVariables.selectedNavBarColor
                                : GlobalVariables.backgroundColor,
                            width: bottomBarBorderWidth,
                          ),
                        ),
                      ),
                      child: const Icon(
                        Icons.person_outline_outlined,
                      ),
                    ),
                    label: '',
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
