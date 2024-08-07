import 'package:flutter/material.dart';
import 'package:infitout_task/models/left_model.dart';
import 'package:infitout_task/models/right_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double height, width;
  double _currentValue = 24798.65;

  ScrollController leftController = ScrollController();
  ScrollController rightController = ScrollController();

  @override
  void initState() {
    super.initState();

    // Adding listener to left controller
    leftController.addListener(() {
      if (leftController.offset != rightController.offset) {
        rightController.jumpTo(leftController.offset);
      }
    });

    // Adding listener to right controller
    rightController.addListener(() {
      if (rightController.offset != leftController.offset) {
        leftController.jumpTo(rightController.offset);
      }
    });
  }

// Disposing off the controllers
  @override
  void dispose() {
    leftController.dispose();
    rightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "NIFTY",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            Row(
              children: [
                Text(
                  "NSE  MARKET CLOSED",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            )
          ],
        ),
        actions: const [Icon(Icons.search)],
      ),
      body: Container(
        margin: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      _currentValue.toStringAsFixed(2),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Slider(
                    value: _currentValue,
                    min: 24798.65,
                    max: 24971.75,
                    divisions: 100,
                    label: _currentValue.toStringAsFixed(2),
                    onChanged: (double value) {
                      setState(() {
                        _currentValue = value;
                      });
                    },
                    activeColor: Colors.green,
                    inactiveColor: Colors.grey,
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  height: height / 20,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          "Aug 1",
                          style: TextStyle(
                              fontSize: 13,
                              color: Color.fromARGB(255, 0, 36, 97)),
                        ),
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: Color.fromARGB(255, 0, 36, 97),
                      )
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  height: height / 20,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Row(
                    children: [
                      Icon(Icons.settings,
                          color: Color.fromARGB(255, 0, 36, 97)),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Configure",
                          style: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 0, 36, 97)),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: width / 40,
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  height: height / 20,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.open_in_new,
                        color: Colors.white,
                        size: 15,
                      ),
                      Text(
                        "Open",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height / 50,
            ),
            Container(
              height: height / 25,
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Center(
                          child: Text(
                    "Calls",
                    style: TextStyle(color: Colors.orange),
                  ))),
                  Expanded(
                      child: Center(
                          child: Text(
                    "Puts",
                    style: TextStyle(color: Colors.blue[900]),
                  )))
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: SingleChildScrollView(
                        controller: leftController,
                        scrollDirection: Axis.horizontal,
                        reverse: true,
                        child: DataTable(
                          border: TableBorder.all(color: Colors.grey),
                          columns: const [
                            DataColumn(label: Text('Volume')),
                            DataColumn(label: Text('Ol Chg%')),
                            DataColumn(label: Text('Ol')),
                            DataColumn(label: Text('Chng Chng%')),
                            DataColumn(label: Text('LTP')),
                          ],
                          rows: leftTableData.map((data) {
                            return DataRow(cells: [
                              DataCell(Text(data.Volume)),
                              DataCell(Text(data.Ol_Chg)),
                              DataCell(Text(data.Ol)),
                              DataCell(Text(data.Chng)),
                              DataCell(Text(data.LTP.toStringAsFixed(2))),
                            ]);
                          }).toList(),
                        ),
                      ),
                    ),
                    DataTable(
                      decoration: BoxDecoration(color: Colors.grey.shade200),
                      border: TableBorder(
                          left: Divider.createBorderSide(context,
                              color: Colors.grey)),
                      columns: const [
                        DataColumn(label: Text('Strike')),
                      ],
                      rows: List.generate(leftTableData.length, (index) {
                        return DataRow(cells: [
                          DataCell(
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  border:
                                      Border.all(color: Colors.grey.shade200)),
                              child: Center(
                                child: Text(
                                  '${index * 200}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ]);
                      }),
                    ),
                    DataTable(
                      decoration: BoxDecoration(color: Colors.grey.shade200),
                      border: TableBorder(
                          right: Divider.createBorderSide(context,
                              color: Colors.grey)),
                      columns: const [
                        DataColumn(
                          label: Text('IV'),
                        ),
                      ],
                      rows: List.generate(rightTableData.length, (index) {
                        return DataRow(cells: [
                          DataCell(
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  border:
                                      Border.all(color: Colors.grey.shade200)),
                              child: Center(
                                child: Text(
                                  '${index * .5}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ]);
                      }),
                    ),
                    Flexible(
                      child: SingleChildScrollView(
                        controller: rightController,
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          border: TableBorder.all(color: Colors.grey),
                          columns: const [
                            DataColumn(label: Text('LTP')),
                            DataColumn(label: Text('Chng Chng%')),
                            DataColumn(label: Text('Ol')),
                            DataColumn(label: Text('Ol Chg%')),
                            DataColumn(label: Text('Volume')),
                          ],
                          rows: rightTableData.map((data) {
                            return DataRow(cells: [
                              DataCell(Text(data.LTP.toStringAsFixed(2))),
                              DataCell(Text(data.Chng)),
                              DataCell(Text(data.Ol)),
                              DataCell(Text(data.Ol_Chg)),
                              DataCell(Text(data.Volume)),
                            ]);
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
