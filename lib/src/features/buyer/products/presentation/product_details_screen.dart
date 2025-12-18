import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:prime_app/src/core/constants/app_colors.dart';
import 'package:prime_app/src/core/data/dummy_data.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late Map<String, dynamic> product;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final state = GoRouterState.of(context);
    if (state.extra != null && state.extra is Map<String, dynamic>) {
       product = state.extra as Map<String, dynamic>;
    } else {
       // Fallback for direct testing
       product = DummyDataService.products[0];
    }
  }

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
                      _ImageGallery(image: product['image']), // In real app, could be list of images
                      _ProductHeader(product: product),
                      const Divider(thickness: 8, color: AppColors.divider),
                      const _ProductSpecs(),
                      const Divider(thickness: 8, color: AppColors.divider),
                      _SellerInfoCard(sellerId: product['sellerId']),
                      const SizedBox(height: 32),
                    ]),
                  ),
                ],
              ),
            ),
            _BottomActionBar(product: product),
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
        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black12)]),
        child: const BackButton(color: Colors.black),
      ),
      actions: [
         Container(
          margin: const EdgeInsets.all(8),
          decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black12)]),
          child: IconButton(icon:  Icon(Icons.share_outlined, color: Colors.black), onPressed: () {}),
        ),
         Container(
          margin: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
          decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black12)]),
          child: IconButton(icon:  Icon(Icons.favorite_border, color: Colors.black), onPressed: () {}),
        ),
      ],
    );
  }
}// Only updating parts that can overflow, rest remains same
class _ImageGallery extends StatelessWidget {
  final String? image;
  const _ImageGallery({this.image});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final galleryHeight = screenWidth * 0.8; // responsive height

    return SizedBox(
      height: galleryHeight,
      child: PageView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            color: const Color(0xFFF8FAFC),
            child: Stack(
              children: [
                Center(
                  child: Icon(Icons.image, size: 100, color: Colors.grey[300]),
                ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "${index + 1}/3",
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ProductHeader extends StatelessWidget {
  final Map<String, dynamic> product;
  const _ProductHeader({required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // prevents column from taking extra height
        children: [
          Flexible(
            child: Text(
              product['name'] ?? "Product Name",
              style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                "₹ ${product['price']}",
                style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primary),
              ),
              const SizedBox(width: 8),
              Text("/ Piece", style: GoogleFonts.inter(fontSize: 14, color: AppColors.textSecondary)),
            ],
          ),
          const SizedBox(height: 8),
          Flexible(
            child: Text(
              "Min. Order Quantity: ${product['moq']} Pieces",
              style: GoogleFonts.inter(color: AppColors.accent, fontWeight: FontWeight.w500),
            ),
          ),
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
        mainAxisSize: MainAxisSize.min, // prevents extra height
        children: [
          Text("Product Specifications", style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          const _SpecRow(label: "Material", value: "Premium Standard"),
          const _SpecRow(label: "Certification", value: "ISO 9001:2015"),
          const _SpecRow(label: "Application", value: "Road Safety / Construction"),
          const _SpecRow(label: "Warranty", value: "1 Year Manufacturer"),
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
          SizedBox(width: 120, child: Text(label, style: GoogleFonts.inter(color: AppColors.textSecondary))),
          Expanded(child: Text(value, style: GoogleFonts.inter(fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }
}

class _SellerInfoCard extends StatelessWidget {
  final String? sellerId;
  const _SellerInfoCard({this.sellerId});

  @override
  Widget build(BuildContext context) {
    final seller = DummyDataService.getSeller(sellerId ?? 's1');
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
                          Text(seller?['name'] ?? "Seller Name", style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
                          const SizedBox(width: 4),
                          if (seller?['verified'] == true)
                             const Icon(Icons.verified, size: 16, color: Colors.blue),
                        ],
                      ),
                      Text(seller?['location'] ?? "Location", style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
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
  final Map<String, dynamic> product;
  const _BottomActionBar({required this.product});

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
              onPressed: () {
                // Navigate to Chat Room
                context.push('/buyer/chats/room', extra: product);
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.primary),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text("Message Seller"),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                 ScaffoldMessenger.of(context).showSnackBar(
                   const SnackBar(content: Text("Added to Request Queue")),
                 );
              },
              style: ElevatedButton.styleFrom(
                 padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text("Get Best Quote"),
            ),
          ),
        ],
      ),
    );
  }
}
