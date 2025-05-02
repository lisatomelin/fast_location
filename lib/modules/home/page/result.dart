import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:fast_location/modules/home/model/address_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fast_location/modules/history/controller/history_controller.dart';

var cepController = TextEditingController();

class ApiCall {
  final Dio _dio = Dio();

  Future<AddressModel> fetchAPI(String cep) async {
    try {
      final response = await _dio.get('https://viacep.com.br/ws/$cep/json/');
      if (response.statusCode == 200) {
        return AddressModel.fromJson(response.data);
      } else {
        throw Exception('Falha ao carregar o endereço');
      }
    } catch (e) {
      throw Exception('Falha ao conectar no servidor');
    }
  }
}

WidgetAlert(BuildContext context, String titulo) {
  return AlertDialog(
    title: Text(titulo),
    content: Form(
      child: TextFormField(
        controller: cepController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          icon: Icon(Icons.place),
        ),
      ),
    ),
    actions: [
      TextButton(
        onPressed: () async {
          ApiCall apiCall = ApiCall();
          try {
            AddressModel result = await apiCall.fetchAPI(cepController.text);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddressDetailPage(result),
              ),
            );
          } catch (e) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Text('Erro: $e'),
                );
              },
            );
          }
        },
        child: Text(
          "Pesquisar",
          style: TextStyle(color: Color.fromRGBO(156, 39, 176, 1), fontSize: 20),
        ),
      )
    ],
  );
}

class AddressDetailPage extends StatelessWidget {
  final AddressModel address;
  final HistoryController historyController = HistoryController();

  AddressDetailPage(this.address);

  _addToSearchHistory(AddressModel address) async {
    historyController.addToSearchHistory(address);
  }

  _openGoogleMaps() async {
    String url =
        'https://www.google.com/maps/search/?api=1&query=${address.cep}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Não é possível acessar a URL $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var heightMedia = size.height;
    var widthMedia = size.width;
    _addToSearchHistory(address);
    return Scaffold(
        appBar: AppBar(
          title: Text('Detalhes do Endereço'),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('CEP: ${address.cep}',
                    style: TextStyle(
                        color: Color.fromRGBO(156, 39, 176, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 30)),
                Text('Logradouro: ${address.logradouro}',
                    style: TextStyle(fontSize: 25)),
                Text('Bairro: ${address.bairro}',
                    style: TextStyle(fontSize: 25)),
                Text('Cidade: ${address.localidade}',
                    style: TextStyle(fontSize: 25)),
                Text('Estado: ${address.uf}', style: TextStyle(fontSize: 25)),
                ElevatedButton(
                    onPressed: _openGoogleMaps,
                    child: Text('Traçar rota no Google Maps',
                        style: TextStyle(
                            color: Colors.white, fontSize: heightMedia * 0.03)),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color.fromRGBO(156, 39, 176, 1)),
                        minimumSize: MaterialStateProperty.all(
                            Size(widthMedia * 0.8, 15)),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(heightMedia * 0.02)))),
                SizedBox(
                    height:
                        20), // Adiciona um espaçamento entre o botão e o histórico
                Container(
                  // Container para mostrar o histórico
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Histórico de Busca',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Observer(
                        builder: (_) => ListView.builder(
                          shrinkWrap: true,
                          itemCount:
                              historyController.addressHistoryList.length,
                          itemBuilder: (context, index) {
                            var item =
                                historyController.addressHistoryList[index];
                            return ListTile(
                              title: Text(item.logradouro),
                              subtitle: Text('${item.localidade}, ${item.uf}'),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
        ));
  }
}