import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A mock E-Commerce product model.
class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String description;
  final String category;
  final double? originalPrice;
  final int? discountPercentage;
  final bool isOnFlashSale;
  final bool isWishlisted;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.category,
    this.originalPrice,
    this.discountPercentage,
    this.isOnFlashSale = false,
    this.isWishlisted = false,
  });

  Product copyWith({
    String? id,
    String? name,
    double? price,
    String? imageUrl,
    String? description,
    String? category,
    double? originalPrice,
    int? discountPercentage,
    bool? isOnFlashSale,
    bool? isWishlisted,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      category: category ?? this.category,
      originalPrice: originalPrice ?? this.originalPrice,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      isOnFlashSale: isOnFlashSale ?? this.isOnFlashSale,
      isWishlisted: isWishlisted ?? this.isWishlisted,
    );
  }
}

/// State representation for the Shop feature screen.
class ShopState {
  final AsyncValue<List<Product>> products;
  final String searchQuery;
  final String selectedCategory;

  const ShopState({
    required this.products,
    this.searchQuery = '',
    this.selectedCategory = 'All',
  });

  ShopState copyWith({
    AsyncValue<List<Product>>? products,
    String? searchQuery,
    String? selectedCategory,
  }) {
    return ShopState(
      products: products ?? this.products,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}

/// Notifier controlling mock asynchronous product loadings and queries.
class ShopController extends Notifier<ShopState> {
  // A local list to track state changes like wishlist toggling
  late List<Product> _products;

  @override
  ShopState build() {
    // Initialize local list from the mock database
    _products = List.from(_mockDatabase);
    Future.microtask(() => fetchProducts());
    return const ShopState(products: AsyncValue.loading());
  }

  static const List<Product> _mockDatabase = [
    Product(
      id: '1',
      name: 'iPhone 15 Pro',
      price: 999.0,
      originalPrice: 1199.0,
      discountPercentage: 17,
      imageUrl:
          'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=600&auto=format&fit=crop&q=60',
      description:
          'Titanium design, A17 Pro chip, action button, and the most powerful iPhone camera system ever.',
      category: 'Phone',
      isOnFlashSale: true,
    ),
    Product(
      id: '2',
      name: 'Apple Watch Series 9',
      price: 399.0,
      originalPrice: 499.0,
      discountPercentage: 20,
      imageUrl:
          'https://images.unsplash.com/photo-1508685096489-7aacd43bd3b1?w=600&auto=format&fit=crop&q=60',
      description:
          'Smarter, brighter, mightier. Double tap gesture support and carbon neutral combinations.',
      category: 'Watch',
      isOnFlashSale: true,
    ),
    Product(
      id: '3',
      name: 'AirPods Pro 2',
      price: 189.0,
      originalPrice: 249.0,
      discountPercentage: 24,
      imageUrl:
          'https://images.unsplash.com/photo-1600294037681-c80b4cb5b434?w=600&auto=format&fit=crop&q=60',
      description:
          'Up to 2x more Active Noise Cancellation. Transparency mode, Adaptive Audio, and Sweat resistance.',
      category: 'Accessory',
      isOnFlashSale: true,
    ),
    Product(
      id: '4',
      name: 'MacBook Pro 14"',
      price: 1599.0,
      imageUrl:
          'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=600&auto=format&fit=crop&q=60',
      description:
          'Supercharged by M3 chip. Liquid Retina XDR display, pro ports, and up to 22 hours of battery life.',
      category: 'Laptop',
      isOnFlashSale: false,
    ),
    Product(
      id: '5',
      name: 'iPad Pro 11"',
      price: 799.0,
      imageUrl:
          'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=600&auto=format&fit=crop&q=60',
      description:
          'Astonishing performance in an incredibly thin and light design with Ultra Retina XDR display.',
      category: 'Accessory',
      isOnFlashSale: false,
    ),
    Product(
      id: '6',
      name: 'Apple Watch Ultra 2',
      price: 799.0,
      imageUrl:
          'https://images.unsplash.com/photo-1434494878577-86c23bcb06b9?w=600&auto=format&fit=crop&q=60',
      description:
          'The ultimate sports and adventure watch. Rugged titanium case, up to 36-hour battery life.',
      category: 'Watch',
      isOnFlashSale: false,
    ),
    Product(
      id: '7',
      name: 'AirPods Max',
      price: 549.0,
      imageUrl:
          'https://images.unsplash.com/photo-1618384887929-16ec33fab9ef?w=600&auto=format&fit=crop&q=60',
      description:
          'High-fidelity audio, Active Noise Cancellation with Transparency mode, and personalized spatial audio.',
      category: 'Accessory',
      isOnFlashSale: false,
    ),
  ];

  /// Simulates async loading latency before serving local mock database.
  Future<void> fetchProducts() async {
    state = state.copyWith(products: const AsyncValue.loading());
    await Future.delayed(const Duration(milliseconds: 1000));
    _updateFilteredList();
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
    _updateFilteredList();
  }

  void setCategory(String category) {
    state = state.copyWith(selectedCategory: category);
    _updateFilteredList();
  }

  /// Toggles the wishlist status of a product
  void toggleWishlist(String productId) {
    _products = _products.map((p) {
      if (p.id == productId) {
        return p.copyWith(isWishlisted: !p.isWishlisted);
      }
      return p;
    }).toList();
    _updateFilteredList();
  }

  void _updateFilteredList() {
    final filtered = _products.where((p) {
      final matchesCategory =
          state.selectedCategory == 'All' ||
          p.category == state.selectedCategory;
      final matchesSearch =
          p.name.toLowerCase().contains(state.searchQuery.toLowerCase()) ||
          p.description.toLowerCase().contains(state.searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    state = state.copyWith(products: AsyncValue.data(filtered));
  }
}

/// Global provider for ShopState.
final shopControllerProvider = NotifierProvider<ShopController, ShopState>(() {
  return ShopController();
});

/// Global provider to trigger scroll-to-top on Home screen.
final homeScrollTriggerProvider = NotifierProvider<HomeScrollTrigger, int>(() {
  return HomeScrollTrigger();
});

class HomeScrollTrigger extends Notifier<int> {
  @override
  int build() => 0;

  void trigger() {
    state++;
  }
}


