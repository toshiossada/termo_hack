import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'info_dialog_controller.dart';

class InfoDialogWidget extends StatefulWidget {
  const InfoDialogWidget({Key? key}) : super(key: key);

  @override
  State<InfoDialogWidget> createState() => _InfoDialogWidgetState();
}

class _InfoDialogWidgetState extends State<InfoDialogWidget> {
  final controller = Modular.get<InfoDialogController>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Não encontrou a palavra?'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Se não encontrou a palavra solicitar a criaçao '),
          InkWell(
            onTap: controller.openGithub,
            child: const Text('Abre um PR no github'),
          ),
          const Text(' OU envie email para '),
          InkWell(
            onTap: controller.openEmail,
            child: const Text('toshiossada@toshiossada.dev'),
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Ok'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();

    Modular.dispose<InfoDialogController>();
  }
}
