import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CÁLCULO IMC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'CÁLCULO IMC'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _ctrPeso = new TextEditingController();
  var _ctrAltura = new TextEditingController();
  String _retorno = '';
  Color _corTexto = Colors.green;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          //quando o botao for precionado ele chama a function limparCampos
          IconButton(icon: Icon(Icons.refresh), onPressed: limparCampos)
        ],
        title: Center(child: Text(widget.title)),
      ),
      body: ListView(
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 15),
                Center(
                  child: Icon(
                    Icons.person,
                    color: Theme.of(context).primaryColor,
                    size: 120,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 50, top: 20, right: 50),
                  child: TextFormField(
                    controller: _ctrPeso,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Peso (Kg)',
                      labelStyle:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Informe seu Peso';
                      }
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 50, top: 20, right: 50),
                  child: TextFormField(
                    controller: _ctrAltura,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Altura (cm)',
                      labelStyle:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Informe sua Altura';
                      }
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 50, top: 20, right: 50),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(50)),
                    child: FlatButton(
                      //executa os inputs
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          calculaIMC();
                        }
                      },
                      child: Text('CALCULAR'),
                      textColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Center(
                  child: Text(
                    _retorno,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: _corTexto),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

//MÉTODO LIMPA CAMPOS (function)
  limparCampos() {
    setState(() {
      //atualiza o app
      //limpando valores
      _formKey.currentState.reset();
      _ctrPeso = new TextEditingController();
      _ctrAltura = new TextEditingController();
      _retorno = '';
    });
  }

//MÉTODO CALCULA IMC (function)
  calculaIMC() {
    //IMC = PESO / (ALTURA * ALTURA)
    //CAPTURANDO O VALOR DENTRO DOS FORMS
    //convertendo texto para double e converte o '.' para '' vazio
    var peso = double.parse(_ctrPeso.text.replaceAll('.', ''));
    var altura = double.parse(_ctrAltura.text.replaceAll('.', '')) / 100;
    var resultado = peso / (altura * altura);
    var labelResultado = resultado.toStringAsFixed(1);

    setState(() {
      if (resultado < 15) {
        _retorno =
            '($labelResultado)ANOREXICO'; //o que tem depois do cifrão o flutter vai procurar a variavel
        _corTexto = Colors.red;
      } else if (resultado >= 15 && resultado < 18.5) {
        _retorno = '($labelResultado)MAGRO';
        _corTexto = Colors.yellow;
      } else if (resultado >= 18.5 || resultado <= 24.9) {
        _retorno = '($labelResultado)NORMAL';
        _corTexto = Colors.green;
      } else if (resultado >= 25 || resultado <= 29.9) {
        _retorno = '($labelResultado)SOBREPESO';
        _corTexto = Colors.yellow;
      } else if (resultado >= 30 || resultado <= 39.9) {
        _retorno = '($labelResultado)OBESIDADE';
        _corTexto = Colors.red[200];
      } else if (resultado >= 40) {
        _retorno = '($labelResultado)OBESIDADE GRAVE';
        _corTexto = Colors.red;
      }
    });
  }
}

// < 15 ANOREXICO (VERMELHO)
// >= 15 E < 18.5 MAGRO (AMARELO)
// >= 18.5 E <= 24.9 NORMAL (VERDE)
// >= 25 E <= 29.9 SOBREPESO (AMARELO)
// >= 30 E <= 39.9 OBESIDADE (VERMELHO CLARO)
// >= 40 OBESIDADE GRAVE (VERMELHO)
