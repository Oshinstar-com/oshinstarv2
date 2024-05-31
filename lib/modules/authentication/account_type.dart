import 'package:flutter/material.dart';
import 'package:oshinstar/utils/themes/palette.dart';
import 'package:websafe_svg/websafe_svg.dart';

class AccountTypeScreen extends StatelessWidget {
  const AccountTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.exit_to_app),
          ),
        ),
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
                    const AccountTypeView(),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(bottom: 20),
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
              ),
            );
          }),
        ));
  }
}

class AccountTypeView extends StatelessWidget {
  const AccountTypeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'Select an account type',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: OshinPalette.black,
          ),
        ),
        SizedBox(height: 20),
        Text('Choose the type of account you want to create'),
        SizedBox(height: 20),
        AccountTypeItem(accountType: AccountType.star, isSelected: true),
        AccountTypeItem(accountType: AccountType.business, isSelected: false),
      ],
    );
  }
}

class AccountTypeItem extends StatelessWidget {
  final AccountType accountType;
  final bool isSelected;

  const AccountTypeItem({
    super.key,
    required this.accountType,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

enum AccountType { star, business }
