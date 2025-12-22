import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:prime_app/src/features/splash/presentation/splash_screen.dart';
import 'package:prime_app/src/features/auth/presentation/login_screen.dart';
import 'package:prime_app/src/features/buyer/home/presentation/buyer_home_screen.dart';
import 'package:prime_app/src/features/buyer/home/presentation/scaffold_with_nav_bar.dart';
import 'package:prime_app/src/features/buyer/products/presentation/product_listing_screen.dart';
import 'package:prime_app/src/features/buyer/products/presentation/category_listing_screen.dart';
import 'package:prime_app/src/features/buyer/products/presentation/product_details_screen.dart';
import 'package:prime_app/src/features/buyer/cart/presentation/cart_screen.dart';
import 'package:prime_app/src/features/buyer/checkout/presentation/checkout_screen.dart';
import 'package:prime_app/src/features/seller/dashboard/presentation/seller_dashboard_screen.dart';
import 'package:prime_app/src/features/admin/dashboard/presentation/admin_dashboard_screen.dart';
import 'package:prime_app/src/features/chat/presentation/chat_list_screen.dart';
import 'package:prime_app/src/features/chat/presentation/chat_room_screen.dart';
import 'package:prime_app/src/routing/not_found_screen.dart';
import 'package:prime_app/src/features/shared/presentation/notifications_screen.dart';
import 'package:prime_app/src/features/shared/presentation/profile_screen.dart';
import 'package:prime_app/src/features/buyer/post_requirement/presentation/post_requirement_screen.dart';
import 'package:prime_app/src/features/buyer/orders/presentation/orders_screen.dart';
import 'package:prime_app/src/features/buyer/leads/presentation/leads_screen.dart';
import 'package:prime_app/src/features/buyer/wishlist/presentation/wishlist_screen.dart';
import 'package:prime_app/src/features/buyer/payments/presentation/payments_screen.dart';
import 'package:prime_app/src/features/shared/support/presentation/support_screen.dart';
import 'package:prime_app/src/features/shared/settings/presentation/settings_screen.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    errorBuilder: (context, state) => const NotFoundScreen(),
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),

      // Admin Routes
      GoRoute(
        path: '/admin/dashboard',
        builder: (context, state) => const AdminDashboardScreen(),
      ),

      // Shared Routes
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/post-requirement',
        builder: (context, state) => const PostRequirementScreen(),
      ),
      GoRoute(
        path: '/orders',
        builder: (context, state) => const OrdersScreen(),
      ),
      GoRoute(
        path: '/leads',
        builder: (context, state) => const LeadsScreen(),
      ),
      GoRoute(
        path: '/wishlist',
        builder: (context, state) => const WishlistScreen(),
      ),
      GoRoute(
        path: '/payments',
        builder: (context, state) => const PaymentsScreen(),
      ),
      GoRoute(
        path: '/support',
        builder: (context, state) => const SupportScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
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

          // Branch 1: Categories
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/buyer/categories',
                builder: (context, state) =>
                    const CategoryListingScreen(),
                routes: [
                  GoRoute(
                    path: 'products',
                    builder: (context, state) =>
                        const ProductListingScreen(),
                  ),
                  GoRoute(
                    path: 'details',
                    builder: (context, state) =>
                        const ProductDetailsScreen(),
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
                    builder: (context, state) =>
                        const CheckoutScreen(),
                  ),
                ],
              ),
            ],
          ),

          // Branch 3: Chats
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/buyer/chats',
                builder: (context, state) =>
                    const ChatListScreen(),
                routes: [
                  GoRoute(
                    path: 'room',
                    builder: (context, state) =>
                        const ChatRoomScreen(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
