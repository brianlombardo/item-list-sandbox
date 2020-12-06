import 'package:equatable/equatable.dart';

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

  @override
  List<Object> get props => [id, text];
}
