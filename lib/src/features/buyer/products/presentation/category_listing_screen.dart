import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:prime_app/src/core/constants/app_colors.dart';
import 'package:prime_app/src/core/data/dummy_data.dart';

class CategoryListingScreen extends StatelessWidget {
  const CategoryListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          "All Categories",
          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search))
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: DummyDataService.categories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          final cat = DummyDataService.categories[index];
          return GestureDetector(
            onTap: () {
               // Push to product listing, passing category name/id
               // Using router extra or query params
               context.push('/buyer/products?category=${cat['id']}', extra: cat);
            },
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.border),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),
                    child: Center(
                       // In real app, use Image.asset or network
                       child: Icon(cat['icon'] as IconData, size: 32, color: AppColors.primary),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  cat['label'],
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 12, 
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary
                  ),
                ),
              ],
            ).animate().fadeIn(delay: (index * 30).ms).scale(delay: (index * 30).ms),
          );
        },
      ),
    );
  }
}
