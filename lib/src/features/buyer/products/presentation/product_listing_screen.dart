import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:prime_app/src/core/constants/app_colors.dart';
import 'package:prime_app/src/core/data/dummy_data.dart';

class ProductListingScreen extends StatefulWidget {
  const ProductListingScreen({super.key});

  @override
  State<ProductListingScreen> createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  String? categoryId;
  String? searchQuery;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final state = GoRouterState.of(context);
    categoryId = state.uri.queryParameters['category'];
    searchQuery = state.uri.queryParameters['search']?.toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    // Filter products
    var products = DummyDataService.products;

    if (categoryId != null) {
      products = products
          .where((p) => p['category'] == categoryId || p['id'] == categoryId)
          .toList();
    }

    if (searchQuery != null && searchQuery!.isNotEmpty) {
      products = products
          .where((p) => p['name'].toString().toLowerCase().contains(searchQuery!))
          .toList();
    }

    final displayProducts = products.isEmpty ? DummyDataService.products : products;

    String title = 'All Products';
    if (categoryId != null) {
      title = DummyDataService.categories
          .firstWhere(
              (c) => c['id'] == categoryId, orElse: () => {'label': 'Products'})['label'];
    } else if (searchQuery != null) {
      title = 'Search: "$searchQuery"';
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          title,
          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.shopping_cart_outlined), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          // Filter & Sort Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _showFilterSheet(context),
                    icon: const Icon(Icons.filter_list, size: 18),
                    label: const Text("Filter"),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.textPrimary,
                      side: const BorderSide(color: AppColors.border),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.sort, size: 18),
                    label: const Text("Sort: Popular"),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.textPrimary,
                      side: const BorderSide(color: AppColors.border),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Product List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: displayProducts.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final product = displayProducts[index];
                return ProductCard(
                  product: product,
                  isHorizontal: true,
                  onTap: () => context.push('/buyer/product', extra: product),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          expand: false,
          builder: (_, controller) {
            return Column(
              mainAxisSize: MainAxisSize.min, // prevents overflow
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Filters",
                          style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold)),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                Expanded(
                  child: ListView(
                    controller: controller,
                    padding: const EdgeInsets.all(16),
                    children: [
                      _FilterSection(
                        title: "Price Range",
                        child: RangeSlider(
                          values: const RangeValues(100, 1000),
                          min: 0,
                          max: 2000,
                          onChanged: (_) {},
                        ),
                      ),
                      _FilterSection(
                        title: "Brand",
                        child: Wrap(
                          spacing: 8,
                          children: const [
                            Chip(label: Text("3M")),
                            Chip(label: Text("Tata Steel")),
                            Chip(label: Text("Generic")),
                          ],
                        ),
                      ),
                      _FilterSection(
                        title: "Location",
                        child: const Text("Mumbai, Delhi, Bangalore"),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Apply Filters"),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _FilterSection extends StatelessWidget {
  final String title;
  final Widget child;
  const _FilterSection({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 14)),
        const SizedBox(height: 8),
        child,
        const SizedBox(height: 24),
      ],
    );
  }
}

/// --------------------
/// ProductCard Widget (Horizontal Safe Version)
/// --------------------
class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final bool isHorizontal;
  final VoidCallback? onTap;

  const ProductCard({
    required this.product,
    this.isHorizontal = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)],
        ),
        padding: const EdgeInsets.all(12),
        child: isHorizontal ? _buildHorizontalCard(context) : _buildVerticalCard(context),
      ),
    );
  }

  Widget _buildHorizontalCard(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(child: Icon(Icons.image, size: 50, color: Colors.grey)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min, // prevents overflow
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Text(
                  product['name'] ?? "Product Name",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "₹ ${product['price']}",
                style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.primary),
              ),
              const SizedBox(height: 4),
              Text(
                "Min Order: ${product['moq']}",
                style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVerticalCard(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 150,
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(child: Icon(Icons.image, size: 50, color: Colors.grey)),
        ),
        const SizedBox(height: 8),
        Flexible(
          child: Text(
            product['name'] ?? "Product Name",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "₹ ${product['price']}",
          style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.primary),
        ),
      ],
    );
  }
}
