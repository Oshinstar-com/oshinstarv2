import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:oshinstar/cubits/cubits.dart';
import 'dart:convert';

import 'package:oshinstar/modules/authentication/api/authentication.dart';

class LocationSearchModal extends StatefulWidget {
  const LocationSearchModal({Key? key}) : super(key: key);

  @override
  _LocationSearchModalState createState() => _LocationSearchModalState();
}

class _LocationSearchModalState extends State<LocationSearchModal> {
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

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                const Expanded(
                  child: Text(
                    "Where do you currently live?",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const Divider(height: 1),
            const SizedBox(height: 50),
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
                        ? Container()
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
      
                  context
                      .read<UserCubit>()
                      .setUserInfo({"location": _controller.text ?? ""});
      
                  Navigator.of(context).pop();
                },
                child: const Text("Continue"))
          ],
        ),
      ),
    );
  }
}
