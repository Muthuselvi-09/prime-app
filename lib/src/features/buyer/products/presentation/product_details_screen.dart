import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prime_app/src/core/constants/app_colors.dart';


class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  const _ProductAppBar(),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      const _ImageGallery(),
                      const _ProductHeader(),
                      const Divider(thickness: 8, color: AppColors.divider),
                      const _ProductSpecs(),
                      const Divider(thickness: 8, color: AppColors.divider),
                      const _SellerInfoCard(),
                      const SizedBox(height: 32),
                    ]),
                  ),
                ],
              ),
            ),
            const _BottomActionBar(),
          ],
        ),
      ),
    );
  }
}

class _ProductAppBar extends StatelessWidget {
  const _ProductAppBar();
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black12)]),
        child: const BackButton(color: Colors.black),
      ),
      actions: [
         Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black12)]),
          child: IconButton(icon:  Icon(Icons.share_outlined, color: Colors.black), onPressed: () {}),
        ),
         Container(
          margin: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
          decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black12)]),
          child: IconButton(icon: Icon(Icons.favorite_border, color: Colors.black), onPressed: () {}),
        ),
      ],
    );
  }
}

class _ImageGallery extends StatelessWidget {
  const _ImageGallery();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: PageView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            color: const Color(0xFFF8FAFC),
            child: Icon(Icons.traffic, size: 100, color: Colors.grey[300]),
          );
        },
      ),
    );
  }
}

class _ProductHeader extends StatelessWidget {
  const _ProductHeader();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Heavy Duty Traffic Cone - 750mm (Red)",
            style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text("₹ 350", style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primary)),
              const SizedBox(width: 8),
              Text("/ Piece", style: GoogleFonts.inter(fontSize: 14, color: AppColors.textSecondary)),
            ],
          ),
          const SizedBox(height: 8),
          Text("Min. Order Quantity: 50 Pieces", style: GoogleFonts.inter(color: AppColors.accent, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

class _ProductSpecs extends StatelessWidget {
  const _ProductSpecs();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Product Specifications", style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _SpecRow(label: "Material", value: "PVC (Polyvinyl Chloride)"),
          _SpecRow(label: "Height", value: "750 mm"),
          _SpecRow(label: "Weight", value: "3.2 Kg"),
          _SpecRow(label: "Color", value: "Red & White (Reflective)"),
          _SpecRow(label: "Base Type", value: "Square Black Rubber"),
        ],
      ),
    );
  }
}

class _SpecRow extends StatelessWidget {
  final String label;
  final String value;
  const _SpecRow({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 100, child: Text(label, style: GoogleFonts.inter(color: AppColors.textSecondary))),
          Expanded(child: Text(value, style: GoogleFonts.inter(fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }
}

class _SellerInfoCard extends StatelessWidget {
  const _SellerInfoCard();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Sold By", style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                CircleAvatar(backgroundColor: Colors.grey[200], child: const Icon(Icons.business)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Safety First Corp", style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
                          const SizedBox(width: 4),
                           Icon(Icons.verified, size: 16, color: Colors.blue),
                        ],
                      ),
                      Text("Mumbai, Maharashtra", style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text("View Profile"),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomActionBar extends StatelessWidget {
  const _BottomActionBar();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, -2))],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {},
              child: const Text("Get Quote"),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              child: const Text("Contact Seller"),
            ),
          ),
        ],
      ),
    );
  }
}
