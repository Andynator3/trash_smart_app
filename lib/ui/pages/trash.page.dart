import 'package:flutter/material.dart';

class TrashPage extends StatelessWidget {
  const TrashPage({Key? key}) : super(key: key);

  // Données du Backend (type, poids, points, date)
  final List<Map<String, dynamic>> mockDeposits = const [
    {"id": 1, "type": "Bouteilles Plastiques", "weight": "1.2 kg", "points": 12, "date": "15 Juin 2026"},
    {"id": 2, "type": "Journaux & Cartons", "weight": "4.5 kg", "points": 45, "date": "12 Juin 2026"},
    {"id": 3, "type": "Canettes Aluminium", "weight": "0.8 kg", "points": 15, "date": "08 Juin 2026"},
    {"id": 4, "type": "Bouteilles en Verre", "weight": "3.0 kg", "points": 30, "date": "01 Juin 2026"},
  ];

  IconData _getIcon(String type) {
    if (type.contains("Plastique")) return Icons.layers_clear;
    if (type.contains("Verre")) return Icons.wine_bar;
    return Icons.delete_outline; // Correction ici : icône par défaut standard
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mes Dépôts Éco-Citoyens")),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: mockDeposits.length,
        itemBuilder: (context, index) {
          final deposit = mockDeposits[index];
          return Card(
            elevation: 1,
            margin: const EdgeInsets.symmetric(vertical: 6.0),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.teal.shade50,
                child: Icon(_getIcon(deposit["type"]), color: Colors.teal),
              ),
              title: Text(deposit["type"], style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("Déposé le : ${deposit["date"]} • Poids : ${deposit["weight"]}"),
              trailing: Text(
                "+${deposit["points"]} pts",
                style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          );
        },
      ),
    );
  }
}
