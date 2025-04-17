import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/chat/data/conversation_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConversationRepository {
  final String baseUrl = 'http://192.168.84.57:8000/api';

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    print('Debug - Token value: $token');
    return token;
  }

  Future<Conversation> createConversation(int productId) async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('Not authenticated');
    }

    final response = await http.post(
      Uri.parse('$baseUrl/conversations/'),
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'product_id': productId.toString(),
      },
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 201) {
      return Conversation.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create conversation: ${response.body}');
    }
  }

  Future<List<Conversation>> getConversations() async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('Not authenticated');
    }

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/conversations/'),
        headers: {
          'Authorization': 'Token $token',
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) {
          try {
            return Conversation.fromJson(json);
          } catch (e, stackTrace) {
            print('Error parsing conversation: $e');
            print('Stack trace: $stackTrace');
            print('JSON data: $json');
            rethrow;
          }
        }).toList();
      } else {
        throw Exception('Failed to load conversations: ${response.body}');
      }
    } catch (e, stackTrace) {
      print('Error in getConversations: $e');
      print('Stack trace: $stackTrace');
      rethrow;
    }
  }

  Future<Conversation?> getConversationByProduct(int productId) async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('Not authenticated');
    }

    try {
      // Get all conversations first
      final conversations = await getConversations();

      // Find conversation with matching product ID
      final existingConversation = conversations.firstWhere(
        (conv) => conv.product.id == productId,
        orElse: () => throw Exception('not_found'),
      );

      return existingConversation;
    } catch (e) {
      if (e.toString() == 'Exception: not_found') {
        return null;
      }
      print('Error checking conversation: $e');
      rethrow;
    }
  }
}
