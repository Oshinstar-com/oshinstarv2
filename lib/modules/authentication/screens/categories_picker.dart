import 'package:flutter/material.dart';
import 'package:oshinstar/helpers/hive.dart';
import 'package:oshinstar/modules/home/screens/home.dart';
import 'package:oshinstar/utils/themes/palette.dart';
import 'package:oshinstar/widgets/error_snackbar.dart';
import 'package:websafe_svg/websafe_svg.dart';

class CategoriesPickerPage extends StatelessWidget {
  const CategoriesPickerPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Create a GlobalKey for the CategoryListState
    final GlobalKey<_CategoryListState> categoryListKey =
        GlobalKey<_CategoryListState>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [Icon(Icons.exit_to_app)],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: CategoriesView(categoryListKey: categoryListKey),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
            child: ElevatedButton(
              onPressed: () => {},
              style: ElevatedButton.styleFrom(
                foregroundColor: OshinPalette.blue,
                backgroundColor: Colors.white,
                shadowColor: Colors.transparent,
                elevation: 0,
              ),
              child: const Text('Skip for now'),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
            child: ElevatedButton(
              onPressed: () {
                final selectedCategories =
                    categoryListKey.currentState?._selectedCategories;
                if (selectedCategories != null) {
                  print(selectedCategories);
                  Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
                } else {
                  print("No categories selected.");
                }
              },
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

class CategoriesView extends StatefulWidget {
  final GlobalKey<_CategoryListState> categoryListKey;

  const CategoriesView({super.key, required this.categoryListKey});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  List<Map<String, dynamic>> _industries = [];

  @override
  void initState() {
    super.initState();
    readIndustries();
  }

  void readIndustries() async {
    final appDataHiveManager = AppDataHiveManager();
    await appDataHiveManager.initBox('appData');

    final industries = await appDataHiveManager.read('industries') as List?;
    if (industries != null) {
      setState(() {
        _industries.addAll(List<Map<String, dynamic>>.from(industries));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Passing the GlobalKey to the CategoryList widget
    return Column(
      children: [
        const Text(
          'What industry are you engaged in?',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Choose one or more categories to showcase all the amazing things you know how to do.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ),
        const SizedBox(height: 20),
        _industries.isEmpty
            ? const CircularProgressIndicator()
            : CategoryList(
                key: widget.categoryListKey, // Assign the GlobalKey here
                industries: _industries,
              ),
      ],
    );
  }
}

class CategoryList extends StatefulWidget {
  final List<Map<String, dynamic>> industries;

  const CategoryList({super.key, required this.industries});

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  List<Map<String, String>> _selectedCategories = [];

  List<Map<String, String>> get selectedCategories => _selectedCategories;

  void _toggleCategory(Map<String, String> category) {
    setState(() {
      if (_selectedCategories.contains(category)) {
        _selectedCategories.remove(category);
      } else {
        if (_selectedCategories.length >= 3) {
          showErrorSnackbar(context, "You can select up to 3 categories");
        } else {
          _selectedCategories.add(category);
        }
      }
    });
  }

  void _removeCategory(Map<String, String> category) {
    setState(() {
      _selectedCategories.remove(category);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Display selected categories on top
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: _selectedCategories.map((category) {
              return Chip(
                label: Text(category['name']!),
                backgroundColor: Colors.red[100],
                deleteIcon: const Icon(Icons.close),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onDeleted: () => _removeCategory(category),
              );
            }).toList(),
          ),
        ),
        // Display industries with categories in dropdowns
        ...widget.industries.map((industry) {
          return widget.industries.isEmpty
              ? const Text("Empty Industries")
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.blue)),
                    child: ExpansionTile(
                      backgroundColor: Colors.white,
                      collapsedBackgroundColor: Colors.white,
                      leading: WebsafeSvg.asset(
                          "assets/industries/beauty-and-fashion.svg"),
                      tilePadding: const EdgeInsets.symmetric(horizontal: 16.0),
                      title: Text(industry['name']!),
                      trailing: const Icon(Icons.arrow_drop_down),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children: industry['categories']
                                .map<Widget>((category) => GestureDetector(
                                      onTap: () => _toggleCategory({
                                        'name': category['name'],
                                        'slug': category['slug'],
                                      }),
                                      child: Chip(
                                        label: Text(category['name']),
                                        backgroundColor:
                                            _selectedCategories.contains({
                                          'name': category['name'],
                                          'slug': category['slug'],
                                        })
                                                ? OshinPalette.blue
                                                : Colors.grey[300],
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
        }),
      ],
    );
  }
}
