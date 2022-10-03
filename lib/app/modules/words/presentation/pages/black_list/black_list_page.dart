import 'package:flutter/material.dart';

import '../../viewmodels/words_view_model.dart';
import 'black_list_controller.dart';

class BlacListPage extends StatefulWidget {
  const BlacListPage({Key? key}) : super(key: key);

  @override
  State<BlacListPage> createState() => _BlackListPageState();
}

class _BlackListPageState extends State<BlacListPage> {
  @override
  Widget build(BuildContext context) {
    final controller = BlackListController.of(context);
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
            autofocus: true,
            focusNode: controller.myFocusNode,
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


}
