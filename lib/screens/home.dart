// lib/screens/home.dart
import 'package:flutter/material.dart';
import '../main.dart';
// La importación de reportes.dart está comentada ya que el archivo aún no existe
// import 'reportes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'UNIDAD: 18TUR3',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            Text(
              'BIENVENIDO: JUAN',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
        backgroundColor: Colors.teal,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.teal,
              ),
              child: Text(
                'Menú',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Inicio'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Reportar'),
              onTap: () {
                Navigator.pop(context);
                // La ruta de navegación está comentada hasta que reportes.dart esté disponible
                /*
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Reportapp()), // Reportapp será el nombre de la clase en reportes.dart
                  (route) => false,
                );
                */
              },
            ),
            ListTile(
              title: const Text(
                'Cerrar sesión',
                style: TextStyle(
                    color: Colors.white,
                    backgroundColor: Color.fromARGB(255, 235, 119, 24)),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const MyApp()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Text(
              'COMPAÑEROS:',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber),
            ),
            const SizedBox(height: 8),
            _buildUserTile('Juan Villegas Olmos Astete', isCurrentUser: true),
            const SizedBox(height: 4),
            const Text(
              'Compañeros:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            _buildUserTile('Carlos Adrian Flores Alabi'),
            _buildUserTile('Fabricio Zeballos Morales'),
            _buildUserTile('Jose Manuel Alejandro Calle'),
            const SizedBox(height: 16),
            const Text(
              'CONDUCTOR ASIGNADO:',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber),
            ),
            const SizedBox(height: 8),
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.red[300],
                child: const Icon(Icons.person, size: 50, color: Colors.white),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: _buildUserTile('Juan Villegas Olmos Astete',
                  isCurrentUser: true),
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade400,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: const Text(
                  'INICIAR RUTA',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserTile(String name, {bool isCurrentUser = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isCurrentUser ? Colors.grey[400] : Colors.greenAccent[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        isCurrentUser ? '(Usted) $name' : name,
        style: TextStyle(
          fontSize: 16,
          fontWeight: isCurrentUser ? FontWeight.bold : FontWeight.normal,
          color: isCurrentUser ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
