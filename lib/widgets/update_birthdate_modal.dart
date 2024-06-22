import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oshinstar/cubits/cubits.dart';
import 'package:oshinstar/modules/authentication/api/authentication.dart';
import 'package:oshinstar/utils/themes/palette.dart';
import 'package:intl/intl.dart';
import 'package:oshinstar/widgets/error_snackbar.dart';

class EditBirthdayModal extends StatefulWidget {
  const EditBirthdayModal({Key? key}) : super(key: key);

  @override
  _EditBirthdayModalState createState() => _EditBirthdayModalState();
}

class _EditBirthdayModalState extends State<EditBirthdayModal> {
  int? _selectedDay;
  String? _selectedMonth;
  int? _selectedYear;

  @override
  void initState() {
    super.initState();
    final user = context.read<UserCubit>().state;
    DateTime birthdate = DateTime.parse(user['birthdate']);

    _selectedDay = birthdate.day;
    _selectedMonth = DateFormat.MMMM().format(birthdate);
    _selectedYear = birthdate.year;
  }

  String parseMonth(String month) {
    final months = {
      'January': '01',
      'February': '02',
      'March': '03',
      'April': '04',
      'May': '05',
      'June': '06',
      'July': '07',
      'August': '08',
      'September': '09',
      'October': '10',
      'November': '11',
      'December': '12'
    };
    return months[month]!;
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserCubit>().state;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
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
                    'Edit Birthday',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const Divider(height: 1),
            const SizedBox(height: 8),
            // Note
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Please note:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'You can change your birthday 1 more time, after that you must contact OshinStar team to change it again.',
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'More Information',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            const SizedBox(height: 16),
            // Birthday Input
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    DropdownButton<int>(
                      value: _selectedDay,
                      items: List.generate(31, (index) => index + 1)
                          .map((day) => DropdownMenuItem<int>(
                                value: day,
                                child: Text(day.toString().padLeft(2, '0')),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedDay = value;
                        });
                      },
                    ),
                  ],
                ),
                Column(
                  children: [
                    DropdownButton<String>(
                      value: _selectedMonth,
                      items: const [
                        'January',
                        'February',
                        'March',
                        'April',
                        'May',
                        'June',
                        'July',
                        'August',
                        'September',
                        'October',
                        'November',
                        'December',
                      ]
                          .map((month) => DropdownMenuItem<String>(
                                value: month,
                                child: Text(month),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedMonth = value;
                        });
                      },
                    ),
                  ],
                ),
                Column(
                  children: [
                    DropdownButton<int>(
                      value: _selectedYear,
                      items: List.generate(100, (index) => 2024 - index)
                          .map((year) => DropdownMenuItem<int>(
                                value: year,
                                child: Text(year.toString()),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedYear = value;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),
            // Update Button
            ElevatedButton(
              onPressed: () async {
                if (_selectedDay != null &&
                    _selectedMonth != null &&
                    _selectedYear != null) {
                  final formattedMonth = parseMonth(_selectedMonth!);
                  final formattedBirthdate =
                      "$_selectedYear-$formattedMonth-${_selectedDay.toString().padLeft(2, '0')}T00:00:00.000Z";
                  
                  await AuthenticationApi.updateBirthdate({
                    "userId": user["userId"],
                    "day": _selectedDay,
                    "month": _selectedMonth,
                    "year": _selectedYear
                  });

                  context.read<UserCubit>().setUserInfo({
                    "canUpdateBirthdate": false,
                    "birthdate": formattedBirthdate
                  });

                  Navigator.pop(context);
                  showSuccessSnackbar(context, "Birthdate successfully updated.");
                }
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                  backgroundColor: OshinPalette.blue,
                  foregroundColor: OshinPalette.white),
              child: const Text('UPDATE'),
            ),
          ],
        ),
      ),
    );
  }
}
