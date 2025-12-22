import 'package:flutter/material.dart';
import 'package:prime_app/src/core/constants/app_colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildSectionHeader('General'),
          _buildSettingTile(Icons.notifications_outlined, 'Push Notifications', trailing: Switch(value: true, onChanged: (v) {})),
          _buildSettingTile(Icons.language_outlined, 'Language', trailing: const Text('English (US)')),
          _buildSettingTile(Icons.dark_mode_outlined, 'Appearance', trailing: const Text('System Default')),
          
          const SizedBox(height: 24),
          _buildSectionHeader('Security'),
          _buildSettingTile(Icons.lock_outline, 'Change Password'),
          _buildSettingTile(Icons.fingerprint, 'Biometric Login', trailing: Switch(value: false, onChanged: (v) {})),

          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.logout, color: AppColors.error),
              label: const Text('Logout', style: TextStyle(color: AppColors.error)),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.error),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'App Version 1.0.0 (Prime)',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 8),
      child: Text(
        title,
        style: TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildSettingTile(IconData icon, String title, {Widget? trailing}) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textPrimary),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: trailing ?? const Icon(Icons.chevron_right, size: 20),
      contentPadding: EdgeInsets.zero,
      onTap: trailing == null ? () {} : null,
    );
  }
}
