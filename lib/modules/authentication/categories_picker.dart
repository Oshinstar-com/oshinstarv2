import 'package:flutter/material.dart';
import 'package:oshinstar/utils/themes/palette.dart';
import 'package:websafe_svg/websafe_svg.dart';

class CategoriesPickerPage extends StatelessWidget {
  const CategoriesPickerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.exit_to_app),
        ),
      ),
      body: Column(
        children: [
          const Expanded(
            child: SingleChildScrollView(
              child: CategoriesView(),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
            child: ElevatedButton(
              onPressed: () => {},
              style: ElevatedButton.styleFrom(
                foregroundColor: OshinPalette.white,
                backgroundColor: OshinPalette.blue,
              ),
              child: const Text('Skip for now'),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
            child: ElevatedButton(
              onPressed: () => {},
              style: ElevatedButton.styleFrom(
                foregroundColor: OshinPalette.white,
                backgroundColor: OshinPalette.blue,
              ),
              child: const Text('Continue'),
            ),
          )
        ],
      ),
    );
  }
}

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'What industry are you engaged in?',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Choose one or more categories to showcase all the amazing things you know how to do.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search categories',
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        SizedBox(height: 20),
        CategoryList(),
      ],
    );
  }
}

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      children: List.generate(
        8,
        (index) => categoryItem(
          title: 'Industry $index',
          category: Categories.values[index],
        ),
      ),
    );
  }
}

ExpansionPanel categoryItem({
  required String title,
  required Categories category,
}) =>
    ExpansionPanel(
      isExpanded: num.parse(title.split(' ').last).toInt().isEven,
      body: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: List.generate(
          8,
          (index) {
            final subcategory = 'Category $index';
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Chip(
                label: Text(subcategory),
              ),
            );
          },
        ),
      ),
      headerBuilder: (context, isOpen) {
        return ListTile(
          leading: CircleAvatar(
            child: WebsafeSvg.asset(
              category.getImagePath(),
            ),
          ),
          title: Text(title),
        );
      },
    );

enum Categories {
  beautyFashion,
  musicDance,
  filmTvEntertainment,
  sportsRecreations,
  otherArts,
  foodsDrinks,
  education,
  businessTechnology;

  const Categories();

  String getImagePath() {
    switch (this) {
      case Categories.beautyFashion:
        return 'assets/industries/beauty-and-fashion.svg';
      case Categories.musicDance:
        return 'assets/industries/music-dance.svg';
      case Categories.filmTvEntertainment:
        return 'assets/industries/film-tv-entertainment.svg';
      case Categories.sportsRecreations:
        return 'assets/industries/sports-recreations.svg';
      case Categories.otherArts:
        return 'assets/industries/other-arts.svg';
      case Categories.foodsDrinks:
        return 'assets/industries/foods-drinks.svg';
      case Categories.education:
        return 'assets/industries/education.svg';
      case Categories.businessTechnology:
        return 'assets/industries/business-technology.svg';
    }
  }
}
