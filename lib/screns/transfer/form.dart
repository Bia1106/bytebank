import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/transfer.dart';
import 'package:flutter/material.dart';

class TransferForm extends StatefulWidget {
  final TextEditingController _controllerValueField = TextEditingController();
  final TextEditingController _controllerAccountNumberField =
      TextEditingController();
  TransferForm({super.key});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
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
