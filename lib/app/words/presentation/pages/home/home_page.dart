import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../viewmodels/words_view_model.dart';
import 'home_controller.dart';

import 'widgets/action_widget.dart';
import 'widgets/letter_input_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Modular.get<HomeController>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Termo'),
        actions: [
          ValueListenableBuilder<WordsViewModel>(
              valueListenable: controller.wordStore,
              builder: (context, value, _) {
                return ActionWidget(
                  color: Colors.blue,
                  count: value.whiteList.length,
                  onPressed: controller.showWhitelist,
                  icon: Icons.filter_list_rounded,
                );
              }),
          ValueListenableBuilder<WordsViewModel>(
            valueListenable: controller.wordStore,
            builder: (context, value, _) {
              return ActionWidget(
                color: Colors.red,
                count: value.blackList.length,
                onPressed: controller.showBlacklist,
                paddingLeft: 20,
                icon: Icons.filter_list_off_rounded,
              );
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.info,
              color: Colors.green,
            ),
            onPressed: controller.showInfo,
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: [
              LetterInputWidget(
                key: const Key('firstLetter'),
                controller: controller.txtFirst,
                onChanged: (value) => controller.changeLetter(value, 1),
              ),
              LetterInputWidget(
                key: const Key('secondLetter'),
                controller: controller.txtSecond,
                onChanged: (value) => controller.changeLetter(value, 2),
              ),
              LetterInputWidget(
                key: const Key('thirdLetter'),
                controller: controller.txtThird,
                onChanged: (value) => controller.changeLetter(value, 3),
              ),
              LetterInputWidget(
                key: const Key('fourthLetter'),
                controller: controller.txtFourth,
                onChanged: (value) => controller.changeLetter(value, 4),
              ),
              LetterInputWidget(
                key: const Key('fifthLetter'),
                controller: controller.txtFifth,
                onChanged: (value) => controller.changeLetter(value, 5),
                inputAction: TextInputAction.done,
              ),
            ],
          ),
          Expanded(
            child: ValueListenableBuilder<WordsViewModel>(
              valueListenable: controller.wordStore,
              builder: (context, value, _) {
                return Column(
                  children: [
                    Visibility(
                      visible: value.loading,
                      child: const CircularProgressIndicator(
                        color: Colors.purple,
                      ),
                    ),
                    Visibility(
                      visible: !value.loading,
                      child: Expanded(
                        child: ListView.builder(
                          key: const Key('ListOfWords'),
                          itemCount: value.words.length,
                          itemBuilder: (_, index) {
                            final word = value.words[index];

                            return ListTile(
                              title:
                                  Text('$word${word.length < 5 ? '(s)' : ''}'),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.clear,
        child: const Icon(Icons.cleaning_services_outlined),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    Modular.dispose<HomeController>();
  }
}
