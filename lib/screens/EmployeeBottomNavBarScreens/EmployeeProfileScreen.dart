import 'package:empprojectdemo/widgets/myprofilecard.dart';
import 'package:flutter/material.dart';

class EmployeeProfileScreen extends StatelessWidget {
  const EmployeeProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 180,
                width: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(500),
                  image: const DecorationImage(
                    image: NetworkImage(
                      "https://plus.unsplash.com/premium_photo-1678197937465-bdbc4ed95815?q=80&w=1587&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            MyProfileCard(
              cardIcon: Icons.person,
              cardTitle: "About app",
              cardOnTap: () {},
            ),
            const SizedBox(
              height: 20,
            ),
            MyProfileCard(
              cardIcon: Icons.details,
              cardTitle: "Personal details",
              cardOnTap: () {},
            ),
            const SizedBox(
              height: 20,
            ),
            MyProfileCard(
              cardIcon: Icons.logout,
              cardTitle: "Sign out",
              cardOnTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
