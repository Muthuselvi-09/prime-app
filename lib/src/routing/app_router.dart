
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


import 'package:prime_app/src/features/auth/presentation/login_screen.dart';
import 'package:prime_app/src/features/buyer/home/presentation/buyer_home_screen.dart';
import 'package:prime_app/src/features/buyer/home/presentation/scaffold_with_nav_bar.dart';
import 'package:prime_app/src/features/buyer/products/presentation/product_listing_screen.dart';
import 'package:prime_app/src/features/buyer/products/presentation/product_details_screen.dart';
import 'package:prime_app/src/features/buyer/cart/presentation/cart_screen.dart';
import 'package:prime_app/src/features/buyer/checkout/presentation/checkout_screen.dart';
import 'package:prime_app/src/features/seller/dashboard/presentation/seller_dashboard_screen.dart';
import 'package:prime_app/src/features/admin/dashboard/presentation/admin_dashboard_screen.dart';
import 'package:prime_app/src/features/chat/presentation/chat_list_screen.dart';
import 'package:prime_app/src/features/chat/presentation/chat_room_screen.dart';
import 'package:prime_app/src/routing/not_found_screen.dart';

// Note: In a real app we would use code generation for the router provider
// but for this UI focused phase we will define it directly.

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/login',
    debugLogDiagnostics: true,
    errorBuilder: (context, state) => const NotFoundScreen(),
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      
      // Admin Routes
      GoRoute(
        path: '/admin/dashboard',
        builder: (context, state) => const AdminDashboardScreen(),
      ),

      // Seller Routes
      GoRoute(
        path: '/seller/dashboard',
        builder: (context, state) => const SellerDashboardScreen(),
      ),
      
      // Buyer shell with bottom nav
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
          // Branch 0: Home
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/buyer/home',
                builder: (context, state) => const BuyerHomeScreen(),
              ),
            ],
          ),
          
          // Branch 1: Catalog
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/buyer/catalog',
                builder: (context, state) => const ProductListingScreen(),
                routes: [
                  GoRoute(
                    path: 'details',
                    builder: (context, state) => const ProductDetailsScreen(),
                  ),
                ],
              ),
            ],
          ),

          // Branch 2: Cart
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/buyer/cart',
                builder: (context, state) => const CartScreen(),
                routes: [
                  GoRoute(
                    path: 'checkout',
                    parentNavigatorKey: null, // Open full screen (outside shell) if preferred, or inside
                    builder: (context, state) => const CheckoutScreen(),
                  ),
                ],
              ),
            ],
          ),

          // Branch 3: Chats (Shared feature used as "Profile/Support" tab for now)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/buyer/chats',
                builder: (context, state) => const ChatListScreen(),
                routes: [
                   GoRoute(
                    path: 'room',
                    parentNavigatorKey: null, // Hide bottom nav for chat room
                    builder: (context, state) => const ChatRoomScreen(),
                  ),
                ]
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
