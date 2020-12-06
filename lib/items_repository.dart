import 'dart:convert';
import 'package:http/http.dart' as http;

class ItemsRepository {
  final http.Client client;
  final serverUrl = 'http://localhost:3000/api/v1/items';
  final headers = {'Accept': 'application/json'};
  final postHeaders = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  ItemsRepository(this.client);

  Future<List<Item>> getItems() async {
    var res = await http.get(Uri.parse(serverUrl), headers: headers);

    return (json.decode(res.body) as List<dynamic>)
        .map((e) => Item.fromJson(e))
        .toList();
  }

  Future<http.Response> createItem(String item) async {
    if (item.isNotEmpty) {
      return http.post(
        serverUrl,
        headers: postHeaders,
        body: Item(text: item).toJson(),
      );
    }
  }
}

class Item {
  final String id;
  final String text;

  Item({this.id, this.text});

  Map<String, dynamic> toJson() => {
        'id': id,
        'text': text,
      };

  factory Item.fromJson(Map<String, dynamic> json) =>
      Item(id: json['id'], text: json['text']);
}
