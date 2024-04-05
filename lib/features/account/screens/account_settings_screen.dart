import 'package:flutter/material.dart';
import 'package:uniplanet_mobile/features/account/screens/new_account_screen.dart';
import 'package:uniplanet_mobile/features/account/screens/premium_screen.dart';
import 'package:uniplanet_mobile/repository/user_repo.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const MenuSection(
              title: 'Premium',
              icon: Icons.diamond_outlined,
              screen: PremiumScreen(),
            ),
            const MenuSection(title: 'Change name', screen: PremiumScreen()),
            const MenuSection(
              title: 'Change password',
              screen: PremiumScreen(),
            ),
            MenuSection(
              title: 'Log out',
              onTap: () {
                UserRepository().logOut(context);
              },
            ),
            MenuSection(
              title: 'Delete Account',
              textColor: Colors.red,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: Colors.white,
                    title: const Text('Confirm Deletion'),
                    content: const Text('Do you really want to delete your account?'),
                    actions: [
                      TextButton(
                        child: const Text('Cancel', style: TextStyle(color: Colors.black)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Confirm', style: TextStyle(color: Colors.red),),
                        onPressed: () {
                          print("account deleted"); // Delete account here
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
