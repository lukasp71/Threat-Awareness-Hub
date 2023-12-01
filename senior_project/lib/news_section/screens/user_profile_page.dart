// ignore_for_file: library_private_types_in_public_api, avoid_print, avoid_unnecessary_containers, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:senior_project/database/services/databse.dart';
import 'package:senior_project/news_section/widgets/appBar.dart';
import 'package:url_launcher/url_launcher.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage>
    with TickerProviderStateMixin {
  User? user = FirebaseAuth.instance.currentUser;
  late DatabaseService service;
  late TabController _tabController;
  bool isLoading = true; // Initially, set to true to show the loading state

  // Variables to hold user data
  String username = '';
  String email = '';
  List<String> favURLs = [];
  List<String> savedTitles = [];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    if (user != null) {
      service = DatabaseService(uid: user!.uid);
      _loadUserData();
    }
  }

  Future<void> _loadUserData() async {
    try {
      if (user != null) {
        service = DatabaseService(uid: user!.uid);
        String fetchedUsername = await service.getUserUsername();
        String fetchedEmail = await service.getUserEmail();
        List<String> fetchedURLs = await service.getFavURLs();
        List<String> fetchedTitles = await service.getsavedTitles();
        setState(() {
          username = fetchedUsername;
          email = fetchedEmail;
          favURLs = fetchedURLs;
          savedTitles = fetchedTitles;
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching user data: $e');
      // Handle the error state
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: SectionAppBar(currentSection: 'Profile', backArrow: true),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                child: TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(text: 'Profile'),
                    Tab(text: 'Quiz Scores'),
                    Tab(text: 'Saved Articles/Vulnerbilities'),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildProfileTab(),
                    _buildQuizScoresTab(),
                    _buildFavoritesTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget _buildProfileTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(
                'https://via.placeholder.com/150'), // Replace with user's actual image URL
          ),
          const SizedBox(height: 16),
          const Text(
            'Profile Settings',
            style: TextStyle(
                color: Colors.red, fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const Divider(color: Colors.red),
          _buildTextFormField('Username', username),
          _buildTextFormField('Email', email),
          // Add more profile fields if necessary
        ],
      ),
    );
  }

  Widget _buildQuizScoresTab() {
    return const Center(
      child: Text('Quiz Scores will be displayed here'),
    );
  }

  Widget _buildFavoritesTab() {
    List<String> favoritedURLs = favURLs; // Replace with actual data

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Saved Articles/Vulnerabilities',
            style: TextStyle(
                color: Colors.red, fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const Divider(color: Colors.red),
          Expanded(
            child: ListView.builder(
              itemCount: favoritedURLs.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.grey[850],
                  child: ListTile(
                    title: Text(
                      savedTitles[index], // Replace with actual article title
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      favoritedURLs[index],
                      style: TextStyle(color: Colors.grey[300]),
                    ),
                    onTap: () async {
                      // Handle URL click (e.g., open the article)
                      String url = favoritedURLs[index];
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        print('Could not launch $url');
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFormField(String label, String initialValue,
      {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        initialValue: initialValue,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
