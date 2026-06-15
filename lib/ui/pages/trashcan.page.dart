import 'package:flutter/material.dart';

class TrashcanPage extends StatelessWidget {
  const TrashcanPage({Key? key}) : super(key: key);

  // Simulation des données du Backend (id, nom, type, tauxRemplissage, statut)
  final List<Map<String, dynamic>> mockTrashcans = const [
    {"id": 1, "name": "Bornes Centre-Ville", "type": "Plastique/Carton", "fillLevel": 0.35, "status": "Actif"},
    {"id": 2, "name": "Collecteur Place du Capitole", "type": "Verre", "fillLevel": 0.88, "status": "Actif"},
    {"id": 3, "name": "Bac Quartier Gare", "type": "Déchets Ménagers", "fillLevel": 0.12, "status": "Actif"},
    {"id": 4, "name": "Borne Éco-Quartier", "type": "Métal/Canettes", "fillLevel": 0.95, "status": "Plein"},
  ];

  Color _getFillColor(double level) {
    if (level >= 0.85) return Colors.red;
    if (level >= 0.50) return Colors.orange;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Poubelles Connectées")),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: mockTrashcans.length,
        itemBuilder: (context, index) {
          final can = mockTrashcans[index];
          final double fill = can["fillLevel"];

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(can["name"], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: fill >= 0.90 ? Colors.red.shade50 : Colors.green.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          can["status"],
                          style: TextStyle(color: fill >= 0.90 ? Colors.red : Colors.green, fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text("Type accepté : ${can["type"]}", style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.restore_from_trash_outlined, color: _getFillColor(fill)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            value: fill,
                            backgroundColor: Colors.grey.shade200,
                            valueColor: AlwaysStoppedAnimation<Color>(_getFillColor(fill)),
                            minHeight: 10,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text("${(fill * 100).toInt()}%", style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
