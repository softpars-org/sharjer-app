import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mojtama/viewmodels/state_model.dart';

import 'package:mojtama/views/widgets/custom_table_widget.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
    await provider.getFinancialStatus(context);
    await provider.getRules(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("وضعیت مالی مجتمع"),
      ),
      body: RefreshIndicator(
        onRefresh: () => _loadResources(),
        child: ListView(
          children: [
            Consumer<MojtamaStatusExpansionModel>(
              builder: (context, model, child) {
                return ExpansionPanelList(
                  expansionCallback: (index, isExpanded) async {
                    model.changeIsOpen(index, !isExpanded);
                  },
                  children: [
                    ExpansionPanel(
                      headerBuilder: (context, isOpen) {
                        return const Center(
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
                                ? const CircularProgressIndicator()
                                : Column(
                                    children: [
                                      ElevatedButton.icon(
                                        onPressed: () async {
                                          String dataUri =
                                              "http://amolicomplex.ir/statute.pdf";
                                          await launchUrlString(
                                            dataUri,
                                            mode:
                                                LaunchMode.externalApplication,
                                          );
                                        },
                                        icon: const Icon(Icons.rule),
                                        label:
                                            const Text("دیدن اساسنامه مجتمع"),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          style: DefaultTextStyle.of(context)
                                              .style,
                                          children: [
                                            TextSpan(
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
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
                        padding: const EdgeInsets.all(8.0),
                        child: model.isLoading
                            ? const CircularProgressIndicator()
                            : Column(
                                children: List.generate(
                                  jsonDecode(model.financialStatusText).length,
                                  (index) {
                                    var financialJson =
                                        jsonDecode(model.financialStatusText);
                                    return CustomTable(
                                        decodedJson: financialJson[index]);
                                  },
                                ),
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
