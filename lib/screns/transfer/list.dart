import 'package:bytebank/models/transfer.dart';
import 'package:bytebank/screns/transfer/form.dart';
import 'package:flutter/material.dart';

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
