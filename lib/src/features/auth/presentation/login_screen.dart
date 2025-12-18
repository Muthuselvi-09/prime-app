import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prime_app/src/core/constants/app_colors.dart';
import 'package:prime_app/src/core/widgets/prime_animated_background.dart';



class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PrimeAnimatedBackground(
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 20)],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.shield, size: 64, color: AppColors.primary),
                const SizedBox(height: 16),
                Text("PRIME APP", style: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.bold)),
                Text("B2B Road Safety Marketplace", style: GoogleFonts.inter(color: AppColors.textSecondary)),
                const SizedBox(height: 32),
                
                // Role Simulation Buttons
                _RoleButton(
                  label: "Login as Buyer", 
                  color: AppColors.primary, 
                  onTap: () => context.go('/buyer/home'),
                ),
                const SizedBox(height: 12),
                _RoleButton(
                  label: "Login as Seller", 
                  color: AppColors.accent, 
                  onTap: () => context.go('/seller/dashboard'),
                ),
                const SizedBox(height: 12),
                _RoleButton(
                  label: "Login as Admin", 
                  color: Colors.blueGrey, 
                  onTap: () => context.go('/admin/dashboard'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RoleButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _RoleButton({required this.label, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        onPressed: onTap,
        child: Text(label),
      ),
    );
  }
}
