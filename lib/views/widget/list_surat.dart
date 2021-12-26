import 'package:flutter/cupertino.dart';
import 'package:halowarga/model/document.dart';
import 'package:halowarga/views/widget/card_person.dart';

class ListSurat extends StatelessWidget {
  ListSurat({Key? key, required this.documents}) : super(key: key);

  final List<Document> documents;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: documents.length,
      itemBuilder: (context, index) {
        return CardPerson(
            name: documents[index].name,
            address: documents[index].type,
            imageUrl: '',
            role: documents[index].date);
      },
    );
  }
}
