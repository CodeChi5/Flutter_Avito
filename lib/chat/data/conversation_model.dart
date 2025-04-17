class Product {
  final int id;
  final String title;
  final String description;
  final String price;
  final MainCategory mainCategory;
  final SubCategory subCategory;
  final String user;
  final List<ProductImage> images;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.mainCategory,
    required this.subCategory,
    required this.user,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    try {
      return Product(
        id: json['id'] as int,
        title: json['title'] as String,
        description: json['description'] as String,
        price: json['price'] as String,
        mainCategory: MainCategory.fromJson(
            json['main_category'] as Map<String, dynamic>),
        subCategory:
            SubCategory.fromJson(json['sub_category'] as Map<String, dynamic>),
        user: json['user'] as String,
        images: (json['images'] as List<dynamic>)
            .map((e) => ProductImage.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    } catch (e, stackTrace) {
      print('Error in Product.fromJson: $e');
      print('Stack trace: $stackTrace');
      print('JSON data: $json');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'price': price,
        'images': images.map((image) => image.toJson()).toList(),
      };
}

class MainCategory {
  final int id;
  final String name;
  final String subtitle;
  final String icon;
  final String logoImg;
  final String mainImg;

  MainCategory({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.icon,
    required this.logoImg,
    required this.mainImg,
  });

  factory MainCategory.fromJson(Map<String, dynamic> json) {
    try {
      return MainCategory(
        id: json['id'] as int,
        name: json['name'] as String,
        subtitle: json['subtitle'] as String,
        icon: json['icon'] as String,
        logoImg: json['logo_img'] as String,
        mainImg: json['main_img'] as String,
      );
    } catch (e, stackTrace) {
      print('Error in MainCategory.fromJson: $e');
      print('Stack trace: $stackTrace');
      print('JSON data: $json');
      rethrow;
    }
  }
}

class SubCategory {
  final int id;
  final String name;
  final String icon;
  final String subtitle;
  final String logoImg;
  final int mainCategory;

  SubCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.subtitle,
    required this.logoImg,
    required this.mainCategory,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    try {
      return SubCategory(
        id: json['id'] as int,
        name: json['name'] as String,
        icon: json['icon'] as String,
        subtitle: json['subtitle'] as String,
        logoImg: json['logo_img'] as String,
        mainCategory: json['main_category'] as int,
      );
    } catch (e, stackTrace) {
      print('Error in SubCategory.fromJson: $e');
      print('Stack trace: $stackTrace');
      print('JSON data: $json');
      rethrow;
    }
  }
}

class ProductImage {
  final int id;
  final String image;
  final bool isPrimary;

  ProductImage({
    required this.id,
    required this.image,
    required this.isPrimary,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    try {
      return ProductImage(
        id: json['id'] as int,
        image: json['image'] as String,
        isPrimary: json['is_primary'] as bool,
      );
    } catch (e, stackTrace) {
      print('Error in ProductImage.fromJson: $e');
      print('Stack trace: $stackTrace');
      print('JSON data: $json');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'image': image,
        'is_primary': isPrimary,
      };
}

class User {
  final int id;
  final String username;
  final String phoneNumber;

  User({
    required this.id,
    required this.username,
    required this.phoneNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    try {
      return User(
        id: json['id'] as int,
        username: json['username'] as String,
        phoneNumber: json['phone_number'] as String,
      );
    } catch (e, stackTrace) {
      print('Error in User.fromJson: $e');
      print('Stack trace: $stackTrace');
      print('JSON data: $json');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'phone_number': phoneNumber,
      };
}

class LastMessage {
  final String content;
  final int senderId;
  final DateTime createdAt;

  LastMessage({
    required this.content,
    required this.senderId,
    required this.createdAt,
  });

  factory LastMessage.fromJson(Map<String, dynamic> json) {
    return LastMessage(
      content: json['content'] as String,
      senderId: json['sender_id'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'sender_id': senderId,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

class ConversationMessage {
  final int id;
  final String content;
  final int senderId;
  final DateTime createdAt;

  ConversationMessage({
    required this.id,
    required this.content,
    required this.senderId,
    required this.createdAt,
  });

  factory ConversationMessage.fromJson(Map<String, dynamic> json) {
    return ConversationMessage(
      id: json['id'] as int,
      content: json['content'] as String,
      senderId: json['sender_id'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'sender_id': senderId,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

class Conversation {
  final int id;
  final Product product;
  final User buyer;
  final User seller;
  final DateTime createdAt;
  final DateTime updatedAt;
  final LastMessage? lastMessage;
  final int unreadCount;
  final List<ConversationMessage> messages;

  Conversation({
    required this.id,
    required this.product,
    required this.buyer,
    required this.seller,
    required this.createdAt,
    required this.updatedAt,
    this.lastMessage,
    required this.unreadCount,
    required this.messages,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: json['id'] as int,
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
      buyer: User.fromJson(json['buyer'] as Map<String, dynamic>),
      seller: User.fromJson(json['seller'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      lastMessage: json['last_message'] != null
          ? LastMessage.fromJson(json['last_message'] as Map<String, dynamic>)
          : null,
      unreadCount: json['unread_count'] as int,
      messages: (json['messages'] as List<dynamic>?)
              ?.map((e) =>
                  ConversationMessage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product.toJson(),
      'buyer': buyer.toJson(),
      'seller': seller.toJson(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'last_message': lastMessage?.toJson(),
      'unread_count': unreadCount,
      'messages': messages.map((message) => message.toJson()).toList(),
    };
  }
}
