import 'package:adote_um_amigo/models/animal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../shared/style.dart';

class CadastroAnimalPage extends StatefulWidget {
  final String title;
  const CadastroAnimalPage({Key? key, this.title = 'CadastroAnimalPage'})
      : super(key: key);
  @override
  CadastroAnimalPageState createState() => CadastroAnimalPageState();
}

class CadastroAnimalPageState extends State<CadastroAnimalPage> {
  final _formKey = GlobalKey<FormState>();
  Animal animal = Animal();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        child: Column(
          children: <Widget>[_buildTitulo(), _buildForm()],
        ),
      ),
    );
  }

  Widget _buildTitulo() {
    return RichText(
      text: const TextSpan(
        text: 'Cadastro do ',
        style: TextStyle(
            color: Cores.titulo,
            fontSize: 32,
            fontFamily: 'Jost',
            fontStyle: FontStyle.normal),
        children: <TextSpan>[
          TextSpan(
              text: 'animal', style: TextStyle(fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFieldNome(),
          Row(
            children: [
              _buildFieldRaca(),
              _buildFieldIdade(),
            ],
          ),
          _buildFieldCaracteristicas(),
          _buildFieldVacinas(),
          _buildButton(),
        ],
      ),
    );
  }

  Widget _buildFieldNome() {
    return TextFormField(
      style: const TextStyle(
          color: Cores.texto, fontSize: 16, fontStyle: FontStyle.normal),
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'Nome',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, insira o nome do animal';
        }
        animal.nome = value;
        return null;
      },
    );
  }

  Widget _buildFieldRaca() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: TextFormField(
        style: const TextStyle(
            color: Cores.texto, fontSize: 16, fontStyle: FontStyle.normal),
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Raça',
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Insira a raça';
          }
          animal.raca = value;
          return null;
        },
      ),
    );
  }

  Widget _buildFieldIdade() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      padding: const EdgeInsets.only(left: 32.0),
      child: TextFormField(
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        style: const TextStyle(
            color: Cores.texto, fontSize: 16, fontStyle: FontStyle.normal),
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Idade',
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Insira a idade';
          }
          animal.idade = int.parse(value);
          return null;
        },
      ),
    );
  }

  Widget _buildFieldCaracteristicas() {
    return TextFormField(
      style: const TextStyle(
          color: Cores.texto, fontSize: 16, fontStyle: FontStyle.normal),
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'Características',
      ),
      maxLines: 5,
      minLines: 1,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Insira algumas características do bichinho, como personalidade, cor...';
        }
        animal.caracteristicas = value;
        return null;
      },
    );
  }

  Widget _buildFieldVacinas() {
    return TextFormField(
      style: const TextStyle(
          color: Cores.texto, fontSize: 16, fontStyle: FontStyle.normal),
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'Vacinas',
      ),
      maxLines: 5,
      minLines: 1,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Insira algumas informações sobre o estado vacinal do animal';
        }
        animal.vacinas = value;
        return null;
      },
    );
  }

  Widget _buildButton() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Cores.primaria,
            fixedSize: const Size.fromWidth(300),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
          child: const Text(
            'Cadastrar',
            style: TextStyle(fontSize: 16),
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Processando os dados')),
                // fazer upload
              );
            }
          },
        ),
      ),
    );
  }
}
