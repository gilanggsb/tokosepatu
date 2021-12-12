import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tokosepatu/models/product_model.dart';

class ProductService {
  var baseUrl = 'https://shamo-backend.buildwithangga.id/api';

  Future<List<ProductModel>> getProduct() async {
    var url = '$baseUrl/products';
    var headers = {'Content-type': 'application/json'};
    var response = await http.get(Uri.parse(url), headers: headers);

    // print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['data'];
      List<ProductModel> products = [];
      for (var item in data) {
        products.add(ProductModel.fromJson(item));
        // print(item);
      }

      return products;
    } else {
      throw Exception('Gagal Get Product');
    }
  }
}
