import 'package:flutter/material.dart';

import '../../models/grocery.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() {
    return _NewItemState();
  }
}

class _NewItemState extends State<NewItem> {

  // Default settings
  static const defaultQuantity = 1;
  static const defaultCategory = GroceryCategory.fruit;

  // Inputs
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  GroceryCategory _selectedCategory = defaultCategory;

  @override
  void initState() {
    super.initState();

    // Initialize intputs with default settings
    _quantityController.text = defaultQuantity.toString();
  }

  @override
  void dispose() {
    super.dispose();

    // Dispose the controlers
    _nameController.dispose();
    _quantityController.dispose();
  }

  void onReset() {
    setState(() {
      _nameController.clear();
      _quantityController.text = defaultQuantity.toString();
      _selectedCategory = defaultCategory;
    });
  }

  void onAdd() {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      return;
    }

    final quantity = int.tryParse(_quantityController.text) ?? defaultQuantity;

    final newGrocery = Grocery(
      id: DateTime.now().toString(),
      name: name,
      quantity: quantity,
      category: _selectedCategory,
    );

    Navigator.pop(context, newGrocery);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Add a new item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              maxLength: 50,
              decoration: InputDecoration(
                label: const Text('Name'),
                counterText: '${_nameController.text.length}/50',
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextField(
                    controller: _quantityController,
                    decoration: const InputDecoration(label: Text('Quantity')),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButtonFormField<GroceryCategory>(
                    value: _selectedCategory,
                    items: GroceryCategory.values.map((category) {
                      return DropdownMenuItem<GroceryCategory>(
                        value: category,
                        child: Row(
                          children: [
                            Container(
                              width: 15,
                              height: 15,
                              color: category.color,
                            ),
                            const SizedBox(width: 8),
                            Text(category.label.toLowerCase()),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _selectedCategory = value;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: onReset, child: const Text('Reset')),
                ElevatedButton(
                  onPressed: onAdd,
                  child: const Text('Add Item'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
