import 'package:flutter/cupertino.dart';
import 'package:halowarga/views/widget/card_person.dart';

class ListSurat extends StatelessWidget {
  const ListSurat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: 15,
      itemBuilder: (context, index) {
        return CardPerson();
      },
    );
  }
}
