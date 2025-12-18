import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:prime_app/src/core/constants/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile", style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
        elevation: 1,
        backgroundColor: Colors.white,
        foregroundColor: AppColors.textPrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
             const CircleAvatar(
               radius: 40,
               backgroundColor: AppColors.primary,
               child: Text("JD", style: TextStyle(fontSize: 32, color: Colors.white)),
             ),
             const SizedBox(height: 16),
             Text("John Doe", style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold)),
             Text("john.doe@example.com", style: GoogleFonts.inter(color: AppColors.textSecondary)),
             
             const SizedBox(height: 32),
             
             _ProfileTile(icon: Icons.person_outline, title: "Edit Profile"),
             _ProfileTile(icon: Icons.location_on_outlined, title: "Manage Addresses"),
             _ProfileTile(icon: Icons.payment, title: "Payment Methods"),
             _ProfileTile(icon: Icons.security, title: "Security & Privacy"),
             _ProfileTile(icon: Icons.help_outline, title: "Help & Support"),
             
             const SizedBox(height: 24),
             
             SizedBox(
               width: double.infinity,
               child: OutlinedButton(
                 onPressed: () {
                   context.go('/login');
                 },
                 style: OutlinedButton.styleFrom(
                   foregroundColor: AppColors.error,
                   side: const BorderSide(color: AppColors.error),
                 ),
                 child: const Text("Logout"),
               ),
             )
          ],
        ),
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  
  const _ProfileTile({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textSecondary),
      title: Text(title, style: GoogleFonts.inter(fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.chevron_right, size: 18),
      onTap: () {},
    );
  }
}
