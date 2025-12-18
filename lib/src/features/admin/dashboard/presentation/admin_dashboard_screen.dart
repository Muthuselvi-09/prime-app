import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prime_app/src/core/constants/app_colors.dart';


class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE2E8F0), // Heavier Gray for Admin BG
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.admin_panel_settings, color: AppColors.primary),
            const SizedBox(width: 8),
            Text("Prime Admin Portal", style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
          ],
        ),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 2,
        actions: [
          TextButton.icon(
             onPressed: (){},
             icon:  Icon(Icons.download),
             label: const Text("Export Reports"),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Side Navigation (Visual only for now)
          if (MediaQuery.of(context).size.width > 800)
            Container(
              width: 250,
              color: Colors.white,
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 20),
                children:  [
                  _NavTile(icon: Icons.dashboard, title: "Overview", isActive: true),
                  _NavTile(icon: Icons.verified_user, title: "Seller Approvals", badge: "3"),
                  _NavTile(icon: Icons.credit_score, title: "Credit Requests", badge: "5"),
                  _NavTile(icon: Icons.shopping_cart, title: "Orders"),
                  _NavTile(icon: Icons.settings, title: "Settings"),
                ],
              ),
            ),
          
          // Main Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Analytics Cards
                  GridView.count(
                    crossAxisCount: MediaQuery.of(context).size.width > 1200 ? 4 : 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.8,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: const [
                      _AdminStatCard(title: "Total GMV", value: "₹ 1.2 Cr", color: Colors.green, icon: Icons.currency_rupee),
                      _AdminStatCard(title: "Active Sellers", value: "128", color: AppColors.primary, icon: Icons.store),
                      _AdminStatCard(title: "Pending Approvals", value: "12", color: Colors.orange, icon: Icons.person_add),
                      _AdminStatCard(title: "Disputes", value: "3", color: Colors.red, icon: Icons.warning),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // 2. Pending Seller Approvals
                  _SectionHeader(title: "Pending Seller Verifications"),
                  Container(
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(child: Text("S${index+1}")),
                          title: Text("Safety Gears Pvt Ltd $index", style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                          subtitle: const Text("GSTIN: 27ABCDE1234F1Z5 • Mumbai"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextButton(onPressed: (){}, child: const Text("View Docs")),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: (){}, 
                                style: ElevatedButton.styleFrom(backgroundColor: AppColors.success, foregroundColor: Colors.white),
                                child: const Text("Approve")
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 32),

                  // 3. Credit Approval Queue
                  _SectionHeader(title: "B2B Credit Requests"),
                  Container(
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 2,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading:  Icon(Icons.credit_card, size: 32, color: AppColors.accent),
                          title: Text("RoadWorks Infra Ltd", style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                          subtitle: Text("Requested Limit: ₹ 5,00,000 • Tenure: 45 Days"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              OutlinedButton(onPressed: (){}, child: const Text("Reject")),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: (){}, 
                                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                                child: const Text("Authorize Trend")
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 32),

                  // 4. Live Orders Monitoring
                  _SectionHeader(title: "Live Orders Monitor"),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.all(16),
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text("Order ID")),
                        DataColumn(label: Text("Buyer")),
                        DataColumn(label: Text("Amount")),
                        DataColumn(label: Text("Status")),
                        DataColumn(label: Text("Action")),
                      ],
                      rows: List.generate(5, (index) => DataRow(
                        cells: [
                          DataCell(Text("ORD-289$index")),
                          DataCell(Text("Buyer Corp $index")),
                          DataCell(Text("₹ ${10000 * (index+1)}")),
                          DataCell(Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                            child: Text("Processing", style: TextStyle(color: Colors.blue[800], fontSize: 12)),
                          )),
                          DataCell( Icon(Icons.visibility, size: 18, color: Colors.grey)),
                        ],
                      )),
                    ),
                  ),
                  
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AdminStatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final IconData icon;

  const _AdminStatCard({required this.title, required this.value, required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: GoogleFonts.inter(fontSize: 14, color: AppColors.textSecondary)),
              Icon(icon, color: color, size: 20),
            ],
          ),
          Text(value, style: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
          Row(
            children: [
              Icon(Icons.arrow_upward, size: 14, color: Colors.green),
              const SizedBox(width: 4),
              Text("12% vs last month", style: GoogleFonts.inter(fontSize: 12, color: Colors.green)),
            ],
          )
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.1);
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(title, style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
    );
  }
}

class _NavTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isActive;
  final String? badge;

  const _NavTile({required this.title, required this.icon, this.isActive = false, this.badge});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: isActive ? AppColors.primary : AppColors.textSecondary),
      title: Text(
        title, 
        style: GoogleFonts.inter(
          color: isActive ? AppColors.primary : AppColors.textSecondary,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal
        ),
      ),
      selected: isActive,
      selectedTileColor: AppColors.primary.withOpacity(0.05),
      trailing: badge != null 
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(color: AppColors.error, borderRadius: BorderRadius.circular(12)),
              child: Text(badge!, style: const TextStyle(color: Colors.white, fontSize: 10)),
            ) 
          : null,
      onTap: (){},
    );
  }
}
