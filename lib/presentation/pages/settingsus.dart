import 'package:flutter/material.dart';
import 'package:tiziappp2/presentation/pages/surveyuser.dart';

class Settinguser extends StatefulWidget {
  const Settinguser({super.key});

  @override
  State<Settinguser> createState() => _SettinguserState();
}

class _SettinguserState extends State<Settinguser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Color(0xFF634FBD),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Account Settings",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 12),
              _buildSettingsCard(Icons.account_circle_outlined,
                  "Personal Information", "Update your personal details"),
              _buildSettingsCard(Icons.lock_outline, "Privacy & Security",
                  "Control your privacy settings"),
              _buildSettingsCard(Icons.language_outlined, "Language",
                  "Change your preferred language"),
              _buildSettingsCard(Icons.query_stats, "Onboarding Survey",
                  "Personalize your meditation & yoga recommendations"),

              SizedBox(height: 24),
              Text(
                "App Settings",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 12),
              _buildSettingsCard(Icons.help_outline, "Help & Support",
                  "Get assistance and answers to your questions"),
              _buildSettingsCard(Icons.star_outline, "Rate Our App",
                  "If you enjoy our app, please give us a rating"),
              _buildSettingsCard(
                  Icons.info_outline, "About", "Learn more about our app"),

              SizedBox(height: 20),

              SizedBox(height: 20),
              // Logout button
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Logout functionality would be implemented here
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Logout functionality would go here')));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade400,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Log Out",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build settings cards
  Widget _buildSettingsCard(IconData icon, String title, String subtitle) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0xFF634FBD).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Color(0xFF634FBD),
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey,
        ),
        onTap: () {
          // Navigation would happen here
          if (title == "Personal Information") {
            _showPersonalInfoDialog(context);
          } else if (title == "Onboarding Survey") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Surveyuser()),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('$title settings would open here')));
          }
        },
      ),
    );
  }

  // Example of a dialog for personal information
  void _showPersonalInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Personal Information"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: "Full Name",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Phone Number",
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Information updated')));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF634FBD),
              ),
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }
}
