import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cálculo de Custo por Pessoa por Dia',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class GroupData {
  int numberOfPeople;
  int numberOfDays;

  GroupData({required this.numberOfPeople, required this.numberOfDays});

  @override
  String toString() {
    return 'Pessoas: $numberOfPeople, Dias: $numberOfDays';
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController totalValueController = TextEditingController();
  final TextEditingController numberOfPeopleController = TextEditingController();
  final TextEditingController numberOfDaysController = TextEditingController();

  List<GroupData> groups = [];
  String result = "";

  void addGroup() {
    int numberOfPeople = int.parse(numberOfPeopleController.text);
    int numberOfDays = int.parse(numberOfDaysController.text);

    setState(() {
      groups.add(GroupData(numberOfPeople: numberOfPeople, numberOfDays: numberOfDays));
      numberOfPeopleController.clear();
      numberOfDaysController.clear();
    });
  }

  void removeGroup(int index) {
    setState(() {
      groups.removeAt(index);
    });
  }

  void calculateCostPerDay() {
    double totalValue = double.parse(totalValueController.text);
    int totalPersonDays = groups.fold(0, (sum, item) => sum + (item.numberOfPeople * item.numberOfDays));
    double costPerPersonPerDay = totalValue / totalPersonDays;

    setState(() {
      result = "Custo por dia por pessoa: R\$${costPerPersonPerDay.toStringAsFixed(2)}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cálculo de Custo por Pessoa por Dia'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: totalValueController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Valor Total (R\$)'),
            ),
            TextField(
              controller: numberOfPeopleController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Quantidade de Pessoas'),
            ),
            TextField(
              controller: numberOfDaysController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Quantidade de Dias'),
            ),
            ElevatedButton(
              onPressed: addGroup,
              child: Text('Adicionar Grupo'),
            ),
            for (int i = 0; i < groups.length; i++)
              ListTile(
                title: Text(groups[i].toString()),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => removeGroup(i),
                ),
              ),
            ElevatedButton(
              onPressed: calculateCostPerDay,
              child: Text('Calcular'),
            ),
            Text(result),
          ],
        ),
      ),
    );
  }
}
