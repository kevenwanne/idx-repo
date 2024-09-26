import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TelaAlarme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ActivationManager();
  }
}

class ActivationManager extends StatefulWidget {
  const ActivationManager({super.key});

  @override
  _ActivationManagerState createState() => _ActivationManagerState();
}

class _ActivationManagerState extends State<ActivationManager> {
  final _schedules = <Schedule>[
    Schedule(DateTime.now(), TimeOfDay(hour: 5, minute: 30),
        TimeOfDay(hour: 14, minute: 30))
  ];
  bool _isActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Gerenciador de Ativação',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Color.fromARGB(255, 10, 21, 50)
            : Color.fromARGB(255, 30, 82, 144),
      ),
      body: ListView.builder(
        itemCount: _schedules.length + 1, // Adicione 1 para o Switch e o Text
        itemBuilder: (context, index) {
          if (index < _schedules.length) {
            //DELETAR ALARME ARRASTANDO PRA ESQUERDA
            return Dismissible(
              key: Key(_schedules[index].date.toString()),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                setState(() {
                  _schedules.removeAt(index);
                });
              },
              background: Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 20.0),
                color: Colors.red,
                child: Icon(Icons.delete, color: Colors.white),
              ),

              //TELINHA DO ALARME
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: 400,
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Color.fromARGB(255, 66, 14, 84)
                        : Color.fromARGB(255, 116, 50, 157),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Alarme ${index + 1}: ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 5),

                      /* CALENDÁRIO
                
                         ElevatedButton(
                          onPressed: () async {
                            final DateTime? newDate = await showDatePicker(
                                context: context,
                                initialDate: _schedules[index].date,
                                firstDate: DateTime(2022),
                                lastDate: DateTime(2030));
                            if (newDate != null) {
                              setState(() {
                                _schedules[index] = Schedule(
                                    newDate,
                                    _schedules[index].startTime,
                                    _schedules[index].endTime);
                              });
                            }
                          },
                          child: Text(
                              _schedules[index].date.toString().split(' ').first),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).brightness == Brightness.dark
                                  ? Color.fromARGB(255, 66, 14, 84)
                                  : Color.fromARGB(255, 116, 50, 157),
                            ),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                          ),
                        ), */

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'De: ',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),

                          //PROGRAMAR HORÁRIO "DE"
                          TextButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 255, 255, 255),
                              ),
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.zero),
                              overlayColor: MaterialStateProperty.all<Color>(
                                  Colors.transparent),
                            ),
                            onPressed: () async {
                              final TimeOfDay? newTime = await showTimePicker(
                                  context: context,
                                  initialTime: _schedules[index].startTime,
                                  builder: (context, child) {
                                    return MediaQuery(
                                      data: MediaQuery.of(context).copyWith(
                                          alwaysUse24HourFormat: true),
                                      child: child!,
                                    );
                                  });
                              if (newTime != null) {
                                setState(() {
                                  _schedules[index] = Schedule(
                                      _schedules[index].date,
                                      newTime,
                                      _schedules[index].endTime);
                                });
                              }
                            },
                            child: Text(
                              MaterialLocalizations.of(context).formatTimeOfDay(
                                  _schedules[index].startTime,
                                  alwaysUse24HourFormat: true),
                              style: TextStyle(
                                fontSize: 40,
                              ),
                            ),
                          ),

                          //ESPAÇAMENTO
                          SizedBox(width: 10),

                          Text(
                            'Até: ',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),

                          //PROGRAMAR HORÁRIO "ATÉ"
                          TextButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 255, 255, 255),
                              ),
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.zero),
                              overlayColor: MaterialStateProperty.all<Color>(
                                  Colors.transparent),
                            ),
                            onPressed: () async {
                              final TimeOfDay? newTime = await showTimePicker(
                                  context: context,
                                  initialTime: _schedules[index].endTime,
                                  builder: (context, child) {
                                    return MediaQuery(
                                      data: MediaQuery.of(context).copyWith(
                                          alwaysUse24HourFormat: true),
                                      child: child!,
                                    );
                                  });
                              if (newTime != null) {
                                setState(() {
                                  _schedules[index] = Schedule(
                                      _schedules[index].date,
                                      _schedules[index].startTime,
                                      newTime);
                                });
                              }
                            },
                            child: Text(
                              MaterialLocalizations.of(context).formatTimeOfDay(
                                  _schedules[index].endTime,
                                  alwaysUse24HourFormat: true),
                              style: TextStyle(
                                fontSize: 40,
                              ),
                            ),
                          ),

                          //ATIVAR OU DESATIVAR ALARME
                          Switch(
                            value: _schedules[index].isActive,
                            activeColor: Colors.white,
                            inactiveTrackColor: Colors.grey[300],
                            inactiveThumbColor: Colors.white,
                            activeTrackColor:
                                Color.fromARGB(255, 137, 191, 255),
                            onChanged: (value) {
                              setState(() {
                                _schedules[index] = Schedule(
                                    _schedules[index].date,
                                    _schedules[index].startTime,
                                    _schedules[index].endTime,
                                    isActive: value);
                              });
                            },
                          ),
                        ],
                      ),
                      //DIAS DA SEMANA
                      WeekdayToggleButtons(),
                    ],
                  ),
                ),
              ),
            );
          } else {
            //BOTÃO SWITCH PARA ATIVAR OU DESATIVAR O DISPOSITIVO
            return Column(
              children: [
                Switch(
                  value: _isActive,
                  activeColor: Colors.white,
                  inactiveTrackColor: Colors.grey[700],
                  inactiveThumbColor: Colors.white,
                  activeTrackColor:
                      Theme.of(context).brightness == Brightness.dark
                          ? Color.fromARGB(255, 137, 191, 255)
                          : Color.fromARGB(255, 30, 82, 144),
                  onChanged: (value) {
                    setState(() {
                      _isActive = value;
                    });
                  },
                ),
                Text(_isActive ? 'Ativado' : 'Desativado'),
              ],
            );
          }
        },
      ),

      //ADICIONAR ALARME
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _schedules.add(Schedule(DateTime.now(),
                TimeOfDay(hour: 0, minute: 0), TimeOfDay(hour: 0, minute: 0)));
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<Schedule>('_schedules', _schedules));
  }
}

class Schedule {
  DateTime date;
  TimeOfDay startTime;
  TimeOfDay endTime;
  bool isActive;

  Schedule(this.date, this.startTime, this.endTime, {this.isActive = true});
}

//DIAS DA SEMANA TOGGLEBUTTON

class WeekdayToggleButtons extends StatefulWidget {
  @override
  _WeekdayToggleButtonsState createState() => _WeekdayToggleButtonsState();
}

class _WeekdayToggleButtonsState extends State<WeekdayToggleButtons> {
  List<bool> isSelected = [false, false, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ToggleButtons(
          isSelected: isSelected,
          onPressed: (int index) {
            setState(() {
              isSelected[index] = !isSelected[index];
            });
          },
          borderRadius: BorderRadius.circular(50),
          borderColor: Colors.transparent,
          selectedBorderColor: Colors.transparent,
          fillColor: Colors.transparent,
          selectedColor: Colors.transparent,
          color: Colors.white,
          children: [
            _buildToggleButton('D', isSelected[0]),
            _buildToggleButton('S', isSelected[1]),
            _buildToggleButton('T', isSelected[2]),
            _buildToggleButton('Q', isSelected[3]),
            _buildToggleButton('Q', isSelected[4]),
            _buildToggleButton('S', isSelected[5]),
            _buildToggleButton('S', isSelected[6]),
          ],
        ),
      ],
    );
  }

  Widget _buildToggleButton(String text, bool isSelected) {
    return Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected
            ? Colors.transparent
            : Color.fromARGB(255, 137, 191, 255),
        border: Border.all(
          color: isSelected ? Colors.white : Colors.transparent,
          width: 2,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
