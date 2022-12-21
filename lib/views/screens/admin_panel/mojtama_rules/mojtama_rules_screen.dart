import 'package:flutter/material.dart';
import 'package:mojtama/views/widgets/textfield_widget.dart';

class MojtamaRulesScreen extends StatelessWidget {
  const MojtamaRulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("قوانین مجتمع"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTextField(
              label: "محل قرارگیری قوانین",
              maxLines: 20,
              suffixIcon: Icon(Icons.rule_sharp),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: "تایید",
        child: Icon(
          Icons.check_rounded,
        ),
      ),
    );
  }
}
