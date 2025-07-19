import 'package:flutter/material.dart';

void main() {
  runApp(GroceryApp());
}

class GroceryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bharat Bazaar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: GroceryHomeScreen(),
    );
  }
}

class GroceryHomeScreen extends StatefulWidget {
  @override
  _GroceryHomeScreenState createState() => _GroceryHomeScreenState();
}

class _GroceryHomeScreenState extends State<GroceryHomeScreen> {
  int _selectedDeliveryIndex = 0;

  final List<Map<String, String>> products = [
    {
      'name': 'Desi Sabziyaan',
      'price': '₹100.00',
      'image': 'https://i.imgur.com/z2gzuVb.jpg',
      'description': 'Taza aur swachh sabziyaan, Bharat ke khet se seedha aapke ghar tak!',
    },
    {
      'name': 'Organic Bhaji',
      'price': '₹150.00',
      'image': 'https://i.imgur.com/YBzW6bG.jpg',
      'description': 'Organic bhajiyaan, bina kisi chemicals ke, apke swasthya ke liye!',
    },
  ];

  final List<String> categories = ['Masale', 'Taza', 'Bakery', 'Anaj', 'Jeevika'];

  void _onDeliveryTypeSelected(int index) {
    setState(() {
      _selectedDeliveryIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("📍 Aapka Location", style: TextStyle(color: Colors.grey)),
              Text("Shivaji Nagar, Pune", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              Row(
                children: [
                  _deliveryTypeButton("Delivery", Icons.delivery_dining, 0),
                  SizedBox(width: 10),
                  _deliveryTypeButton("Pickup", Icons.store, 1),
                ],
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.category, size: 20),
                          SizedBox(width: 5),
                          Text(categories[index]),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Text("Lokpriya vastu", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final item = products[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductDetailScreen(product: item),
                          ),
                        );
                      },
                      child: Card(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(item['image']!, width: 100, height: 100, fit: BoxFit.cover),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item['name']!, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                  Text(item['price']!),
                                  Row(
                                    children: [
                                      Icon(Icons.timer, size: 14),
                                      Text(" 10 min "),
                                      Icon(Icons.star, size: 14, color: Colors.orange),
                                      Text(" 4.0"),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios, size: 16),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.green,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Ghar"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  Widget _deliveryTypeButton(String title, IconData icon, int index) {
    final bool isSelected = _selectedDeliveryIndex == index;
    return Expanded(
      child: ElevatedButton.icon(
        onPressed: () => _onDeliveryTypeSelected(index),
        icon: Icon(icon, color: isSelected ? Colors.white : Colors.black),
        label: Text(title),
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.green : Colors.white,
          foregroundColor: isSelected ? Colors.white : Colors.black,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }
}

class ProductDetailScreen extends StatelessWidget {
  final Map<String, String> product;

  const ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Vastu Detail", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.grey[100],
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Image.network(product['image']!, height: 200),
            SizedBox(height: 20),
            Text(product['name']!, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(product['price']!, style: TextStyle(fontSize: 20, color: Colors.green)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.timer, size: 18),
                SizedBox(width: 5),
                Text("10 min"),
                SizedBox(width: 20),
                Icon(Icons.star, size: 18, color: Colors.orange),
                Text(" 4.0 Rating"),
              ],
            ),
            SizedBox(height: 20),
            Text(product['description']! + " Aur padhein...",
                style: TextStyle(fontSize: 16), textAlign: TextAlign.center),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.remove_circle_outline)),
                Text("1", style: TextStyle(fontSize: 18)),
                IconButton(onPressed: () {}, icon: Icon(Icons.add_circle_outline)),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.shopping_cart),
              label: Text("Cart mein daalein"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
            )
          ],
        ),
      ),
    );
  }
}
