import 'package:adote_um_amigo/app/registro-usuario/login.dart';
import 'package:flutter/material.dart';
import './page_indicator.dart';
import './body_contents.dart';

class StepForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StepFormState();
  }
}

class _StepFormState extends State<StepForm> {
  final _stepFormController = PageController();
  int _page = 0;

  List _pagesList = [
    bodyContents(
        'https://img.freepik.com/fotos-gratis/a-bonito-menina-embarcing-gato-e-cao_8353-5281.jpg?w=826&t=st=1667781119~exp=1667781719~hmac=17a8080253eb95aa58073f540d9e734789b765e8ace98dfd1f4840e63b0ecdf5', '', 'Adoção é cuidar, adoção é proteger, adote um amiguinho. Nós cuidamos de ajudar você a encontrar o seu companheiro(a).'),
    bodyContents(
        'https://img.freepik.com/fotos-gratis/cachorro-basenji-inteligente-e-amigavel-dando-a-pata-de-perto-isolado-no-branco_346278-1626.jpg?w=826&t=st=1667781691~exp=1667782291~hmac=77843b6cf6876cdf50201b53242ba0a887a51679f22ad36228f5f403f966b7a8', 'Perfis diversos de Pets', 'Encontre animais que procuram um lar. Buscam amor e carinho.'),
    bodyContents(
        'https://img.freepik.com/fotos-gratis/o-gato-de-bengala-dourado-no-espaco-em-branco_155003-12732.jpg?w=826&t=st=1667782149~exp=1667782749~hmac=922f9203552b895eb2d3b933fb5633345ba414bb61dcf7297ac4b9a2d110e34d', 'Cadastre um amigo', 'Registre o pet que procura uma nova família. Preencha as características, documentos, carregue fotos, para encontrar os tutores ideais.'),
  ];

  void _changeStep(bool nextPage) {
    if (_page < 2 && nextPage) {
      setState(() {
        _page++;
      });
      _stepFormController.nextPage(
        duration: Duration(milliseconds: 400),
        curve: Curves.easeIn,
      );
    } else if(_page > 0 && !nextPage) {
      setState(() {
        _page--;
      });
      _stepFormController.previousPage(
        duration: Duration(milliseconds: 400),
        curve: Curves.easeIn,
      );
    } else if(_page == 2 && nextPage){
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>
      const loginUsuarioPage(title: 'Login de Usuario')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adote Um Amigo'),
      ),
      body: PageView.builder(
          controller: _stepFormController,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return _pagesList[index];
          }),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () => _changeStep(false),
            child: Text('Anterior'),
          ),
          pageIndicator(_page == 0),
          pageIndicator(_page == 1),
          pageIndicator(_page == 2),
          TextButton(
            onPressed: () => _changeStep(true),
            child: Text('Próximo'),
          ),
        ],
      ),
    );
  }
}
