import 'package:flutter/material.dart';
import 'medidor.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

bool animation = true;
double currentValue = 0;
double voltageValue = 0;
double powerValue = 0;

Future<Map<String, double>> dataReceiver() async {
  var url = 'http://localhost';
  var response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    var json = jsonDecode(response.body);

    voltageValue = double.parse(json['voltageValueJSON'].toString());
    currentValue = double.parse(json['currentValueJSON'].toString());

    return {
      'currentValueJSON': currentValue,
      'voltageValueJSON': voltageValue,
    };
  } else {
    throw Exception('Falha ao carregar dados');
  }
}

class TelaHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // Calcula a largura do padding lateral
    final double screenWidth = MediaQuery.of(context).size.width;
    final double padding = screenWidth * 0.05;

    powerValue = (currentValue * voltageValue);

    // Determina a cor baseada no tema
    final Color backgroundColor =
        Theme.of(context).brightness == Brightness.dark
            ? const Color.fromARGB(255, 10, 21, 50)
            : const Color.fromARGB(255, 30, 82, 144);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "WattSync",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: backgroundColor,
              ),
              height: 150,
              child: Stack(
                children: [
                  Center(
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Color.fromARGB(255, 30, 82, 144)
                              : Color.fromARGB(255, 10, 21, 50),
                        ),
                        width: 360,
                        height: 120,
                        padding: const EdgeInsets.only(top: 12.0, left: 25.0),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ('Seu consumo nos últimos 30 dias foi:'),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              ('R\$ XX.XX'),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                height: 3,
                              ),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey[850]
                      : Colors.grey[300],
                ),
                width: 360,
                height: 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      ('Limitador Ativado/Desativado'),
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )),
            Padding(
              padding: EdgeInsets.all(padding),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2.0,
                    mainAxisSpacing: 2.0,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio: 1,
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.black
                            : Colors.white,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                ('Tensão'),
                                style: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              medidor(
                                  //isso aqui é uma função feita lá no arquivo  "medidor.dart", sendo tudo isso aí de variável,
                                  Colors.blue, //cor de inicio(tipo Color)
                                  Colors.purple, //cor do final(tipo Color)
                                  0, //valor minimo(tipo double)
                                  240, // valor maximo(tipo double)
                                  powerValue, //valor atual(tipo double)
                                  animation, // animação(tipo bool)
                                  "V"), //letra (tipo str)
                            ]),
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.black
                            : Colors.white,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                ('Corrente'),
                                style: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              medidor(
                                  //isso aqui é uma função feita lá no arquivo  "medidor.dart", sendo tudo isso aí de variável,
                                  Colors.red, //cor de inicio(tipo Color)
                                  Colors.orange, //cor do final(tipo Color)
                                  0, //valor minimo(tipo double)
                                  16, // valor maximo(tipo double)
                                  currentValue, //valor atual(tipo double)
                                  animation, // animação(tipo bool)
                                  "A"), //letra (tipo str)
                            ]),
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.black
                            : Colors.white,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                ('Potência'),
                                style: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              medidor(
                                  //isso aqui é uma função feita lá no arquivo  "medidor.dart", sendo tudo isso aí de variável,
                                  Colors.green, //cor de inicio(tipo Color)
                                  Colors.yellow, //cor do final(tipo Color)
                                  0, //valor minimo(tipo double)
                                  4000, // valor maximo(tipo double)
                                  powerValue, //valor atual(tipo double)
                                  animation, // animação(tipo bool)
                                  "W"), //letra (tipo str)
                            ]),
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.black
                            : Colors.white,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                ('Lorem Ipsum'),
                                style: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              medidor(
                                  //isso aqui é uma função feita lá no arquivo  "medidor.dart", sendo tudo isso aí de variável,
                                  Colors.blue, //cor de inicio(tipo Color)
                                  Colors.purple, //cor do final(tipo Color)
                                  0, //valor minimo(tipo double)
                                  16, // valor maximo(tipo double)
                                  1, //valor atual(tipo double)
                                  true, // animação(tipo bool)
                                  "L"), //letra (tipo str)
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}