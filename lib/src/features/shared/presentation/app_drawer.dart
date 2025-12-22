import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prime_app/src/core/constants/app_colors.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.85,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                _buildMenuSection(context, 'Marketplace', [
                  _MenuItem(Icons.category_outlined, 'Categories / Services', '/buyer/categories'),
                  _MenuItem(Icons.edit_note_outlined, 'Post Requirement', '/post-requirement'),
                ]),
                const Divider(),
                _buildMenuSection(context, 'Your Activity', [
                  _MenuItem(Icons.shopping_bag_outlined, 'My Orders / Bookings', '/orders'),
                  _MenuItem(Icons.record_voice_over_outlined, 'Leads / Enquiries', '/leads'),
                  _MenuItem(Icons.favorite_border, 'Saved / Wishlist', '/wishlist'),
                ]),
                const Divider(),
                _buildMenuSection(context, 'Business', [
                  _MenuItem(Icons.message_outlined, 'Messages / Chat', '/buyer/chats'),
                  _MenuItem(Icons.notifications_outlined, 'Notifications', '/notifications'),
                  _MenuItem(Icons.receipt_long_outlined, 'Payments & Invoices', '/payments'),
                ]),
                const Divider(),
                _buildMenuSection(context, 'Support', [
                  _MenuItem(Icons.help_outline, 'Help & Support', '/support'),
                  _MenuItem(Icons.settings_outlined, 'Settings', '/settings'),
                ]),
              ],
            ),
          ),
          _buildFooter(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 20,
        bottom: 24,
        left: 20,
        right: 20,
      ),
      decoration: const BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.only(topRight: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 35,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 33,
                  backgroundColor: Colors.blue[100],
                  child: const Icon(Icons.person, size: 40, color: AppColors.primary),
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Zha Commerce',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Premium Member',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => context.push('/profile'),
                icon: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildBusinessDetailsBadge(),
        ],
      ),
    );
  }

  Widget _buildBusinessDetailsBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.business_center, color: AppColors.accent, size: 16),
          SizedBox(width: 8),
          Text(
            'Prime Business Solutions PVT LTD',
            style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection(BuildContext context, String title, List<_MenuItem> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
          child: Text(
            title.toUpperCase(),
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),
        ...items.map((item) => _buildListTile(context, item)),
      ],
    );
  }

  Widget _buildListTile(BuildContext context, _MenuItem item) {
    return ListTile(
      leading: Icon(item.icon, color: AppColors.primary, size: 24),
      title: Text(
        item.title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
      ),
      onTap: () {
        context.pop(); // Close drawer
        context.push(item.route);
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      horizontalTitleGap: 12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      hoverColor: AppColors.primary.withOpacity(0.05),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.logout, color: Colors.red),
              const SizedBox(width: 12),
              const Text(
                'Logout',
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const Spacer(),
              Text(
                'v1.0.0',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String title;
  final String route;

  _MenuItem(this.icon, this.title, this.route);
}
