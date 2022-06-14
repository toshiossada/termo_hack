import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'black_list_controller.dart';
import '../white_list/white_list_controller.dart';

import '../../viewmodels/words_view_model.dart';

class BlacListPage extends StatefulWidget {
  const BlacListPage({Key? key}) : super(key: key);

  @override
  State<BlacListPage> createState() => _BlackListPageState();
}

class _BlackListPageState extends State<BlacListPage> {
  final controller = Modular.get<BlackListController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Black'),
        actions: [
          IconButton(
            onPressed: () {
              controller.addLetter();
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          TextField(
            controller: controller.txtLetter,
            onSubmitted: (v) => controller.addLetter(),
            decoration: const InputDecoration(
              hintText: 'Digite a letra que a palavra contém',
              border: OutlineInputBorder(),
              counterText: '',
            ),
          ),
          ValueListenableBuilder<WordsViewModel>(
            valueListenable: controller.wordStore,
            builder: (context, value, _) {
              return Visibility(
                visible: controller.wordStore.value.blackList.isNotEmpty,
                child: Expanded(
                  child: ListView.builder(
                    itemCount: controller.wordStore.value.blackList.length,
                    itemBuilder: (_, index) {
                      final letter =
                          controller.wordStore.value.blackList[index];
                      return ListTile(
                        leading: IconButton(
                            onPressed: () {
                              controller.remove(letter);
                            },
                            icon: const Icon(Icons.remove)),
                        title: Text(letter),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    Modular.dispose<WhiteListController>();
  }
}
