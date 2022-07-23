import 'package:flutter/material.dart';

showAlertDialog(BuildContext context, String type) {
  // Create button
  var title = "";
  var text = "";

  type == "OK" ? title = "EXITOSO" : title = "ERROR";
  type == "OK"
      ? text = "El correo fue enviado exitosamente."
      : text = "No se envio el correo";

  Widget okButton = ElevatedButton(
    child: Text("OK", style: TextStyle(color: Colors.white)),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      title,
      style: TextStyle(
        color: type == "OK" ? Colors.black : Colors.red,
      ),
    ),
    content: Text(text),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
