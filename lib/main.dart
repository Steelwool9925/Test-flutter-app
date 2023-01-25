import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'Models/models.dart';
import 'Actions/actions.dart';
import 'reducers/barcode_reducer.dart';

void main() {
  final store = Store<BarcodeData>(barcodeReducer, initialState: BarcodeData());
  runApp(MyApp(store: store, key: const Key("MyApp"),));
}

class MyApp extends StatelessWidget {
  final Store<BarcodeData> store;

  MyApp({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<BarcodeData>(
        store: store,
        child: MaterialApp(
          title: 'Barcode Scanner App',
          home: HomePage(),
        )
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barcode Scanner'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StoreConnector<BarcodeData, BarcodeData>(
              converter: (store) => store.state,
              builder: (context, barcodeData) {
                if (barcodeData.value == null) {
                  return Text('No barcode scanned yet');
                }
                return Text(barcodeData.value ?? "");
              },
            ),
            ElevatedButton(
              child: Text('Scan Barcode'),
              onPressed: () async {
                final barcode = await FlutterBarcodeScanner.scanBarcode('Red', 'cancel',true,ScanMode.BARCODE);
                StoreProvider.of<BarcodeData>(context).dispatch(ScanBarcodeAction(barcode));
              },
            ),
          ],
        ),
      ),

    );
  }
}
