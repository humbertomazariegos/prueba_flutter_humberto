import 'package:flutter/material.dart';
import 'package:prueba_humberto/User/ui/utils/template_mail.dart';
import 'package:prueba_humberto/User/ui/widgets/show_alert_dialog.dart';
import 'package:prueba_humberto/data/repositories/mail_repository.dart';

class SendMailButton extends StatefulWidget {
  final String email;
  final String displayName;
  const SendMailButton({
    Key? key,
    required this.email,
    required this.displayName,
  }) : super(key: key);

  @override
  State<SendMailButton> createState() => _SendMailButtonState();
}

class _SendMailButtonState extends State<SendMailButton> {
  var send = false;

  sendChage() {
    setState(() {
      send = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        //var resp = "";
        //send == true
        //? resp = "OK"
        var resp = "";
        MailRepository()
            .sendMail(
                "josehumberto.mazariegos@gmail.com",
                "Humberto",
                widget.email,
                widget.displayName,
                constSubject,
                constMessage,
                constHTML)
            .then((value) => {
                  if (value == "OK")
                    {
                      sendChage(),
                      showAlertDialog(context, "OK"),
                    }
                  else
                    {showAlertDialog(context, "ERROR")}
                });
      },
      child: send == true
          ? const Icon(Icons.check)
          : const Icon(Icons.mail_outline),
    );
  }
}
