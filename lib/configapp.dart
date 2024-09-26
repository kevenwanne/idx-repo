import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wattsync/configdispositivo.dart';
import 'package:wattsync/navigationbar.dart';

class ConfigPage extends StatelessWidget {
  final String title;
  ConfigPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.bottomCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Tema', style: TextStyle(fontSize: 18)),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text('Claro'),
                            SizedBox(height: 8),
                            Radio<bool>(
                              value: false,
                              groupValue: Provider.of<AppController>(context)
                                  .isDartTheme,
                              onChanged: (bool? value) {
                                Provider.of<AppController>(context,
                                        listen: false)
                                    .changeTheme(false);
                              },
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text('Escuro'),
                            SizedBox(height: 8),
                            Radio<bool>(
                              value: true,
                              groupValue: Provider.of<AppController>(context)
                                  .isDartTheme,
                              onChanged: (bool? value) {
                                Provider.of<AppController>(context,
                                        listen: false)
                                    .changeTheme(true);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 32),
                    Text('Custo do Kilowatt (Kw/h)',
                        style: TextStyle(fontSize: 18)),
                    SizedBox(height: 16),
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Digite o valor',
                      ),
                    ),
                    SizedBox(height: 2),
                  ],
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // TODO: Salvar as configurações
                },
                child: Text('Salvar'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // TODO: Abrir a tela de limite de consumo
                },
                child: Text('Definir limite de consumo'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => configDispositivo()),
                  );
                },
                child: Text('Configurações do Dispositivo'),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
