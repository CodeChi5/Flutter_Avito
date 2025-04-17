import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/user/blocs/auth_state_bloc.dart';
import 'package:myapp/user/blocs/auth_bloc.dart';
import 'package:myapp/user/blocs/auth_state.dart';
import 'package:myapp/user/views/auth_view.dart';
import 'package:myapp/chat/data/conversation_repository.dart';
import 'package:myapp/chat/views/chat_screen.dart';

class ProductPage extends StatefulWidget {
  final List<String> images;
  final String price;
  final String title;
  final int productId;

  const ProductPage({
    super.key,
    required this.images,
    required this.price,
    required this.title,
    required this.productId,
  });

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late PageController _pageController;
  int _currentIndex = 0;
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _handleContactButton(BuildContext context) async {
    final authState = context.read<AuthStateBloc>().state;

    if (!authState.isAuthenticated) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: context.read<AuthBloc>(),
            child: WillPopScope(
              onWillPop: () async {
                Navigator.of(context).pop();
                return false;
              },
              child: BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is PhoneVerificationSuccess) {
                    Navigator.of(context).pop();
                  }
                },
                child: const AuthView(),
              ),
            ),
          ),
        ),
      ).then((_) {
        final newAuthState = context.read<AuthStateBloc>().state;
        if (newAuthState.isAuthenticated) {
          _createConversationAndNavigate(context);
        }
      });
    } else {
      _createConversationAndNavigate(context);
    }
  }

  void _createConversationAndNavigate(BuildContext context) async {
    try {
      final repository = ConversationRepository();

      // First check if conversation exists
      final existingConversation =
          await repository.getConversationByProduct(widget.productId);

      final conversation = existingConversation ??
          await repository.createConversation(widget.productId);

      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatScreen(
            conversation: conversation,
          ),
        ),
      );

      // Pop back to the main screen after chat
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error accessing conversation: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 5,
        leading: IconButton(
          icon:
              Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
        actions: [
          Icon(Icons.favorite_border, color: Theme.of(context).iconTheme.color),
          const SizedBox(width: 16),
          Icon(Icons.shopping_cart_outlined,
              color: Theme.of(context).iconTheme.color),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Slider
            SizedBox(
              height: 300,
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.images.length,
                onPageChanged: _onPageChanged,
                itemBuilder: (context, index) {
                  return Image.network(
                    widget.images[index],
                    fit: BoxFit.contain,
                    width: double.infinity,
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.images.length, (index) {
                return Container(
                  margin: EdgeInsets.all(5),
                  width: _currentIndex == index ? 12 : 8,
                  height: _currentIndex == index ? 12 : 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).disabledColor,
                  ),
                );
              }),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0, 0, 0),
              child: Text(
                '${widget.price} ₽',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0, 0, 0),
              child: Text(
                widget.title,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Rating & Reviews Section
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          "4.8",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "5 006 отзывов о модели",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Buttons Section
                  Row(
                    children: [
                      // Buy with Delivery Button

                      const SizedBox(width: 12),

                      // Add to Cart Button
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () => _handleContactButton(context),
                          child: BlocBuilder<AuthStateBloc, AuthStateState>(
                            builder: (context, state) {
                              return Text(
                                state.isAuthenticated
                                    ? "Contact"
                                    : "Login to Contact",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
