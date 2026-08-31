import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../providers/cart_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<Map<String, dynamic>> categories = const [
    {'title': 'Groceries', 'icon': Icons.shopping_basket_outlined, 'color': Color(0xFFE8F5E9)},
    {'title': 'Medicines', 'icon': Icons.medical_services_outlined, 'color': Color(0xFFE3F2FD)},
    {'title': 'Fresh Veggies', 'icon': Icons.eco_outlined, 'color': Color(0xFFF1F8E9)},
    {'title': 'Dairy & Milk', 'icon': Icons.water_drop_outlined, 'color': Color(0xFFFFF3E0)},
    {'title': 'Snacks & Drinks', 'icon': Icons.fastfood_outlined, 'color': Color(0xFFFCE4EC)},
    {'title': 'Meat & Fish', 'icon': Icons.set_meal_outlined, 'color': Color(0xFFFFEBEE)},
  ];

  final List<Map<String, dynamic>> flashDeals = const [
    {
      'id': 'p1',
      'title': 'Heritage Toned Milk',
      'unit': '500 ml',
      'price': 30.0,
      'oldPrice': 32.0,
      'image': 'https://via.placeholder.com/150',
    },
    {
      'id': 'p2',
      'title': 'Dolo 650mg Tablet',
      'unit': '15 Tablets',
      'price': 34.0,
      'oldPrice': 38.0,
      'image': 'https://via.placeholder.com/150',
    },
    {
      'id': 'p3',
      'title': 'Fresh Country Tomatoes',
      'unit': '1 kg',
      'price': 28.0,
      'oldPrice': 40.0,
      'image': 'https://via.placeholder.com/150',
    },
    {
      'id': 'p4',
      'title': 'Aashirvaad Atta',
      'unit': '5 kg',
      'price': 245.0,
      'oldPrice': 270.0,
      'image': 'https://via.placeholder.com/150',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Top Location & Delivery Time Bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                color: Colors.white,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.flash_on, color: AppColors.primary, size: 22),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '⚡ 15 MINS DELIVERY',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.primary,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              Icon(Icons.keyboard_arrow_down, size: 18, color: AppColors.primary),
                            ],
                          ),
                          Text(
                            'VRC Centre, Nellore',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.notifications_none, color: AppColors.textPrimary),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),

              // 2. Search Bar
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.cardBorder),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.search, color: AppColors.textMuted),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Search "Milk, Dolo 650, Vegetables, Rice"...',
                          style: TextStyle(color: AppColors.textMuted, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 3. Flash Deal Promo Banner
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryDark],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Flash2Mart Nellore ⚡',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Flat ₹50 OFF on your first 3 orders above ₹199!',
                            style: TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('Claim', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // 4. Multi-Service Categories
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Explore Categories',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                ),
              ),
              const SizedBox(height: 12),
              GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.0,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: cat['color'],
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.cardBorder),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(cat['icon'], size: 32, color: AppColors.primaryDark),
                        const SizedBox(height: 8),
                        Text(
                          cat['title'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                        ),
                      ],
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),

              // 5. Flash Deals / Instant Products
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '⚡ Flash Deals & Daily Essentials',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                    ),
                    Text('See All', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 12)),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 220,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: flashDeals.length,
                  itemBuilder: (context, index) {
                    final item = flashDeals[index];
                    final qty = cart.getItemQuantity(item['id']);

                    return Container(
                      width: 150,
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.cardBorder),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 80,
                            decoration: BoxDecoration(
                              color: AppColors.background,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Icon(Icons.shopping_bag_outlined, color: AppColors.primary, size: 36),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            item['title'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                          Text(
                            item['unit'],
                            style: const TextStyle(color: AppColors.textSecondary, fontSize: 11),
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '₹${item['price'].toInt()}',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textPrimary),
                              ),
                              qty == 0
                                  ? SizedBox(
                                      height: 30,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          cart.addItem(item['id'], item['title'], item['price'], item['unit'], item['image']);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.primaryLight,
                                          foregroundColor: AppColors.primary,
                                          elevation: 0,
                                          padding: const EdgeInsets.symmetric(horizontal: 12),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                        ),
                                        child: const Text('ADD', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                                      ),
                                    )
                                  : Container(
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Row(
                                        children: [
                                          IconButton(
                                            padding: EdgeInsets.zero,
                                            constraints: const BoxConstraints(minWidth: 24),
                                            icon: const Icon(Icons.remove, color: Colors.white, size: 16),
                                            onPressed: () => cart.removeSingleItem(item['id']),
                                          ),
                                          Text(
                                            '$qty',
                                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                                          ),
                                          IconButton(
                                            padding: EdgeInsets.zero,
                                            constraints: const BoxConstraints(minWidth: 24),
                                            icon: const Icon(Icons.add, color: Colors.white, size: 16),
                                            onPressed: () => cart.addItem(item['id'], item['title'], item['price'], item['unit'], item['image']),
                                          ),
                                        ],
                                      ),
                                    ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}