import 'package:aos_test/controllers/home_controller.dart';
import 'package:aos_test/views/widgets/product_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeController homeController = Get.put(HomeController());
  int imageIndex = 0;

  @override
  void dispose() {
    super.dispose();
    homeController.init();
  }

  @override
  void initState() {
    super.initState();
    homeController.init();
    homeController.getProduct();
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "MarketPedia",
          style: TextStyle(
            fontSize: 24,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(16),
            child: Icon(
              Icons.notifications_outlined,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Obx(() {
        if (homeController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (homeController.isError.value) {
          return Center(child: Text(homeController.error.value));
        }
        return Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 150.0,
                viewportFraction: 1,
                autoPlay: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    imageIndex = index;
                  });
                },
              ),
              items: [1, 2, 3].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Padding(
                      padding: const EdgeInsets.all(4),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          "assets/png/image_slide.png",
                          height: 150,
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [1, 2, 3].asMap().entries.map<Widget>((e) {
                return Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: imageIndex == e.key ? Colors.black : Colors.grey,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Expanded(
                        child: Text(
                          "Top Categories",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(
                        "View More",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xffff7845),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 14,
                        color: Color(0xffff7845),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 88,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [1, 2, 3, 4, 5, 6].map<Widget>((e) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Container(
                              height: 55,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.grey[350],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  "assets/png/category$e.png",
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  Row(
                    children: const [
                      Expanded(
                        child: Text(
                          "New Arrivals",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(
                        "View More",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xffff7845),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 14,
                        color: Color(0xffff7845),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: homeController.list.length,
                itemBuilder: (context, index) {
                  var e = homeController.list[index];
                  return ProductCard(e: e);
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
