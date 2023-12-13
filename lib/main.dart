import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora Ranson',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: CalculadoraRanson(),
    );
  }
}

class CalculadoraRanson extends StatefulWidget {
  @override
  _RansonCalculatorState createState() => _RansonCalculatorState();
}

class _RansonCalculatorState extends State<CalculadoraRanson> {
  TextEditingController controlarNome = TextEditingController();
  TextEditingController controlarIdade = TextEditingController();
  TextEditingController controlarWbc = TextEditingController();
  TextEditingController controlarGlicose = TextEditingController();
  TextEditingController controlarAst = TextEditingController();
  TextEditingController controlarLdh = TextEditingController();
  bool pancreatite = false;
  int nivel = 0;
  double mortalidade = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Novo Paciente',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  backgroundColor: Color.fromRGBO(255, 33, 243, 61),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: controlarNome,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextFormField(
              controller: controlarIdade,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Idade'),
            ),
            Row(
              children: [
                const Text('Litíase Biliar:'),
                Checkbox(
                  value: pancreatite,
                  onChanged: (value) {
                    setState(() {
                      pancreatite = value!;
                    });
                  },
                ),
              ],
            ),
            TextFormField(
              controller: controlarWbc,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Leucócitos'),
            ),
            TextFormField(
              controller: controlarGlicose,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Glicemia'),
            ),
            TextFormField(
              controller: controlarAst,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'AST/TGO'),
            ),
            TextFormField(
              controller: controlarLdh,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'LDH'),
            ),
            const SizedBox(height: 20),
            Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  adicionarPaciente();
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 33, 243, 61),
                  onPrimary: Colors.white,
                  padding: EdgeInsets.all(16.0),
                  textStyle: TextStyle(fontSize: 20),
                ),
                child: const Text('Adicionar Paciente'),
              ),
            ),
            if (nivel > 0)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text('Pontuação: $nivel'),
                  Text('Mortalidade: ${mortalidade.toStringAsFixed(2)}%'),
                ],
              ),
          ],
        ),
      ),
    );
  }

  void adicionarPaciente() {
    int idade = int.tryParse(controlarIdade.text) ?? 0;
    int wbc = int.tryParse(controlarWbc.text) ?? 0;
    int glicose = int.tryParse(controlarGlicose.text) ?? 0;
    int ast = int.tryParse(controlarAst.text) ?? 0;
    int ldh = int.tryParse(controlarLdh.text) ?? 0;
    nivel = 0;
    if (!pancreatite) {
      if (idade > 55) nivel++;
      if (wbc > 16000) nivel++;
      if (glicose > 11) nivel++;
      if (ast > 250) nivel++;
      if (ldh > 350) nivel++;
    } else {
      if (idade > 70) nivel++;
      if (wbc > 18000) nivel++;
      if (glicose > 12.2) nivel++;
      if (ast > 250) nivel++;
      if (ldh > 400) nivel++;
    }
    if (nivel >= 7) {
      mortalidade = 100.0;
    } else if (nivel >= 5) {
      mortalidade = 40.0;
    } else if (nivel >= 3) {
      mortalidade = 15.0;
    } else {
      mortalidade = 2.0;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Resposta do Ranson'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Idade: $idade'),
              Text('Contagem de Leucócitos: $wbc'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
    setState(() {});
  }
}


//a//