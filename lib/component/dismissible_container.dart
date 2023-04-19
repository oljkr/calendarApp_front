import 'package:flutter/material.dart';

class DissmissibleContainer extends StatelessWidget {
  const DissmissibleContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  Container get buildBackgroundWidget => Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.red,
        alignment: Alignment.centerLeft,
        child: const Icon(
          Icons.delete,
          size: 36,
          color: Colors.white,
        ),
      );
}
