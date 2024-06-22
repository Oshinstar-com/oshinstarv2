import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:oshinstar/cubits/cubits.dart';
import 'package:oshinstar/helpers/router.dart';
import 'dart:convert';

import 'package:oshinstar/modules/authentication/api/authentication.dart';
import 'package:oshinstar/modules/authentication/screens/categories_picker.dart';
import 'package:oshinstar/utils/themes/palette.dart';

class LocationSearchScreen extends StatefulWidget {
  @override
  _LocationSearchScreenState createState() => _LocationSearchScreenState();
}

class _LocationSearchScreenState extends State<LocationSearchScreen> {
  TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> _locations = [];
  bool _isLoading = false;
  String? _error;

  Future<void> _fetchLocations(String query) async {
    if (query.isEmpty) {
      setState(() {
        _locations = [];
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final response = await http.get(
          Uri.parse('https://geolocator.oshinstar.com/search?query=$query'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _locations = List<Map<String, dynamic>>.from(data);
          _isLoading = false;
        });
      } else {
        setState(() {
          _locations = [];
          _isLoading = false;
          _error = 'Error: ${response.statusCode} ${response.reasonPhrase}';
        });
      }
    } catch (e) {
      setState(() {
        _locations = [];
        _isLoading = false;
        _error = 'Failed to fetch locations: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserCubit>().state;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Location"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Implement logout functionality here
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "We use your location to offer you the best possible connections close to you.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              "Where do you currently live?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Search your city",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (query) {
                _fetchLocations(query);
              },
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _error != null
                    ? Center(child: Text(_error!))
                    : _locations.isEmpty
                        ? const Center(child: Text("No locations found"))
                        : Expanded(
                            child: ListView.builder(
                              itemCount: _locations.length,
                              itemBuilder: (context, index) {
                                final location = _locations[index];
                                return ListTile(
                                  title: Text(location['city_ascii']),
                                  subtitle: Text('${location['country']}'),
                                  onTap: () {
                                    setState(() {
                                      _controller.text =
                                          "${location['city_ascii']}, ${location['country']}";
                                      _locations = [
                                        {
                                          "city_ascii": location['city_ascii'],
                                          "country": location["country"]
                                        }
                                      ];
                                    });
                                  },
                                );
                              },
                            ),
                          ),
            ElevatedButton(
                onPressed: () async {
                  await AuthenticationApi.updateUser(
                      {"userId": user["userId"], "location": _controller.text});

                  AppRouter.route(context, const CategoriesPickerPage());
                },
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: OshinPalette.blue),
                child: const Text("Continue"))
          ],
        ),
      ),
    );
  }
}
