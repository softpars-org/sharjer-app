import 'package:flutter/material.dart';
import 'package:mojtama/views/widgets/textfield_widget.dart';

class AdminPanelModel extends ChangeNotifier {
  final List<Widget> _textFieldList = [];
  final List<Map<String, TextEditingController>>
      _textEditingControllersMapList = [];
  List<Widget> get textFieldList {
    return _textFieldList;
  }

  addTextField() {
    TextEditingController titleController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    final widget = generateTextField(titleController, priceController);
    _textEditingControllersMapList.add({
      "title": titleController,
      "price": priceController,
    });
    _textFieldList.add(widget);
    notifyListeners();
  }

  Widget generateTextField(
    TextEditingController titleController,
    TextEditingController priceController,
  ) {
    final Widget _textField = Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTextField(
              label: "عنوان",
              suffixIcon: Icon(Icons.title_outlined),
              controller: titleController,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTextField(
              label: "مبلغ",
              keyboardType: TextInputType.number,
              suffixIcon: Icon(Icons.price_check_outlined),
              controller: priceController,
            ),
          ),
        )
      ],
    );

    return _textField;
  }

  removeTextField() {
    if (_textFieldList.isNotEmpty) {
      _textEditingControllersMapList.removeLast();
      _textFieldList.removeLast();
      notifyListeners();
    }
  }

  generateJsonFromFields() {
    List json = [];
    for (Map textControllersMap in _textEditingControllersMapList) {
      Map manipulatedMap = {
        "title": textControllersMap["title"].text,
        "price": textControllersMap["price"].text,
      };
      json.add(manipulatedMap);
    }
    return json;
  }
}
