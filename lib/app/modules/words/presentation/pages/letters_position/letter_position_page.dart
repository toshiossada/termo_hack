import 'package:flutter/material.dart';

import '../../viewmodels/words_view_model.dart';
import 'letter_position_controller.dart';

class LetterPositiontPage extends StatefulWidget {
  final LetterPositionController controller;
  const LetterPositiontPage({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<LetterPositiontPage> createState() => _LetterPositiontPageState();
}

class _LetterPositiontPageState extends State<LetterPositiontPage> {
  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;
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
          Row(
            children: [
              Flexible(
                child: TextField(
                  maxLength: 1,
                  controller: controller.txtLetter,
                  onSubmitted: (v) => controller.addLetter(),
                  autofocus: true,
                  focusNode: controller.myFocusNode,
                  decoration: const InputDecoration(
                    hintText: 'Digite a letra que a palavra não contém',
                    border: OutlineInputBorder(),
                    counterText: '',
                  ),
                ),
              ),
              Flexible(
                child: DropdownButton<int>(
                  value: controller.dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (int? newValue) {
                    setState(() {
                      controller.dropdownValue = newValue!;
                    });
                  },
                  items:
                      [1, 2, 3, 4, 5].map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),
              )
            ],
          ),
          ValueListenableBuilder<WordsViewModel>(
            valueListenable: controller.wordStore,
            builder: (context, value, _) {
              return Visibility(
                visible: controller
                    .wordStore.value.word.notPositionLetter.isNotEmpty,
                child: Expanded(
                  child: ListView.builder(
                    itemCount: controller
                        .wordStore.value.word.notPositionLetter.length,
                    itemBuilder: (_, index) {
                      final letter = controller
                          .wordStore.value.word.notPositionLetter[index];
                      return ListTile(
                        leading: IconButton(
                            onPressed: () {
                              controller.remove(letter.letter, letter.position);
                            },
                            icon: const Icon(Icons.remove)),
                        title: Text(letter.letter),
                        trailing: Text('#${letter.position}'),
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
