import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prime_app/src/core/constants/app_colors.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _selectedPaymentMethod = 1; // Default to Trade Credit

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout", style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Delivery Address
            const _SectionHeader(title: "Delivery Address"),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("John Doe", style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16)),
                      TextButton(onPressed: () {}, child: const Text("Change")),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Unit 402, Business Bay Tower,\nLower Parel, Mumbai - 400013\nMaharashtra",
                    style: GoogleFonts.inter(color: AppColors.textSecondary, height: 1.5),
                  ),
                  const SizedBox(height: 8),
                  Text("Mob: +91 98765 43210", style: GoogleFonts.inter(color: AppColors.textSecondary)),
                ],
              ),
            ),
            
            const SizedBox(height: 24),

            // Payment Options
            const _SectionHeader(title: "Payment Method"),
            
            // 1. Trade Credit (Prime B2B Special)
            _PaymentOptionCard(
              value: 1,
              groupValue: _selectedPaymentMethod,
              onChanged: (v) => setState(() => _selectedPaymentMethod = v!),
              title: "Prime Trade Credit",
              subtitle: "Buy Now, Pay in 45 Days",
              icon: Icons.credit_score,
              isRecommended: true,
              balance: "Limit: ₹ 5,00,000",
            ),
            
            const SizedBox(height: 12),
            
            // 2. UPI
            _PaymentOptionCard(
              value: 2,
              groupValue: _selectedPaymentMethod,
              onChanged: (v) => setState(() => _selectedPaymentMethod = v!),
              title: "UPI / Net Banking",
              subtitle: "Instant Payment",
              icon: Icons.account_balance_wallet,
            ),

            const SizedBox(height: 12),

             // 3. Credit/Debit Card
            _PaymentOptionCard(
              value: 3,
              groupValue: _selectedPaymentMethod,
              onChanged: (v) => setState(() => _selectedPaymentMethod = v!),
              title: "Credit / Debit Card",
              subtitle: "Visa, Mastercard, RuPay",
              icon: Icons.credit_card,
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: ElevatedButton(
            onPressed: () {
              // Place Order
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text("Place Order  •  ₹ 63,150", style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
      ),
    );
  }
}

class _PaymentOptionCard extends StatelessWidget {
  final int value;
  final int groupValue;
  final ValueChanged<int?> onChanged;
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isRecommended;
  final String? balance;

  const _PaymentOptionCard({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.isRecommended = false,
    this.balance,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;
    return InkWell(
      onTap: () => onChanged(value),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withOpacity(0.05) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Radio(
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
              activeColor: AppColors.primary,
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.border),
              ),
              child: Icon(icon, color: AppColors.primary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Row(
                     children: [
                       Text(title, style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 16)),
                       if (isRecommended) ...[
                         const SizedBox(width: 8),
                         Container(
                           padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                           decoration: BoxDecoration(
                             color: AppColors.accent,
                             borderRadius: BorderRadius.circular(4),
                           ),
                           child: Text("B2B", style: GoogleFonts.inter(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                         )
                       ]
                     ],
                   ),
                   const SizedBox(height: 2),
                   Text(subtitle, style: GoogleFonts.inter(color: AppColors.textSecondary, fontSize: 13)),
                   if (balance != null) ...[
                     const SizedBox(height: 4),
                     Text(balance!, style: GoogleFonts.inter(color: AppColors.success, fontWeight: FontWeight.w600, fontSize: 12)),
                   ]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
