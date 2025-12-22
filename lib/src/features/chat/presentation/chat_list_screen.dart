import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:prime_app/src/core/constants/app_colors.dart';
import 'package:prime_app/src/core/data/dummy_data.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sellers = DummyDataService.sellers;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Text("Messages", style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: AppColors.textPrimary,
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: sellers.length,
        separatorBuilder: (context, index) => const Divider(height: 1, indent: 80),
        itemBuilder: (context, index) {
          final seller = sellers[index];
          return _ChatListItem(
            seller: seller,
            index: index,
            onTap: () {
              context.push('/buyer/chats/room', extra: seller);
            },
          );
        },
      ),
    );
  }
}

class _ChatListItem extends StatelessWidget {
  final Map<String, dynamic> seller;
  final int index;
  final VoidCallback onTap;
  
  const _ChatListItem({required this.seller, required this.index, required this.onTap});

  @override
  Widget build(BuildContext context) {
    // Dummy Data Logic for messages
    final isUnread = index < 2;
    final lastMessage = index == 0 
        ? "Please check the attached invoice for the order." 
        : "Is the MOQ negotiable for bulk orders?";
    final time = index == 0 ? "10:30 AM" : "Yesterday";

    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: AppColors.primary.withOpacity(0.1 * ((index % 5) + 1)),
            child: Text(
              seller['name'][0],
              style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: AppColors.primary),
            ),
          ),
          if (index < 3) // Online indicator for top 3
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: AppColors.success,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
        ],
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              seller['name'],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                fontWeight: isUnread ? FontWeight.bold : FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
          Text(
            time,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: isUnread ? AppColors.accent : AppColors.textSecondary,
              fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Row(
          children: [
            if (index == 0) 
              const Padding(
                padding: EdgeInsets.only(right: 4.0),
                child: Icon(Icons.attachment, size: 14, color: AppColors.textSecondary),
              ),
            Expanded(
              child: Text(
                lastMessage,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  color: isUnread ? AppColors.textPrimary : AppColors.textSecondary,
                  fontWeight: isUnread ? FontWeight.w500 : FontWeight.normal,
                ),
              ),
            ),
            if (isUnread)
              Container(
                margin: const EdgeInsets.only(left: 8),
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: AppColors.accent,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  "2",
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
