import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../modules/home/model/address_model.dart';

class ApiCall extends StatelessWidget {
  const ApiCall({super.key});

  Future<List<AddressModel>> fetchAPI(cep) async {
    Dio dio = Dio();

    var response = await dio.get('https://viacep.com.br/ws/$cep/json/');

    final List<dynamic> responseData = response.data;
    List<AddressModel> result =
        responseData.map((json) => AddressModel.fromJson(json)).toList();

    return result;
  }

  @override
  Widget build(BuildContext context) {
    
    throw UnimplementedError();
  }
}
