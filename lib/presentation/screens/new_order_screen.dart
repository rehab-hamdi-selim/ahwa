import 'package:ahwa/core/colors.dart';
import 'package:ahwa/models/drinks.dart';
import 'package:ahwa/models/order.dart';
import 'package:ahwa/models/order_store.dart';
import 'package:flutter/material.dart';

class NewOrderScreen extends StatefulWidget {
  const NewOrderScreen({super.key});

  @override
  State<NewOrderScreen> createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();

  final List<Drink> drinks = [
    ShaiDrink(),
    TurkishCoffeeDrink(),
    HibiscusTeaDrink(),
  ];

  Drink? selectedDrink;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  void _saveOrder() {
    final formOk = _formKey.currentState?.validate() ?? false;
    if (!formOk) return;

    final order = Order(
      customerName: _nameCtrl.text.trim(),
      drink: selectedDrink!,
      instructions: _notesCtrl.text.trim().isEmpty
          ? null
          : _notesCtrl.text.trim(),
    );

    OrdersStore().add(order);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Order Saved Successfully')));

    _formKey.currentState?.reset();
    _nameCtrl.clear();
    _notesCtrl.clear();
    setState(() => selectedDrink = null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Make Order')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17),
                color: Colors.white,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  spacing: 20,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Customer Name
                    Column(
                      spacing: 18,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Customer name',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                          ),
                        ),
                        TextFormField(
                          controller: _nameCtrl,
                          validator: (txt) {
                            if (txt == null || txt.trim().isEmpty) {
                              return "Name cannot be empty";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            focusColor: MyColors().darkBrown,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Drink Dropdown
                    Card(
                      shadowColor: MyColors().darkBrown,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5.0,
                          horizontal: 10,
                        ),
                        child: DropdownButtonFormField<Drink>(
                          borderRadius: BorderRadius.circular(25),
                          menuMaxHeight: 200,
                          focusColor: MyColors().darkBrown,
                          dropdownColor: MyColors().lightBrown,
                          isExpanded: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          hint: const Text(
                            "Select a drink",
                            style: TextStyle(fontSize: 20),
                          ),
                          value: selectedDrink,
                          items: drinks.map((drink) {
                            return DropdownMenuItem(
                              value: drink,
                              child: Text(
                                '${drink.name} • ${drink.price.toStringAsFixed(0)} EGP',
                                style: TextStyle(color: MyColors().darkBrown),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) =>
                              setState(() => selectedDrink = value),
                          validator: (value) =>
                              value == null ? 'Please select a drink' : null,
                        ),
                      ),
                    ),

                    // Notes / Suggestions
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Suggestion',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _notesCtrl,
                          decoration: InputDecoration(
                            hintText: 'e.g., extra mint, ya rais',
                            focusColor: MyColors().darkBrown,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.33),

            // Save Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors().darkBrown,
              ),
              onPressed: _saveOrder,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15),
                child: Text(
                  'Save Order',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
