import 'package:oshinstar/helpers/http.dart';

abstract class InitialApi {
  static Future<Map<String, dynamic>> fetchInitialData() async {
    // final response = await Http.get('v1/initial');

    // return response;

    return {
      "industries": [
        {
          "name": "Beauty & Fashion",
          "slug": "beauty-and-fashion",
          "asset": "",
          "categories": [
            {"name": "category 1", "slug": "category-1-slug"},
            {"name": "category 1", "slug": "category-1-slug"}
          ]
        },
        {
          "name": "Beauty & Fashion",
          "slug": "beauty-and-fashion",
          "asset": "",
          "categories": [
            {"name": "category 1", "slug": "category-1-slug"},
            {"name": "category 1", "slug": "category-1-slug"}
          ]
        },
        {
          "name": "Beauty & Fashion",
          "slug": "beauty-and-fashion",
          "asset": "",
          "categories": [
            {"name": "category 1", "slug": "category-1-slug"},
            {"name": "category 1", "slug": "category-1-slug"}
          ]
        },
      ],
    };
  }
}
