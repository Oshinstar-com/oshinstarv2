part of 'settings.dart';

class ManageAccountScreen extends StatelessWidget {
  const ManageAccountScreen({super.key});

  Map<String, dynamic> formatDateAndCalculateYears(String dateStr) {
    // Parse the date string
    DateTime parsedDate = DateTime.parse(dateStr);

    // Format the date to 'dd MMM, yyyy'
    String formattedDate = DateFormat('dd MMM, yyyy').format(parsedDate);

    // Calculate the number of years from the parsed date to the current date
    DateTime currentDate = DateTime.now();
    int years = currentDate.year - parsedDate.year;

    // Adjust for the case where the current date is before the anniversary of the parsed date
    if (currentDate.month < parsedDate.month ||
        (currentDate.month == parsedDate.month &&
            currentDate.day < parsedDate.day)) {
      years--;
    }

    // Return the formatted date and years as a map
    return {'date': formattedDate, 'years': years};
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserCubit>().state;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Account"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 50,
              color: Colors.grey[300],
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: const Row(
                children: [Text("Basic Info")],
              ),
            ),
            ListTile(
              title: Text(
                "${user['firstName']} ${user["lastName"]}",
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.alternate_email),
              title: Text(user['email']),
              subtitle: user['isEmailVerified']
                  ? null
                  : const Text(
                      "(Not verified) Click here to re-send the code",
                      style: TextStyle(color: Colors.blue),
                    ),
              onTap: () => showDialog(
                context: context,
                builder: (context) =>
                    VerifyEmailModal(verified: user['isEmailVerified']),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.key),
              title: const Text("Password"),
              subtitle: const Text("*************"),
              onTap: () => AppRouter.route(context, const ChangePasswordModal())
            ),
            ListTile(
              leading: const Icon(Icons.contacts),
              title: const Text("Phone Numbers"),
              subtitle: Text(user["phone"]),
              onTap: () => showDialog(
                  context: context, builder: (_) => const PhoneNumbersModal()),
            ),
            ListTile(
              leading: const Icon(Icons.male),
              title: const Text("Gender"),
              subtitle: Text(user["gender"]),
              onTap: () =>
                  showErrorSnackbar(context, "Gender can't be changed."),
            ),
            ListTile(
              leading: const Icon(Icons.cake),
              title:
                  Text(formatDateAndCalculateYears(user["birthdate"])['date']),
              subtitle: Text(
                  "${formatDateAndCalculateYears(user["birthdate"])['years'].toString()} years"),
              onTap: () => user["canUpdateBirthdate"]
                  ? showDialog(
                      context: context,
                      builder: (_) => const EditBirthdayModal())
                  : showErrorSnackbar(context, "Cannot update birthdate again"),
            ),
            ListTile(
                leading: const Icon(Icons.location_city),
                title: const Text("Currently In"),
                subtitle: Text(user["location"]),
                onTap: () => showDialog(
                    context: context,
                    builder: (_) => const LocationSearchModal())),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Username"),
              subtitle: Text(user["username"] ?? "empty"),
            ),
            ListTile(
              leading: const Icon(Icons.join_full),
              title: const Text("Account Creation Date"),
              subtitle: Text(
                  formatDateAndCalculateYears(user["memberSince"])["date"] ??
                      "empty"),
            ),
            Container(
              height: 50,
              color: Colors.grey[300],
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: const Row(
                children: [Text("More Information")],
              ),
            ),
            // ListTile(
            //     leading: const Icon(Icons.location_city_rounded),
            //     title: const Text("Address"),
            //     subtitle: const Text("Add or edit your business address"),
            //      onTap: () => showDialog(
            //         context: context,
            //         builder: (_) => const AddressSearchModal())),
            ListTile(
                leading: const Icon(Icons.house),
                title: const Text("Hometown"),
                subtitle: user["hometown"] == null
                    ? const Text("Add your hometown")
                    : Text(user["hometown"]),
                onTap: () => showDialog(
                    context: context,
                    builder: (_) => const HometownSearchModal())),
            ListTile(
                leading: const Icon(Icons.perm_identity),
                title: const Text("Identification"),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Verify your Passport or ID"),
                    Text(
                      "Confirm your identity",
                      style: TextStyle(color: OshinPalette.blue),
                    )
                  ],
                ),
                onTap: () => showDialog(
                    context: context,
                    builder: (_) => const ConfirmIdentityModal())),
            const SizedBox(height: 20),
            TextButton(
                onPressed: () => null,
                child: const Text(
                  "Delete or Disable your account",
                  style: TextStyle(color: Colors.red),
                ))
          ],
        ),
      ),
    );
  }
}
