import 'package:astrofuseui/api/homepage_apis.dart';
import 'package:astrofuseui/components/constants.dart';
import 'package:astrofuseui/model/astrologers_model.dart';
import 'package:astrofuseui/model/blog_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = CarouselController();
  int _current = 0;
  final homepageApi = HomePageApis();
  List<String> bannerImages = [];
  List<BlogModel> blogList = [];
  List<AstroModel> astroList = [];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([
          homepageApi.getImageBanner(),
          homepageApi.getAstrologers(),
          homepageApi.getBlogs(),
        ]),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('There is some Error in HomePage'),
            );
          }
          if (snapshot.hasData) {
            bannerImages = snapshot.data[0];
            astroList = snapshot.data[1];
            blogList = snapshot.data[2];
            return Scaffold(
              backgroundColor:
                  const Color.fromARGB(255, 241, 241, 241).withOpacity(0.2),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: _imageWidget(),
                    ),
                    Expanded(
                      flex: 5,
                      child: _astrologersWidget(),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      flex: 5,
                      child: _blogWidgets(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    _buttonsWidget(),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: Text('Loading please wait.....'),
            );
          }
        });
  }

  _imageWidget() {
    return SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Card(
          surfaceTintColor: Colors.white,
          elevation: 5,
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
          child: Stack(
            alignment: Alignment.center,
            fit: StackFit.expand,
            children: [
              CarouselSlider(
                items: imageSliders(),
                carouselController: _controller,
                options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 1.0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
              ),
              Positioned(
                bottom: 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: bannerImages.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => _controller.animateToPage(entry.key),
                      child: Container(
                        width: 8.0,
                        height: 8.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _current == entry.key
                                ? appcolor.withOpacity(0.9)
                                : Colors.grey.withOpacity(0.9)),
                      ),
                    );
                  }).toList(),
                ),
              )
            ],
          ),
        ));
  }

  imageSliders() {
    return bannerImages
        .map((item) => Container(
              margin: const EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  item,
                  fit: BoxFit.cover,
                  width: MediaQuery.sizeOf(context).width,
                ),
              ),
            ))
        .toList();
  }

  _astrologersWidget() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3), color: Colors.white),
      padding: const EdgeInsets.only(
        left: 5,
        right: 5,
        bottom: 5,
        top: 15,
      ),
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        children: [
          _header('Astrologers', null),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              spacing: 5,
              children: astroList.map((item) => _astroCard(item)).toList(),
            ),
          )
        ],
      ),
    );
  }

  _blogWidgets() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3), color: Colors.white),
      padding: const EdgeInsets.only(
        left: 5,
        right: 5,
        bottom: 10,
        top: 15,
      ),
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header('Latest from blog', null),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              spacing: 8,
              children: blogList.map((item) => _blogCard(item)).toList(),
            ),
          )
        ],
      ),
    );
  }

  _buttonsWidget() {
    return Row(
      //mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: _button(Icons.messenger, ' Chat with Astrologers'),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: _button(Icons.call, ' Call with Astrologers'),
        ),
      ],
    );
  }

  _header(String text, Function()? onTap) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
          ),
          GestureDetector(
            onTap: onTap,
            child: const Text(
              'View All',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          )
        ],
      );
  Widget _blogCard(BlogModel item) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width / 2,
      child: Card(
        surfaceTintColor: Colors.white,
        elevation: 5,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    '$imgbaseUrl/${item.blogImage.endsWith('.mp4') ? item.previewImage : item.blogImage}',
                    fit: BoxFit.cover,
                    width: MediaQuery.sizeOf(context).width / 2,
                    height: 100,
                  )),
              Positioned(
                  top: 5,
                  right: 5,
                  child: Card(
                      color: Colors.white.withOpacity(0.7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 5.0, bottom: 5.0, left: 10, right: 10),
                        child: Row(
                          children: [
                            const Icon(Icons.visibility),
                            Text(' ${item.views}',
                                style: const TextStyle(fontSize: 18)),
                          ],
                        ),
                      )))
            ]),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(item.blogname,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 16)),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item.authorName,
                    style: TextStyle(color: Colors.grey.shade400),
                  ),
                  Text(
                    formatDate(item.date),
                    style: TextStyle(color: Colors.grey.shade400),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _astroCard(AstroModel item) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width / 3,
      child: Card(
        surfaceTintColor: Colors.white,
        elevation: 5,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width / 3,
              height: 85,
              margin: const EdgeInsets.only(top: 5, left: 18, right: 18),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: const Color.fromARGB(255, 205, 174, 0))),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: item.astrologerImage == 'null'
                      ? const Icon(Icons.people)
                      : Image.network(
                          '$imgbaseUrl/${item.astrologerImage}',
                          fit: BoxFit.cover,
                          width: MediaQuery.sizeOf(context).width / 3,
                          height: 85,
                        )),
            ),
            Text(
              item.astrologerName,
            ),
            Text(
              '₹ ${item.charge}/min',
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: OutlinedButton(
                onPressed: () {},
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(const EdgeInsets.only(
                      left: 18,
                      right: 18,
                    )),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    )),
                    side: MaterialStateProperty.all(
                        const BorderSide(color: Colors.green))),
                child: const Text(
                  'Connect',
                  style: TextStyle(color: Colors.green, letterSpacing: 1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ElevatedButton _button(IconData icon, String text) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(appcolor),
            padding: MaterialStateProperty.all(
                const EdgeInsets.only(left: 16, right: 16)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)))),
        onPressed: () async {},
        child: Wrap(
          children: [
            Icon(
              icon,
              color: Colors.black,
              size: 20,
            ),
            Text(text, style: const TextStyle(color: Colors.black)),
          ],
        ));
  }
}
