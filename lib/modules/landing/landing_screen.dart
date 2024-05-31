import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oshinstar/modules/authentication/screens/email_screen.dart';
import 'package:oshinstar/utils/themes/palette.dart';
import 'package:oshinstar/utils/translation/translation.dart';
import 'package:oshinstar/widgets/carousel.dart';
import 'package:oshinstar/widgets/oshinstar-text-logo-container.dart';
import 'package:websafe_svg/websafe_svg.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> with TranslationMixin {
  List<Map<String, String>>? items;

  @override
  void initState() {
    super.initState();

    items = [
      {
        'title': 'authentication.slider.slide1.title',
        'description': 'authentication.slider.slide1.description',
        'imgSrc': 'assets/slide_1.png',
      },
      {
        'title': 'authentication.slider.slide2.title',
        'description': 'authentication.slider.slide2.description',
        'imgSrc': 'assets/slide_2.png',
      },
      {
        'title': 'authentication.slider.slide3.title',
        'description': 'authentication.slider.slide3.description',
        'imgSrc': 'assets/slide_3.png',
      },
      {
        'title': 'authentication.slider.slide4.title',
        'description': 'authentication.slider.slide4.description',
        'imgSrc': 'assets/slide_4.png',
      },
      {
        'title': 'authentication.slider.slide5.title',
        'description': 'authentication.slider.slide5.description',
        'imgSrc': 'assets/slide_5.png',
      }
    ];
  }

  // Build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextButton(
          onPressed: null,
          child: Text(
            'English',
            style: TextStyle(
              fontSize: 20,
              color: OshinPalette.blue,
            ),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: WebsafeSvg.asset('assets/oshinstar-logo-small.svg'),
          onPressed: () => null,
        ),
      ),
      body: Column(

        children: [
          const SizedBox(height: 40),
          Image.asset(
            "assets/oshinstar-text-logo.png",
            width: 200,
          ),
          const SizedBox(height: 100),
          Carrousel(
            items: items != null
                ? items!
                    .map(
                      (item) => CarrouselItem(
                          title: t(item['title']!),
                          description: t(item['description'] ?? ""),
                          imgSrc: item['imgSrc'] ?? ""),
                    )
                    .toList()
                : [],
            autoPlay: true,
          ),
          const Spacer(),
          SafeArea(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => EmailScreenSignup())),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      OshinPalette.blue, // Blue color for the button
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: Text("Sign Up"),
              ),
            ),
          ),
        ],
      ),
      endDrawer: Text("yuh"),
    );
  }
}
