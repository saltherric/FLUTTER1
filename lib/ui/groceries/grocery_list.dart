import 'package:flutter/material.dart';
import '../../data/mock_grocery_repository.dart';
import '../../models/grocery.dart';
import 'grocery_form.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<Grocery> _groceryItems = List.from(dummyGroceryItems);

  Future<void> onCreate() async {
    final newGrocery = await Navigator.push<Grocery>(
      context,
      MaterialPageRoute(builder: (context) => const NewItem()),
    );

    if (newGrocery != null) {
      setState(() {
        _groceryItems.add(newGrocery);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added yet.'));

    if (_groceryItems.isNotEmpty) {
      //  1 - Display groceries with an Item builder and  LIst Tile
      content = ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: (context, index) =>
            GroceryTile(grocery: _groceryItems[index]),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [IconButton(onPressed: onCreate, icon: const Icon(Icons.add))],
      ),
      body: content,
    );
  }
}

class GroceryTile extends StatelessWidget {
  const GroceryTile({super.key, required this.grocery});

  final Grocery grocery;

  @override
  Widget build(BuildContext context) {
    //  2 - Display groceries with an Item builder and  LIst Tile
    return  ListTile(
      leading: Container(width: 15, height: 15, color:grocery.category.color,),
      title: Text(grocery.name),
      trailing: Text(grocery.quantity.toString()),
    );
  }
}
