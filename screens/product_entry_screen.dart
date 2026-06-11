import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductEntryScreen extends StatefulWidget {
  const ProductEntryScreen({super.key});

  @override
  State<ProductEntryScreen> createState() => _ProductEntryScreenState();
}

class _ProductEntryScreenState extends State<ProductEntryScreen> {
  // Controladores de texto
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _priceController = TextEditingController();
  final _qtyController = TextEditingController();

  int _totalProducts = 0;
  double _totalPriceSum = 0.0;

Product? _mostExpensive;
Product? _cheapest;
Product? _highestQuantity;
Product? _lowestQuantity;
  void _registerProduct() {
    // Validar que los campos no estén vacíos
    if (_nameController.text.isEmpty || _priceController.text.isEmpty || _qtyController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, rellena los campos obligatorios')),
      );
      return;
    }

    final String name = _nameController.text;
    final String desc = _descController.text;
    final double price = double.tryParse(_priceController.text) ?? 0.0;
    final int qty = int.tryParse(_qtyController.text) ?? 0;

    final currentProduct = Product(name: name, description: desc, price: price, quantity: qty);

    setState(() {
      _totalProducts++;
      _totalPriceSum += price;

      if (_totalProducts == 1) {
        _mostExpensive = currentProduct;
        _cheapest = currentProduct;
        _highestQuantity = currentProduct;
        _lowestQuantity = currentProduct;
      } else {
        // Evaluaciones de Máximos y Mínimos
        if (price > _mostExpensive!.price) _mostExpensive = currentProduct;
        if (price < _cheapest!.price) _cheapest = currentProduct;
        if (qty > _highestQuantity!.quantity) _highestQuantity = currentProduct;
        if (qty < _lowestQuantity!.quantity) _lowestQuantity = currentProduct;
      }
    });

    // Limpiar campos
    _nameController.clear();
    _descController.clear();
    _priceController.clear();
    _qtyController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Producto "$name" registrado con éxito')),
    );
  }

  void _goToResults() {
    // Validación: Al menos un producto cargado
    if (_totalProducts == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Debe cargar al menos un producto antes de calcular.')),
      );
      return;
    }

    double averagePrice = _totalPriceSum / _totalProducts;

  
    Navigator.pushNamed(
      context,
      '/results',
      arguments: {
        'mostExpensive': _mostExpensive,
        'cheapest': _cheapest,
        'highestQuantity': _highestQuantity,
        'lowestQuantity': _lowestQuantity,
        'averagePrice': averagePrice,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Carga de Productos')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Nombre del Producto')),
            TextField(controller: _descController, decoration: const InputDecoration(labelText: 'Descripción')),
            TextField(controller: _priceController, decoration: const InputDecoration(labelText: 'Precio'), keyboardType: TextInputType.number),
            TextField(controller: _qtyController, decoration: const InputDecoration(labelText: 'Cantidad'), keyboardType: TextInputType.number),
            const SizedBox(height: 20),
            Text('Productos registrados actualmente: $_totalProducts', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _registerProduct,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text('Ingresar producto', style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: _goToResults,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text('Calcular', style: TextStyle(color: Colors.white)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
