import 'package:flutter/material.dart';

void main() {
  runApp(BharatPlantBazaarApp());
}

class BharatPlantBazaarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bharat Plant Bazaar',
      theme: ThemeData(primarySwatch: Colors.green),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> plants = [
    {
      'name': 'Tulsi (Holy Basil)',
      'price': '₹50',
      'image': 'https://i.imgur.com/Uw3z1kP.png',
      'description': 'Sacred Indian herb known for health benefits.',
    },
    {
      'name': 'Neem Plant',
      'price': '₹70',
      'image': 'https://i.imgur.com/w0J9QhK.png',
      'description': 'Used in Ayurvedic and natural remedies.',
    },
    {
      'name': 'Snake Plant',
      'price': '₹120',
      'image': 'https://i.imgur.com/LxJ5RHo.png',
      'description': 'Air-purifying and hardy plant.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("🙏 Namaste, Mia", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              Text("Take care of your green family!", style: TextStyle(fontSize: 16)),
              SizedBox(height: 15),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search for plants...',
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              SizedBox(height: 20),
              Text("Popular in India", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: plants.length,
                  itemBuilder: (context, index) {
                    final plant = plants[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PlantDetailScreen(plant: plant),
                          ),
                        );
                      },
                      child: Container(
                        width: 160,
                        margin: EdgeInsets.only(right: 16),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
                        ),
                        child: Column(
                          children: [
                            Hero(
                              tag: plant['name']!,
                              child: Image.network(plant['image']!, height: 90),
                            ),
                            SizedBox(height: 10),
                            Text(plant['name']!, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(plant['price']!, style: TextStyle(color: Colors.green[800])),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange[100],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Icon(Icons.flag, size: 40, color: Colors.orange),
                    SizedBox(width: 12),
                    Expanded(child: Text("🪔 Made with love in India", style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlantDetailScreen extends StatelessWidget {
  final Map<String, String> plant;

  const PlantDetailScreen({required this.plant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        backgroundColor: Colors.green[100],
        elevation: 0,
        leading: BackButton(color: Colors.black),
        actions: [Icon(Icons.favorite_border, color: Colors.black)],
      ),
      body: Column(
        children: [
          Hero(
            tag: plant['name']!,
            child: Image.network(plant['image']!, height: 200),
          ),
          SizedBox(height: 20),
          Text(
            plant['name']!,
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          Text(plant['price']!, style: TextStyle(fontSize: 20, color: Colors.green)),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _infoBox("☀️ Light", "50%"),
              _infoBox("💧 Water", "1.5L"),
              _infoBox("🌡️ Temp", "28°C"),
            ],
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "🪴 About: ${plant['description']!}\n\nPlants like Tulsi and Neem are sacred in Indian homes. They purify the air and promote well-being. Keep them in partial sunlight and water regularly.",
              style: TextStyle(fontSize: 16),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.shopping_cart),
              label: Text("Buy Now"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Colors.green[800],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoBox(String title, String value) {
    return Container(
      padding: EdgeInsets.all(12),
      width: 90,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(title, style: TextStyle(fontSize: 14)),
          Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
