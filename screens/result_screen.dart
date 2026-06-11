import 'package:flutter/material.dart';
import '../models/product.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final Product mostExpensive = args['mostExpensive'];
    final Product cheapest = args['cheapest'];
    final Product highestQuantity = args['highestQuantity'];
    final Product lowestQuantity = args['lowestQuantity'];
    final double averagePrice = args['averagePrice'];

    return Scaffold(
      appBar: AppBar(title: const Text('Resultados del Cálculo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildResultCard(
              title: 'Producto Más Caro',
              name: mostExpensive.name,
              desc: mostExpensive.description,
              value: '\$${mostExpensive.price.toStringAsFixed(2)}',
            ),
            _buildResultCard(
              title: 'Producto Más Barato',
              name: cheapest.name,
              desc: cheapest.description,
              value: '\$${cheapest.price.toStringAsFixed(2)}',
            ),
            _buildResultCard(
              title: 'Mayor Cantidad',
              name: highestQuantity.name,
              desc: highestQuantity.description,
              value: '${highestQuantity.quantity} unidades',
            ),
            _buildResultCard(
              title: 'Menor Cantidad',
              name: lowestQuantity.name,
              desc: lowestQuantity.description,
              value: '${lowestQuantity.quantity} unidades',
            ),
            const Divider(height: 30, thickness: 2),
            Card(
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Precio Promedio:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '\$${averagePrice.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Volver a cargar'),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard({required String title, required String name, required String desc, required String value}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo)),
        subtitle: Text('Nombre: $name\nDescripción: ${desc.isEmpty ? "Sin descripción" : desc}'),
        trailing: Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        isThreeLine: true,
      ),
    );
  }
}
