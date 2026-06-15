import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/bloc_users/users.bloc.dart';
import '../../blocs/bloc_users/users.event.dart';
import '../../blocs/bloc_users/users.state.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  void initState() {
    super.initState();
    // Déclenchement de l'appel réseau dès l'ouverture de la page
    context.read<UsersBloc>().add(LoadMyProfile());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mon Profil")),
      body: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, state) {
          if (state is UsersLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is UsersError) {
            return Center(
              child: Text(state.message, style: const TextStyle(color: Colors.red, fontSize: 18)),
            );
          }

          if (state is UsersLoaded) {
            final user = state.user;

            // Utilisation d'un scroll pour éviter les bugs d'affichage vertical
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. CARTE IDENTITÉ SÉCURITÉ (Username, Email, Rôle)
                  Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 30,
                            child: Icon(Icons.person, size: 35),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(user.username, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 4),
                                Text("Email : ${user.email}"),
                                const SizedBox(height: 4),
                                Text("Rôle : ${user.role}", style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.deepPurple)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 2. CARTE POINTS DE RÉCOMPENSE MÉTIER
                  Card(
                    color: Colors.green.shade50,
                    elevation: 2,
                    child: ListTile(
                      leading: const Icon(Icons.emoji_events, color: Colors.amber, size: 40),
                      title: const Text("Mes Points Récompense", style: TextStyle(fontWeight: FontWeight.bold)),
                      trailing: Text(
                        "${user.rewardPoints} pts",
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  const Text("Infos Citoyen", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),

                  // 3. CARTE COMPLÉMENTAIRE MÉTIER (Nom, Prénom, Téléphone)
                  Card(
                    elevation: 2,
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.badge, color: Colors.blue),
                          title: const Text("Nom complet"),
                          subtitle: Text("${user.firstName} ${user.lastName}"),
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: const Icon(Icons.phone, color: Colors.blue),
                          title: const Text("Téléphone"),
                          subtitle: Text(user.phone),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  const Text("Préférences", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),

                  // 4. CARTE PARAMÈTRES (GPS, Notifications)
                  Card(
                    elevation: 2,
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.location_on, color: Colors.grey),
                          title: const Text("Localisation GPS"),
                          trailing: Icon(
                            user.isLocationAccepted ? Icons.check_circle : Icons.cancel,
                            color: user.isLocationAccepted ? Colors.green : Colors.red,
                          ),
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: const Icon(Icons.notifications, color: Colors.grey),
                          title: const Text("Notifications Push"),
                          trailing: Icon(
                            user.pushNotificationsEnabled ? Icons.check_circle : Icons.cancel,
                            color: user.pushNotificationsEnabled ? Colors.green : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          return const Center(child: Text("Aucune donnée disponible."));
        },
      ),
    );
  }
}
