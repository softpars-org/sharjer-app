import 'package:flutter/material.dart';
import 'package:mojtama/models/plak_model.dart';
import 'package:mojtama/views/widgets/textfield_widget.dart';

class PlakInputWidget extends StatelessWidget {
  TextEditingController? iranController, char3, char, lastNumber;
  String? Function(String?)? numValidator;
  String? Function(String?)? farsiValidator;
  PlakInputWidget({
    super.key,
    this.iranController,
    this.char3,
    this.char,
    this.lastNumber,
    this.numValidator,
    this.farsiValidator,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Theme.of(context).primaryColor.withOpacity(0.15),
            ),
            child: Text(
              "پلاک خودرو را وارد کنید:",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: CustomTextField(
                label: "ایران",
                helper: "مثال: ۱۶",
                validator: numValidator,
              ),
            ),
            Expanded(
              flex: 2,
              child: CustomTextField(
                label: "سه رقم بعدی",
                helper: "مثال: ۶۷۸",
                validator: numValidator,
              ),
            ),
            Expanded(
              flex: 1,
              child: CustomTextField(
                label: "حرف",
                helper: "مثال: د",
                validator: farsiValidator,
              ),
            ),
            Expanded(
              flex: 1,
              child: CustomTextField(
                label: "عدد آخر",
                helper: "مثال: ۵۲",
                validator: numValidator,
              ),
            ),
          ],
        ),
      ],
    );
  }

  List<DropdownMenuItem<dynamic>>? get _items {
    return [
      DropdownMenuItem(
        child: Text("تست"),
        value: 1,
      ),
      DropdownMenuItem(
        child: Text("تست"),
        value: 2,
      ),
      DropdownMenuItem(
        child: Text("تست"),
        value: 3,
      ),
      DropdownMenuItem(
        child: Text("تست"),
        value: 4,
      ),
    ];
  }
}
