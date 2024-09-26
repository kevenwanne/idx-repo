import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class TelaHistorico extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HistoricPage();
  }
}

class HistoricPage extends StatefulWidget {
  HistoricPage({Key? key}) : super(key: key);

  @override
  HistoricPageState createState() => HistoricPageState();
}

class HistoricPageState extends State<HistoricPage> {
  String dropdownValue = 'Últimas 24h';
  List<_SalesData> data = [
    _SalesData('00h', 0),
    _SalesData('05h', 4),
    _SalesData('10h', 6),
    _SalesData('15h', 8),
    _SalesData('20h', 10)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de consumo'),
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Color.fromARGB(255, 10, 21, 50)
            : Color.fromARGB(255, 30, 82, 144),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DropdownMenu2(
              onChanged: (value) {
                setState(() {
                  dropdownValue = value;
                  data = _getDataBasedOnSelection(value);
                });
              },
            ),
            SfCartesianChart(
              primaryXAxis: CategoryAxis(
                labelStyle: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey[500]
                        : Colors.grey[700],
                    fontWeight: FontWeight.bold),
              ),
              primaryYAxis: NumericAxis(
                labelStyle: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey[500]
                        : Colors.grey[700],
                    fontWeight: FontWeight.bold),
              ),
              title: ChartTitle(
                text: 'Histórico de Consumo',
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              legend: Legend(
                isVisible: true,
                textStyle: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <CartesianSeries<_SalesData, String>>[
                LineSeries<_SalesData, String>(
                  dataSource: data,
                  xValueMapper: (_SalesData sales, _) => sales.year,
                  yValueMapper: (_SalesData sales, _) => sales.sales,
                  name: 'Consumo',
                  color: Color.fromARGB(255, 116, 50, 157),
                  dataLabelSettings: DataLabelSettings(
                      isVisible: true,
                      textStyle:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  markerSettings: MarkerSettings(
                    isVisible: true,
                    shape: DataMarkerType.circle,
                    color: Color.fromARGB(255, 116, 50, 157),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SfSparkLineChart.custom(
                trackball: SparkChartTrackball(
                    activationMode: SparkChartActivationMode.tap),
                marker: SparkChartMarker(
                    displayMode: SparkChartMarkerDisplayMode.all),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<_SalesData> _getDataBasedOnSelection(String selection) {
    // Implement logic to return different data based on the selection
    // For demonstration, we will just return different sets of static data

    switch (selection) {
      case 'Últimos 7 dias':
        return [
          _SalesData('Dom', 1),
          _SalesData('Seg', 5),
          _SalesData('Ter', 10),
          _SalesData('Qua', 15),
          _SalesData('Qui', 20),
          _SalesData('Sex', 25),
          _SalesData('Sab', 30)
        ];
      case 'Últimos 15 dias':
        return [_SalesData('Sem 1', 50), _SalesData('Sem 2', 30)];
      case 'Últimos 30 dias':
        return [
          _SalesData('Sem 1', 20),
          _SalesData('Sem 2', 25),
          _SalesData('Sem 3', 30)
        ];
      case 'Últimos 6 meses':
        return [
          _SalesData('Jan', 35),
          _SalesData('Feb', 30),
          _SalesData('Mar', 33),
          _SalesData('Apr', 31),
          _SalesData('May', 40),
          _SalesData('Jun', 40)
        ];
      case 'Últimos 12 meses':
        return [
          _SalesData('Jan', 35),
          _SalesData('Feb', 30),
          _SalesData('Mar', 33),
          _SalesData('Apr', 31),
          _SalesData('May', 40),
          _SalesData('Jun', 10),
          _SalesData('Jul', 20),
          _SalesData('Ago', 30),
          _SalesData('Set', 50),
          _SalesData('Out', 10),
          _SalesData('Nov', 30),
          _SalesData('Dec', 20)
        ];
      default:
        return [
          _SalesData('00h', 0),
          _SalesData('05h', 4),
          _SalesData('10h', 6),
          _SalesData('15h', 8),
          _SalesData('20h', 10)
        ];
    }
  }
}

class DropdownMenu2 extends StatefulWidget {
  final ValueChanged<String> onChanged;

  const DropdownMenu2({super.key, required this.onChanged});

  @override
  State<DropdownMenu2> createState() => _DropdownMenuState();
}

const List<String> list = <String>[
  'Últimas 24h',
  'Últimos 7 dias',
  'Últimos 15 dias',
  'Últimos 30 dias',
  'Últimos 6 meses',
  'Últimos 12 meses'
];

class _DropdownMenuState extends State<DropdownMenu2> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
        widget.onChanged(dropdownValue);
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value,
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
                fontSize: 20,
              )),
        );
      }).toList(),
      icon: Icon(
        Icons.arrow_downward,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black,
      ),
      iconSize: 24,
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
