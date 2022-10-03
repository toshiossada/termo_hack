import 'package:flutter/material.dart';

import '../../viewmodels/words_view_model.dart';
import 'white_list_controller.dart';

class WhiteListPage extends StatefulWidget {
  const WhiteListPage({Key? key}) : super(key: key);

  @override
  State<WhiteListPage> createState() => _WhiteListPageState();
}

class _WhiteListPageState extends State<WhiteListPage> {
  @override
  Widget build(BuildContext context) {
    final controller = WhiteListController.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('WhiteList'),
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
                visible: controller.wordStore.value.whiteList.isNotEmpty,
                child: Expanded(
                  child: ListView.builder(
                    itemCount: controller.wordStore.value.whiteList.length,
                    itemBuilder: (_, index) {
                      final letter =
                          controller.wordStore.value.whiteList[index];
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
