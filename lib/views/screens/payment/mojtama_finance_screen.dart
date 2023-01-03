import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mojtama/models/state_model.dart';

import 'package:mojtama/views/widgets/custom_table_widget.dart';
import 'package:provider/provider.dart';

class MojtamaFinanceScreen extends StatefulWidget {
  const MojtamaFinanceScreen({super.key});

  @override
  State<MojtamaFinanceScreen> createState() => _MojtamaFinanceScreenState();
}

class _MojtamaFinanceScreenState extends State<MojtamaFinanceScreen> {
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    Future.delayed(Duration.zero, () => _loadResources());
  }

  _loadResources() async {
    var provider =
        Provider.of<MojtamaStatusExpansionModel>(context, listen: false);
    await provider.getFinancialStatus();
    await provider.getRules();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("وضعیت مالی مجتمع"),
      ),
      body: RefreshIndicator(
        onRefresh: () => _loadResources(),
        child: ListView(
          children: [
            Consumer<MojtamaStatusExpansionModel>(
              builder: (context, model, child) {
                return ExpansionPanelList(
                  expansionCallback: (index, isExpanded) {
                    model.changeIsOpen(index, !isExpanded);
                    print(model.mojtamaRule.createdOn);
                  },
                  children: [
                    ExpansionPanel(
                      headerBuilder: (context, isOpen) {
                        return Center(
                          child: Text(
                            'قوانین مجتمع',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        );
                      },
                      body: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            model.isLoading
                                ? CircularProgressIndicator()
                                : RichText(
                                    text: TextSpan(
                                      style: DefaultTextStyle.of(context).style,
                                      children: [
                                        TextSpan(
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                            text:
                                                "${model.mojtamaRule.rule}\n\n"),
                                        TextSpan(
                                          text:
                                              '${model.mojtamaRule.createdOn} روز پیش، در ساعت ${model.mojtamaRule.createdTime} ساخته شد.\n',
                                        ),
                                        TextSpan(
                                          text:
                                              '${model.mojtamaRule.editedOn} روز پیش، در ساعت ${model.mojtamaRule.editedTime} ویرایش شد.\n',
                                        ),
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      isExpanded: model.isOpen[0],
                    ),
                    ExpansionPanel(
                      headerBuilder: (context, isOpen) {
                        return const Center(
                          child: Text(
                            'وضعیت مالی مجتمع',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        );
                      },
                      body: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: model.isLoading
                            ? CircularProgressIndicator()
                            : CustomTable(
                                decodedJson:
                                    jsonDecode(model.financialStatusText),
                              ),
                      ),
                      isExpanded: model.isOpen[1],
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
