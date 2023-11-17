import 'package:bytebank/screns/transfer/list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ByteBank());
}

class ByteBank extends StatelessWidget {
  const ByteBank({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: TransferList(),
    );
  }
}

//TODO tentar aplicar depois
// class TestDialogBox extends StatelessWidget {
//   const TestDialogBox({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return const AlertDialog(
//       title: Text('AlertDialog Title'),
//       content: SingleChildScrollView(
//         child: ListBody(
//           children: <Widget>[
//             Text('This is a demo alert dialog.'),
//             Text('Would you like to approve of this message?'),
//           ],
//         ),
//       ),
//     );
//   }
// }
