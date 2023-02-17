import 'package:aos_test/views/history.dart';
import 'package:aos_test/views/home.dart';
import 'package:aos_test/views/product/cart.dart';
import 'package:aos_test/views/search.dart';
import 'package:aos_test/views/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int pages = 0;
  PageController controller = PageController(
    initialPage: 0,
  );
  _menu({required IconData icon, required String menu, required int page}) {
    return InkWell(
      onTap: () {
        setState(() {
          pages = page;
          controller.animateToPage(
            pages,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: pages == page ? const Color(0xffff7845) : Colors.white,
          ),
          Text(
            menu,
            style: TextStyle(
              color: pages == page ? const Color(0xffff7845) : Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: controller,
        onPageChanged: (v) {
          setState(() {
            pages = v;
          });
        },
        children: const [
          Home(),
          Search(),
          History(),
          User(),
        ],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        child: BottomAppBar(
          notchMargin: 8,
          color: Colors.black,
          shape: const CircularNotchedRectangle(),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _menu(icon: Icons.home_outlined, menu: "Home", page: 0),
                _menu(icon: Icons.search_outlined, menu: "Search", page: 1),
                const SizedBox(width: 16),
                _menu(icon: Icons.article_outlined, menu: "History", page: 2),
                _menu(icon: Icons.person_outline, menu: "User", page: 3),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () => Get.toNamed("/cart"),
        child: const Icon(Icons.shopping_cart_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
