import 'package:equatable/equatable.dart';
import 'package:item_list/api/item_data.dart';

class Item extends Equatable {
  final String id;
  final String text;

  Item({this.id, this.text});

  Map<String, dynamic> toJson() => {
        'id': id,
        'text': text,
      };

  factory Item.fromJson(Map<String, dynamic> json) =>
      Item(id: json['id'], text: json['text']);

  factory Item.fromItemData(ItemData data) => Item(
        id: data.id,
        text: data.text,
      );

  @override
  List<Object> get props => [id, text];
}
