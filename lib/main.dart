import 'package:flutter/material.dart';

void main() {
  runApp(const ByteBank());
  // runApp(const MyApp());
}

class ByteBank extends StatelessWidget {
  const ByteBank({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: TransferList(),
      ),
    );
  }
}

class TransferForm extends StatelessWidget {
  final TextEditingController _controllerValueField = TextEditingController();
  final TextEditingController _controllerAccountNumberField =
      TextEditingController();
  TransferForm({super.key});

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
      body: Column(children: <Widget>[
        Editor(
            fieldController: _controllerAccountNumberField,
            label: "Account number",
            hint: "000",
            left: 20.0,
            top: 80.0,
            right: 20.0,
            bottom: 0.0),
        Editor(
            fieldController: _controllerValueField,
            label: "Value",
            hint: "0.00",
            left: 20.0,
            top: 20.0,
            right: 20.0,
            bottom: 20.0,
            icon: Icons.monetization_on_outlined),
        ElevatedButton(
          onPressed: () => _createTranfer(
              context, _controllerAccountNumberField, _controllerValueField),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
          child: const Text(
            "Confirm",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ]),
    );
  }
}

_createTranfer(BuildContext context, TextEditingController controllerField1,
    TextEditingController controllerField2) {
  final accountNumber = int.tryParse(controllerField1.text);
  final value = double.tryParse(controllerField2.text);
  final createdTransfer = Transfer(value, accountNumber); 
  Navigator.pop(context, createdTransfer);
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
  const TransferList({super.key});

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
  final List<Transfer> _transfers = [];
  @override
  Widget build(BuildContext context) {
    // _transfers.add(const Transfer(100.0, 02));
    return Scaffold(
      body: ListView.builder(
        itemCount: _transfers.length,
        itemBuilder: (context, index) {
          final transfer = _transfers[index];
          debugPrint("This is a single transfer $transfer");
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
            debugPrint("chegou no then do future $recievedTransfer");
            if (recievedTransfer != null) {
              _transfers.add(recievedTransfer);
            }
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

class TestDialogBox extends StatelessWidget {
  const TestDialogBox({super.key});

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      title: Text('AlertDialog Title'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('This is a demo alert dialog.'),
            Text('Would you like to approve of this message?'),
          ],
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
