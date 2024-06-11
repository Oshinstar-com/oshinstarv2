import 'package:flutter/material.dart';
import 'package:oshinstar/helpers/hive.dart';
import 'package:oshinstar/modules/authentication/api/authentication.dart';
import 'package:oshinstar/modules/authentication/screens/categories_picker.dart';
import 'package:oshinstar/utils/themes/palette.dart';
import 'package:oshinstar/widgets/error_snackbar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:websafe_svg/websafe_svg.dart';

class AccountTypeScreen extends StatefulWidget {
  const AccountTypeScreen({super.key});

  @override
  _AccountTypeScreenState createState() => _AccountTypeScreenState();
}

class _AccountTypeScreenState extends State<AccountTypeScreen> {
  AccountType? _selectedAccountType;

  void _onAccountTypeSelected(AccountType accountType) {
    setState(() {
      _selectedAccountType = accountType;
    });
  }

  void _onContinuePressed() async {
 dynamic userId = await HiveManager.readDataFromBox("userBox", "userId");

    if (_selectedAccountType != null) {
      await AuthenticationApi.updateUser({
        "userId": userId,
        "accountType":
            _selectedAccountType == AccountType.star ? "star" : "company"
      });

      Navigator.push(context,
          MaterialPageRoute(builder: (_) => const CategoriesPickerPage()));
    } else {
      showErrorSnackbar(context, "Please select one of the options.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(automaticallyImplyLeading: false,),
        body: SizedBox.expand(
          child: LayoutBuilder(builder: (context, viewportConstraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    AccountTypeView(
                      selectedAccountType: _selectedAccountType,
                      onAccountTypeSelected: _onAccountTypeSelected,
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(bottom: 20),
                      child: ElevatedButton(
                        onPressed: _onContinuePressed,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: OshinPalette.white,
                          backgroundColor: OshinPalette.blue,
                        ),
                        child: const Text('Continue'),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
        ));
  }
}

class AccountTypeView extends StatelessWidget {
  final AccountType? selectedAccountType;
  final ValueChanged<AccountType> onAccountTypeSelected;

  const AccountTypeView({
    super.key,
    required this.selectedAccountType,
    required this.onAccountTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Select an account type',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: OshinPalette.black,
          ),
        ),
        const SizedBox(height: 20),
        const Text('Choose the type of account you want to create'),
        const SizedBox(height: 20),
        AccountTypeItem(
          accountType: AccountType.star,
          isSelected: selectedAccountType == AccountType.star,
          onTap: onAccountTypeSelected,
        ),
        AccountTypeItem(
          accountType: AccountType.business,
          isSelected: selectedAccountType == AccountType.business,
          onTap: onAccountTypeSelected,
        ),
      ],
    );
  }
}

class AccountTypeItem extends StatelessWidget {
  final AccountType accountType;
  final bool isSelected;
  final ValueChanged<AccountType> onTap;

  const AccountTypeItem({
    super.key,
    required this.accountType,
    required this.isSelected,
    required this.onTap,
  });

  Future<void> _launchUrl() async {
    const url = "https://hub.oshinstar.com";

    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(accountType),
      child: ListTile(
        tileColor: isSelected ? Colors.blue[50] : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        title: Column(
          children: [
            WebsafeSvg.asset(
              accountType == AccountType.star
                  ? 'assets/star-account.svg'
                  : 'assets/business-account.svg',
            ),
            const SizedBox(height: 5),
            Text(
              accountType == AccountType.star ? 'Star' : 'Business',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: OshinPalette.blue,
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
        titleAlignment: ListTileTitleAlignment.center,
        subtitle: Column(
          children: [
            Text(
              accountType == AccountType.star
                  ? 'Join as a Star to earn money'
                  : 'Join as a Business to hire stars',
            ),
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                child: const Text(
                  'Read more',
                  style: TextStyle(
                    color: OshinPalette.blue,
                    fontSize: 16,
                  ),
                ),
                onPressed: () => _launchUrl(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum AccountType { star, business }
