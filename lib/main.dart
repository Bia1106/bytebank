import 'package:flutter/material.dart';

void main() {
  runApp(const ByteBank());
  // runApp(const MyApp());
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

class TransferForm extends StatefulWidget {
  final TextEditingController _controllerValueField = TextEditingController();
  final TextEditingController _controllerAccountNumberField =
      TextEditingController();
  TransferForm({super.key});
  @override
  State<StatefulWidget> createState() {
    return TransferFormState();
  }
}

class TransferFormState extends State<TransferForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        title: const Text(
          "Creating transfer",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Editor(
              fieldController: widget._controllerAccountNumberField,
              label: "Account number",
              hint: "000",
              left: 20.0,
              top: 80.0,
              right: 20.0,
              bottom: 0.0),
          Editor(
              fieldController: widget._controllerValueField,
              label: "Value",
              hint: "0.00",
              left: 20.0,
              top: 20.0,
              right: 20.0,
              bottom: 20.0,
              icon: Icons.monetization_on_outlined),
          ElevatedButton(
            onPressed: () => _createTranfer(
                context,
                widget._controllerAccountNumberField,
                widget._controllerValueField),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
            child: const Text(
              "Confirm",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ]),
      ),
    );
  }

  _createTranfer(BuildContext context, TextEditingController controllerField1,
      TextEditingController controllerField2) {
    final accountNumber = int.tryParse(controllerField1.text);
    final value = double.tryParse(controllerField2.text);
    final createdTransfer = Transfer(value, accountNumber);
    Navigator.pop(context, createdTransfer);
  }
}

class Editor extends StatelessWidget {
  final TextEditingController fieldController;
  final String? label;
  final String? hint;
  final double? left;
  final double? top;
  final double? right;
  final double? bottom;
  final IconData? icon;
  const Editor(
      {required this.fieldController,
      this.label,
      this.hint,
      this.left,
      this.top,
      this.right,
      this.bottom,
      this.icon,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(left!, top!, right!, bottom!),
      child: TextField(
        controller: fieldController,
        style: const TextStyle(fontSize: 24.0),
        decoration: InputDecoration(
          icon: icon != null ? Icon(icon) : null,
          labelText: label,
          hintText: hint,
        ),
      ),
    );
  }
}

class Transfer {
  final double? value;
  final int? accountNumber;

  const Transfer(this.value, this.accountNumber);

  @override
  String toString() => 'Transfer{value: $value, accountNumber: $accountNumber}';
}

class TransferList extends StatefulWidget {
  TransferList({super.key});
  final List<Transfer> _transfers = [];
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TransferListState();
  }
}

class TransferItem extends StatelessWidget {
  final Transfer _transfer;
  const TransferItem(this._transfer, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(
          Icons.monetization_on_outlined,
        ),
        title: Text(_transfer.value.toString()),
        subtitle: Text(_transfer.accountNumber.toString()),
      ),
    );
  }
}

class TransferListState extends State<TransferList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: widget._transfers.length,
        itemBuilder: (context, index) {
          final transfer = widget._transfers[index];
          return TransferItem(transfer);
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Transfers',
          style: TextStyle(color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final Future future = Navigator.push(
              context, MaterialPageRoute(builder: (context) => TransferForm()));
          future.then((recievedTransfer) {
            Future.delayed(const Duration(seconds: 2), () {
              if (recievedTransfer != null) {
                setState(() {
                  // MUITO IMPORTANTE PARA O FUCNIONAMENTO DINÂMICO, NÃO PODE FALTAR
                  widget._transfers.add(recievedTransfer);
                });
              }
            });
          });
        },
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
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
