import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:item_list/item_model.dart';

class ItemsRepository {
  final http.Client client;
  final serverUrl = 'http://localhost:3000/api/v1/items';
  // final headers = {'Accept': 'application/json'};
  final headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  ItemsRepository(this.client);

  Future<List<Item>> getItems() async {
    var res = await client.get(Uri.parse(serverUrl), headers: headers);

    return (json.decode(res.body) as List<dynamic>)
        .map((e) => Item.fromJson(e))
        .toList();
  }

  Future<http.Response> createItem(String item) async {
    return client.post(
      serverUrl,
      headers: headers,
      body: Item(text: item).toJson(),
    );
  }
}
