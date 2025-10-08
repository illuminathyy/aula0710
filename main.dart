import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IdadePetApp(),
    );
  }
}

enum PetTipo { gato, cachorro }

class IdadePetApp extends StatefulWidget {
  const IdadePetApp({super.key});
  @override
  State<IdadePetApp> createState() => _IdadePetAppState();
}

class _IdadePetAppState extends State<IdadePetApp> {
  PetTipo _tipo = PetTipo.gato;
  double _peso = 4.0; // peso inicial (kg)
  int _idadeReal = 1; // idade real do pet (anos)

  /// Calcula a idade equivalente humana / fisiológica conforme tipo
  double calcularIdadeFisiologica() {
    if (_tipo == PetTipo.gato) {
      if (_idadeReal <= 0) return 0;
      if (_idadeReal == 1) {
        return 15.0;
      } else if (_idadeReal == 2) {
        return 15 + 10; // 25
      } else {
        // a partir do 3º ano, cada ano +4 anos humanos
        return 25 + ((_idadeReal - 2) * 4);
      }
    } else {
      // cachorro
      if (_idadeReal <= 0) return 0;
      if (_idadeReal == 1) {
        return 15.0;
      } else if (_idadeReal == 2) {
        return 15 + 9; // 24
      } else {
        // a partir do 3º ano, cada ano +5 anos humanos
        return 24 + ((_idadeReal - 2) * 5);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double idadeFisio = calcularIdadeFisiologica();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Idade Fisiológica de Pet"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Seleção de tipo (gato / cachorro)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceChip(
                  label: const Text("Gato"),
                  selected: _tipo == PetTipo.gato,
                  onSelected: (sel) {
                    setState(() {
                      _tipo = PetTipo.gato;
                    });
                  },
                ),
                const SizedBox(width: 16),
                ChoiceChip(
                  label: const Text("Cachorro"),
                  selected: _tipo == PetTipo.cachorro,
                  onSelected: (sel) {
                    setState(() {
                      _tipo = PetTipo.cachorro;
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Slider de peso
            Column(
              children: [
                Text(
                  "Peso: ${_peso.toStringAsFixed(1)} kg",
                  style: const TextStyle(fontSize: 18),
                ),
                Slider(
                  value: _peso,
                  min: 1.0,
                  max: 50.0,
                  divisions: 98,
                  label: _peso.toStringAsFixed(1),
                  onChanged: (val) {
                    setState(() {
                      _peso = val;
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Ajuste da idade real com botões
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () {
                    setState(() {
                      if (_idadeReal > 0) _idadeReal--;
                    });
                  },
                ),
                Text(
                  "Idade real: $_idadeReal anos",
                  style: const TextStyle(fontSize: 18),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: () {
                    setState(() {
                      _idadeReal++;
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 50),

            // Exibição do resultado
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.blueGrey[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    "Idade fisiológica estimada:",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "${idadeFisio.toStringAsFixed(1)} anos humanos",
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // (Opcional) rodapé ou botão estilizado
            Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: const Text(
                "🏥 Calcular novamente",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
