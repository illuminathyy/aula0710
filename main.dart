import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

const double alturaBotaoInferior = 80.0;
const Color corFundo = Color(0xFF1E164B);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: ImcCalculator(),
    );
  }
}

class ImcCalculator extends StatefulWidget {
  const ImcCalculator({super.key});

  @override
  State<ImcCalculator> createState() => _ImcCalculatorState();
}

class _ImcCalculatorState extends State<ImcCalculator> {
  double altura = 150.0;
  int peso = 65;
  String genero = "MASC";

  double get imc => peso / ((altura / 100) * (altura / 100));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('IMC')),
      body: Column(
        children: [
          // Gênero
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Caixa(
                    cor: corFundo,
                    filho: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              genero = "MASC";
                            });
                          },
                          icon: Icon(
                            Icons.male,
                            color:
                                genero == "MASC" ? Colors.blue : Colors.white,
                            size: 80.0,
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'MASC',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Caixa(
                    cor: corFundo,
                    filho: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              genero = "FEM";
                            });
                          },
                          icon: Icon(
                            Icons.female,
                            color: genero == "FEM" ? Colors.pink : Colors.white,
                            size: 80.0,
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'FEM',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Altura
          Expanded(
            child: Caixa(
              cor: corFundo,
              filho: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Altura:',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    altura.toStringAsFixed(0),
                    style: const TextStyle(
                      fontSize: 24.0,
                      color: Colors.white,
                    ),
                  ),
                  Slider(
                    value: altura,
                    min: 100,
                    max: 220,
                    divisions: 120,
                    label: altura.toStringAsFixed(0),
                    onChanged: (valor) {
                      setState(() {
                        altura = valor;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),

          // Peso e Resultado
          Expanded(
            child: Row(
              children: [
                // Peso
                Expanded(
                  child: Caixa(
                    cor: corFundo,
                    filho: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Peso:',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          peso.toString(),
                          style: const TextStyle(
                            fontSize: 24.0,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  peso++;
                                });
                              },
                              child: const Icon(Icons.add, color: Colors.white),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  if (peso > 1) peso--;
                                });
                              },
                              child:
                                  const Icon(Icons.remove, color: Colors.white),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),

                // Resultado
                Expanded(
                  child: Caixa(
                    cor: corFundo,
                    filho: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Resultado:',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          imc.toStringAsFixed(1),
                          style: const TextStyle(
                            fontSize: 24.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Rodapé
          Container(
            color: const Color(0xFF638ED6),
            width: double.infinity,
            height: alturaBotaoInferior,
            margin: const EdgeInsets.only(top: 10.0),
          ),
        ],
      ),
    );
  }
}

// Componente Caixa (Card Personalizado)
class Caixa extends StatelessWidget {
  final Color cor;
  final Widget? filho;

  const Caixa({required this.cor, this.filho, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: cor,
      ),
      child: filho,
    );
  }
}
