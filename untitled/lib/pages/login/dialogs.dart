import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


Future<String?> showConfirmDialog(BuildContext context,String disMessage) async {
  AlertDialog dialog = AlertDialog(
    title: const Text("Xác nhận"),
    content: Text(disMessage),
    actions: [
      ElevatedButton(onPressed: () =>
          Navigator.of(context, rootNavigator: true).pop("cancel"),
          child: Text("Hủy")),
      ElevatedButton(
          onPressed: () => Navigator.of(context, rootNavigator: true).pop("ok")
          , child: Text("OK"))
    ],
  );
  String? res = await showDialog<String?>(
    context: context,
    builder: (context) => dialog,
    barrierDismissible: false,
  );
  return res;
}
void showSnackBar(BuildContext context,String message, int second){
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message),
      duration: Duration(
        seconds: second
      ),));
}