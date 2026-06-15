import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("TrashSmart Dashboard")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Bienvenue sur TrashSmart,", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),

            // GRILLE DES STATISTIQUES GLOBALES (KPI Backend)
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.5,
              children: [
                _buildStatCard("Mon Solde", "150 Points", Icons.emoji_events, Colors.amber),
                _buildStatCard("Total Recyclé", "9.5 kg", Icons.scale, Colors.teal),
                _buildStatCard("Bornes Actives", "24 Bornes", Icons.location_on, Colors.blue),
                _buildStatCard("Alertes Plein", "1 Borne", Icons.warning, Colors.red),
              ],
            ),

            const SizedBox(height: 25),
            const Text("Accès Rapides Modules", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            // LISTE DES RACCOURCIS POUR LA DÉMO
            _buildMenuShortcut(context, "Gérer mon Profil", "/users", Icons.account_circle, Colors.deepPurple),
            _buildMenuShortcut(context, "Poubelles à proximité", "/trashcan", Icons.delete_sweep, Colors.green),
            _buildMenuShortcut(context, "Historique des déchets", "/trash", Icons.history, Colors.orange),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 24),
                const SizedBox(width: 8),
                Text(title, style: const TextStyle(color: Colors.grey, fontSize: 13)),
              ],
            ),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuShortcut(BuildContext context, String title, String route, IconData icon, Color color) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => Navigator.pushNamed(context, route),
      ),
    );
  }
}
