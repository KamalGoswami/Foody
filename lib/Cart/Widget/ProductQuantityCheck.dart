import 'package:flutter/material.dart';
import '../../Widget/AppWidget.dart';

class ProductQuantityCheck extends StatefulWidget {
  final int initialQuantity;
  final Function(int) onQuantityChanged; // Callback to notify quantity change
  final Function onRemoveItem; // Callback to notify item removal

  const ProductQuantityCheck({
    Key? key,
    this.initialQuantity = 1,
    required this.onQuantityChanged,
    required this.onRemoveItem,
  }) : super(key: key);

  @override
  _ProductQuantityCheck createState() => _ProductQuantityCheck();
}

class _ProductQuantityCheck extends State<ProductQuantityCheck> {
  late int _counter;

  @override
  void initState() {
    super.initState();
    _counter = widget.initialQuantity;
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    widget.onQuantityChanged(_counter); // Notify parent widget
  }

  void _decrementCounter() {
    if (_counter > 1) {
      setState(() {
        _counter--;
      });
      widget.onQuantityChanged(_counter); // Notify parent widget
    } else {
      _showRemoveDialog();
    }
  }

  void _showRemoveDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Remove Item'),
          content: const Text('Are you sure you want to remove this product from the cart?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
                widget.onRemoveItem(); // Notify parent widget to remove the item
              },
              child: const Text('Remove'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 125,
      padding: const EdgeInsets.all(AppWidget.sm),
      decoration: BoxDecoration(
        color: AppWidget.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: _decrementCounter,
            child: const Center(
              child: Icon(Icons.remove, size: 20),
            ),
          ),
          Text(
            '$_counter',
            style: AppWidget.subBoldFieldStyle(),
          ),
          GestureDetector(
            onTap: _incrementCounter,
            child: const Center(
              child: Icon(Icons.add, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
