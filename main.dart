import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false, // tira o debug no canto da tela
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController weightControler =
      TextEditingController(); // pegar o que foi digitado
  final TextEditingController heightControler =
      TextEditingController(); // pegar o que foi digitado
  //
  //VALIDAÇÃO DOS VALORES PESO E ALTURA
  GlobalKey<FormState> formKey =
      GlobalKey<FormState>(); // chave global utilizada pelo formulário

  //
  // FUNÇÃO PARA CALCULAR O IMC
  void imcFunction() {
    setState(() {
      double weight = double.parse(weightControler.text);
      double height = double.parse(heightControler.text) / 100;

      double totalIMC = weight / (height * height);
      print(totalIMC);

      if (totalIMC < 18.5) {
        _infoText =
            'Abaixo do peso, seu IMC é de ${totalIMC.toStringAsPrecision(3)}';
      } else if (totalIMC >= 18.5 && totalIMC < 24.9) {
        _infoText =
            'Peso normal, seu IMC é de ${totalIMC.toStringAsPrecision(3)}';
      } else if (totalIMC >= 25.0 && totalIMC < 29.9) {
        _infoText =
            'Sobrepeso, seu IMC é de ${totalIMC.toStringAsPrecision(3)}';
      } else if (totalIMC >= 30.0 && totalIMC < 34.9) {
        _infoText =
            'Obesidade grau I, seu IMC é de ${totalIMC.toStringAsPrecision(3)}';
      } else if (totalIMC >= 35.0 && totalIMC < 39.9) {
        _infoText =
            'Obesidade grau II, seu IMC é de ${totalIMC.toStringAsPrecision(3)}';
      } else if (totalIMC >= 40.0) {
        _infoText =
            'Obesidade grau III ou mórbida, seu IMC é de ${totalIMC.toStringAsPrecision(3)}';
      }
    });
  }

  //
  // TEXTO DE RESULTADO
  String _infoText = 'Informe seus dados';
//
// BOTÃO RESET DA APPBAR
  void _resetFields() {
    weightControler.text = ""; // diz que o texto do peso é vazio
    heightControler.text = ""; // diz que o texto da altura é vazio
    setState(() {
      _infoText =
          'Informe seus dados'; // quando resetar aparece esse texto inicial
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Calculadora de IMC'),
          centerTitle: true, // centraliza o texto na appbar
          backgroundColor: Colors.green,
          // botão para apagar as informações nos campos de textos
          actions: [
            IconButton(
              onPressed: _resetFields,
              icon: Icon(
                Icons.refresh,
              ),
            ),
          ],
        ),
        // SingleChildScrollView não permite que o teclado fique por cima do que está na tela
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
              // validação
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Center(
                    child: Icon(
                      Icons.person_outline,
                      color: Colors.green,
                      size: 100,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //
                  //
                  // TEXTFIELD
                    // validação
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      // border: InputBorder.none,
                      labelText: 'Peso (Kg)',
                      labelStyle: TextStyle(
                        color: Colors.green,
                        fontSize: 25,
                      ),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                    controller: weightControler, // pegar o que foi digitado
                    // Verifica se o campo do peso está vazio, caso esteja aparecerá o retorno
                    validator: (value){
                      if( value!.isEmpty){
                        return 'Insira seu peso';
                      }
                    },
                  ),
                    // validação
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      //border: InputBorder.none,
                      labelText: 'Altura (cm)',
                      labelStyle: TextStyle(
                        color: Colors.green,
                        fontSize: 25,
                      ),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                    controller: heightControler, // pegar o que foi digitado
                    // Verifica se o campo do peso está vazio, caso esteja aparecerá o retorno
                     validator: (value){
                      if( value!.isEmpty){
                        return 'Insira sua altura';
                      }
                     },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //
                  //
                  // BUTTON
                  Container(
                    width: double.infinity,
                    height:
                        50, // o botão ocupa toda a tela disponível do appbar
                    child: RaisedButton(
                      onPressed: () {
                        // se o formulário formkey for validado irá chamar a função imc para calcular
                        if(formKey.currentState!.validate()){
                          imcFunction();
                        }
                      },
                      textColor: Colors.white,
                      color: Colors.green,
                      child: Text(
                        'Calcular',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //
                  //
                  // TEXT
                  Text(
                    _infoText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 25,
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
