import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prime_app/src/core/constants/app_colors.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications", style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 1,
      ),
      body: ListView.separated(
        itemCount: 5,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.primary.withOpacity(0.1),
              child: Icon(Icons.notifications, color: AppColors.primary, size: 20),
            ),
            title: Text("Order Update #ORD-2839${index}", style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
            subtitle: Text("Your order has been shipped successfully.", style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
            trailing: Text("2 hrs ago", style: GoogleFonts.inter(fontSize: 10, color: AppColors.textSecondary)),
            onTap: () {},
          );
        },
      ),
    );
  }
}
