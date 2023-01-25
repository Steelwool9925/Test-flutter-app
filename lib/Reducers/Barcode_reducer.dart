import 'package:testapp/Actions/actions.dart';
import 'package:testapp/Models/models.dart';

BarcodeData barcodeReducer(BarcodeData state, dynamic action) {
  if (action is ScanBarcodeAction) {
    return BarcodeData(value: action.barcode);
  }
  return state;
}