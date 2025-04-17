import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/chat/data/conversation_model.dart';
import 'package:myapp/chat/data/conversation_repository.dart';
import 'package:myapp/home/views/homePage.dart';
import 'package:myapp/settings/views/settings_page.dart';
import 'package:myapp/user/blocs/user_bloc.dart';
import 'package:myapp/user/blocs/user_state.dart';
import 'package:myapp/user/views/auth_check_view.dart';
import 'package:myapp/user/views/RegisterPage.dart';
import 'package:myapp/user/views/auth_view.dart';
import 'package:myapp/products/views/add_product_view.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:myapp/categories/blocs/categories_bloc.dart';
import 'package:myapp/categories/data/categories_repo.dart';
import 'package:myapp/products/data/product_repo.dart';
import 'package:myapp/products/blocs/product_bloc.dart';

import '../../user/data/user_repo.dart';
import 'package:myapp/chat/views/chat_screen.dart';
import 'dart:async';

class PersistentNavBar {
  final PersistentTabController controller;
  final BuildContext context;

  PersistentNavBar({
    required this.context,
    int initialIndex = 0,
  }) : controller = PersistentTabController(initialIndex: initialIndex);

  List<Widget> buildScreens() {
    return [
      const HomePageView(),
      const SearchScreen(),
      const AuthCheckView(),
      MessagesScreen(),
      const SettingsPage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: "Home",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.search),
        title: "Search",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.add_circle),
        title: "Add",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.message),
        title: "Messages",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.settings),
        title: "Settings",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  Widget build() {
    return PersistentTabView(
      context,
      controller: controller,
      screens: buildScreens(),
      items: _navBarsItems(),
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
    );
  }
}

// Placeholder screens - move these to separate files in a real app
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Home Screen')),
    );
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Search Screen')),
    );
  }
}

class MessagesScreen extends StatefulWidget {
  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final StreamController<List<Conversation>> _conversationsController =
      StreamController<List<Conversation>>.broadcast();
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    _loadConversations();
    // Refresh every 3 seconds
    _refreshTimer =
        Timer.periodic(Duration(seconds: 3), (_) => _loadConversations());
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    _conversationsController.close();
    super.dispose();
  }

  Future<void> _loadConversations() async {
    try {
      final repository = ConversationRepository();
      final conversations = await repository.getConversations();
      if (!_conversationsController.isClosed) {
        _conversationsController.add(conversations);
      }
    } catch (e) {
      print('Error loading conversations: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
        elevation: 0,
      ),
      body: StreamBuilder<List<Conversation>>(
        stream: _conversationsController.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error loading conversations: ${snapshot.error}'),
                  ElevatedButton(
                    onPressed: _loadConversations,
                    child: Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final conversations = snapshot.data ?? [];

          if (conversations.isEmpty) {
            return Center(
              child: Text('No conversations yet'),
            );
          }

          return ListView.builder(
            itemCount: conversations.length,
            itemBuilder: (context, index) {
              final conversation = conversations[index];
              final otherUser = conversation.buyer.username == 'avatar'
                  ? conversation.seller
                  : conversation.buyer;

              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    conversation.product.images
                        .firstWhere(
                          (img) => img.isPrimary,
                          orElse: () => conversation.product.images.first,
                        )
                        .image,
                  ),
                ),
                title: Text(otherUser.username),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      conversation.product.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      conversation.lastMessage?.content ?? 'No messages yet',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _formatDate(conversation.updatedAt),
                      style: TextStyle(color: Colors.grey),
                    ),
                    if (conversation.unreadCount > 0)
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${conversation.unreadCount}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => ChatScreen(
                        conversation: conversation,
                      ),
                    ),
                  ).then((_) => _loadConversations());
                },
              );
            },
          );
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return '${date.hour}:${date.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Settings Screen')),
    );
  }
}
