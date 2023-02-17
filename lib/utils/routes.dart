import 'package:aos_test/views/main_menu.dart';
import 'package:aos_test/views/product/cart.dart';
import 'package:get/get.dart';

List<GetPage<dynamic>>? getPages = [
  GetPage(
    name: "/main_menu",
    page: () => const MainMenu(),
    transition: Transition.zoom,
    transitionDuration: const Duration(milliseconds: 1500),
  ),
  GetPage(
    name: "/cart",
    page: () => const Cart(),
    transition: Transition.zoom,
    transitionDuration: const Duration(milliseconds: 500),
  ),
];
