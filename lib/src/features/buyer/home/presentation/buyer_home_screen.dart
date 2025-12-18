import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';

class BuyerHomeScreen extends StatelessWidget {
  const BuyerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // 1. App Bar with Search & Location
          const _BuyerAppBar(),

          // 2. Main Content
          SliverList(
            delegate: SliverChildListDelegate([
              // Categories
              const _CategorySection(),
              
              const SizedBox(height: 24),
              
              // Featured Carousel
              const _FeaturedCarousel(),
              
              const SizedBox(height: 32),

              // Top Sellers
              _SectionHeader(title: "Top Selling Safety Gear", onViewAll: () {}),
              const _ProductHorizontalList(),

              const SizedBox(height: 32),

              // Recently Added Grid
              _SectionHeader(title: "New Arrivals", onViewAll: () {}),
              const _ProductGrid(),
              
              const SizedBox(height: 100), // Bottom padding
            ]),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Sub-Widgets (Internal for now, can be extracted later)
// -----------------------------------------------------------------------------

class _BuyerAppBar extends StatelessWidget {
  const _BuyerAppBar();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      backgroundColor: AppColors.primaryDark,
      expandedHeight: 140,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.primaryGradient,
          ),
          child: Stack(
            children: [
              // Subtle pattern or gradient overlay could go here
              Positioned(
                 right: -50, top: -50,
                 child: Icon(Icons.shield_outlined, size: 200, color: Colors.white.withOpacity(0.05)),
              ),
            ],
          ),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search for 'Safety Cones'...",
                      prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
                      suffixIcon: const Icon(Icons.mic, color: AppColors.primary),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: const Icon(Icons.filter_list, color: Colors.white),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
      title: Row(
        children: [
          const Icon(Icons.location_on, size: 16, color: AppColors.accent),
          const SizedBox(width: 4),
          Text(
            "Delivering to Mumbai, 400001",
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          const Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.white70),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined, color: Colors.white),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
          onPressed: () {},
        ),
      ],
    );
  }
}

class _CategorySection extends StatelessWidget {
  const _CategorySection();

  final List<Map<String, dynamic>> categories = const [
    {'icon': Icons.warning_amber_rounded, 'label': 'Barriers'},
    {'icon': Icons.traffic_outlined, 'label': 'Cones'},
    {'icon': Icons.visibility, 'label': 'Signage'},
    {'icon': Icons.format_paint, 'label': 'Paints'},
    {'icon': Icons.hardware, 'label': 'Studs'},
    {'icon': Icons.health_and_safety, 'label': 'PPE'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
          child: Text(
            "Categories",
            style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 100,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final cat = categories[index];
              return Column(
                children: [
                  Container(
                    width: 64,
                    height: 64,
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
                    child: Icon(cat['icon'], color: AppColors.primary, size: 28),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    cat['label'],
                    style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ],
              ).animate().fadeIn(delay: (index * 50).ms).slideX(begin: 0.2);
            },
          ),
        ),
      ],
    );
  }
}

class _FeaturedCarousel extends StatelessWidget {
  const _FeaturedCarousel();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: PageView(
        controller: PageController(viewportFraction: 0.9),
        padEnds: false,
        children: [
          _BannerCard(
            color: const Color(0xFF1E293B),
            title: "Bulk Deal: Road Studs",
            subtitle: "Flat 15% off on 100+ units",
            imageIcon: Icons.light_mode,
          ),
          _BannerCard(
            color: AppColors.accentDark,
            title: "Premium Safety Jackets",
            subtitle: "ISO Certified | High Visibility",
            imageIcon: Icons.security,
          ),
        ],
      ),
    );
  }
}

class _BannerCard extends StatelessWidget {
  final Color color;
  final String title;
  final String subtitle;
  final IconData imageIcon;

  const _BannerCard({required this.color, required this.title, required this.subtitle, required this.imageIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Stack(
        children: [
           Positioned(
            right: -20, bottom: -20,
            child: Icon(imageIcon, size: 140, color: Colors.white.withOpacity(0.1)),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    "FEATURED",
                    style: GoogleFonts.inter(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: color,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    minimumSize: const Size(0, 36),
                  ),
                  child: const Text("View Offer"),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onViewAll;

  const _SectionHeader({required this.title, required this.onViewAll});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
          ),
          TextButton(
            onPressed: onViewAll,
            child: const Text("View All", style: TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }
}

class _ProductHorizontalList extends StatelessWidget {
  const _ProductHorizontalList();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return const _ProductCard(width: 160);
        },
      ),
    );
  }
}

class _ProductGrid extends StatelessWidget {
  const _ProductGrid();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(), // Scroll handled by CustomScrollView
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.75,
        ),
        itemCount: 4,
        itemBuilder: (context, index) {
          return const _ProductCard();
        },
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final double? width;

  const _ProductCard({this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Placeholder
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFF1F5F9),
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Center(
                child: Icon(Icons.image, size: 48, color: Colors.grey[400]),
              ),
            ),
          ),
          // Details
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "PVC Traffic Cone - 750mm",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Min. Qty: 50 | ₹350/pc",
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                       padding: EdgeInsets.zero,
                       minimumSize: const Size(0, 32),
                       textStyle: const TextStyle(fontSize: 12),
                    ),
                    child: const Text("Get Quote"),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
