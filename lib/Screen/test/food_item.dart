import 'package:flutter/material.dart';

class FoodItemList extends StatefulWidget {
  const FoodItemList({Key? key}) : super(key: key);

  @override
  State<FoodItemList> createState() => _FoodItemListState();
}

class _FoodItemListState extends State<FoodItemList> {

  List<FoodItem> _foodItems = [
    FoodItem(
      name: "Pizza",
      description: "A delicious pizza with pepperoni and mozzarella cheese.",
      price: 12.99,
      imageUrl: "https://www.google.com/url?sa=i&url=https%3A%2F%2Funsplash.com%2Fimages%2Ffood%2Fpizza&psig=AOvVaw2K5FTBX1c3RhGTqJaRRr8d&ust=1674120765153000&source=images&cd=vfe&ved=0CA8QjRxqFwoTCPDoyP3n0PwCFQAAAAAdAAAAABAE",
    ),
    FoodItem(
      name: "Hamburger",
      description: "A juicy hamburger with lettuce, tomato, and cheese.",
      price: 8.99,
      imageUrl: "https://example.com/hamburger.jpg",
    ),
    FoodItem(
      name: "Salad",
      description: "A healthy salad with mixed greens, tomatoes, and cucumbers.",
      price: 5.99,
      imageUrl: "https://example.com/salad.jpg",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Food Items"),
      ),
      body: ListView.builder(
        itemCount: _foodItems.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: <Widget>[
                Image.network(_foodItems[index].imageUrl!),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Text(_foodItems[index].name!, style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 8.0),
                      Text(_foodItems[index].description!),
                      SizedBox(height: 8.0),
                      Text("Price: \$" + _foodItems[index].price.toString()),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
class FoodItem{
  String? name;
  String? description;
  String? imageUrl;
  double? price;
  FoodItem({this.name, this.description, this.imageUrl, this.price});
}