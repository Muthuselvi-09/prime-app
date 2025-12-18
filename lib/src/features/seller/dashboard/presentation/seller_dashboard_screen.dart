import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prime_app/src/core/constants/app_colors.dart';


import 'package:go_router/go_router.dart';

class SellerDashboardScreen extends StatelessWidget {
  const SellerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9), // Slate 100
      appBar: AppBar(
        title: Text("Dashboard", style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.primary,
        elevation: 0,
        actions: [
          IconButton(
             icon: const Icon(Icons.notifications_outlined), 
             onPressed: () => context.push('/notifications')
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: InkWell(
              onTap: () => context.push('/profile'),
              child: const CircleAvatar(
                 radius: 16,
                 backgroundColor: AppColors.primary,
                 child: Text("S", style: TextStyle(color: Colors.white)),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Show Add Product Mock
           showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Add New Product"),
              content: const Text("This feature allows sellers to list new products. (Simulated)"),
              actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("Close"))],
            ),
          );
        },
        backgroundColor: AppColors.accent,
        icon: const Icon(Icons.add),
        label: const Text("Add Product"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Stats Grid
            Row(
              children: [
                Expanded(child: _StatsCard(title: "Total Sales", value: "₹ 15.2L", icon: Icons.currency_rupee, color: Colors.blueAccent, delay: 0)),
                const SizedBox(width: 12),
                Expanded(child: _StatsCard(title: "Active Orders", value: "24", icon: Icons.shopping_bag_outlined, color: AppColors.accent, delay: 100)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _StatsCard(title: "Views", value: "1.2K", icon: Icons.trending_up, color: Colors.purple, delay: 200)),
                const SizedBox(width: 12),
                Expanded(child: _StatsCard(title: "Rating", value: "4.8", icon: Icons.star_border, color: Colors.amber, delay: 300)),
              ],
            ),

            const SizedBox(height: 24),

            // 2. Recent Orders
            _SectionHeader(title: "Recent Orders", action: "View All"),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                // ignore: deprecated_member_use
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2))],
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, index) => const _OrderTile(),
              ),
            ),

            const SizedBox(height: 24),

            // 3. Low Stock Inventory
            _SectionHeader(title: "Low Stock Alert", action: "Manage Inventory"),
             Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                // ignore: deprecated_member_use
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2))],
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: 3,
                separatorBuilder: (_, _) => const SizedBox(height: 0),
                itemBuilder: (context, index) => const _InventoryTile(),
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

class _StatsCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final int delay;

  const _StatsCard({required this.title, required this.value, required this.icon, required this.color, required this.delay});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        // ignore: deprecated_member_use
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              // ignore: deprecated_member_use
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 16),
          Text(value, style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
          const SizedBox(height: 4),
          Text(title, style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
        ],
      ),
    ).animate().scale(delay: delay.ms, duration: 400.ms, curve: Curves.easeOutBack);
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String action;
  const _SectionHeader({required this.title, required this.action});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
          Text(action, style: GoogleFonts.inter(fontSize: 13, color: AppColors.primary, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _OrderTile extends StatelessWidget {
  const _OrderTile();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(8)),
        child: const Icon(Icons.inventory_2_outlined, color: AppColors.textSecondary),
      ),
      title: Text("ORD-284920", style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 14)),
      subtitle: Text("3 items • ₹ 4,500", style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          // ignore: deprecated_member_use
          color: Colors.orange.withOpacity(0.1),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text("Pending", style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.orange)),
      ),
    );
  }
}

class _InventoryTile extends StatelessWidget {
  const _InventoryTile();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(4)),
        child: const Icon(Icons.traffic, size: 20, color: Colors.grey),
      ),
      title: Text("Reflective Tape - Yellow", style: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 14)),
      subtitle: Text("Stock: 12 (Low)", style: GoogleFonts.inter(fontSize: 12, color: AppColors.error)),
      trailing: TextButton(
        onPressed: () {},
        child: const Text("Restock"),
      ),
    );
  }
}
