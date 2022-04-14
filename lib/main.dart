import 'package:flutter/material.dart';
import 'dart:math';

List<myItem> itemList = [];

void main() {
  runApp(const MyApp());
}

class myItem {
  int? index;
  int? count;
  Color color = Colors.primaries[Random().nextInt(Colors.primaries.length)];

  myItem(int index, int count){
    this.index = index;
    this.count = count;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '面試題目',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: '面試題目'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void stateSetter(int i, int j, myItem temp) {
    // Swap items in list
    setState(() {
      itemList[i] = itemList[j];
      itemList[j] = temp;
      print('swap ${i} and ${j}');
      print('${itemList[i].count} and ${itemList[j].count}');
    });
  }

  @override
  Widget build(BuildContext context) {
    final swapController1 = TextEditingController();
    final swapController2 = TextEditingController();

    @override
    void dispose() {
      // Clean up the controller when the widget is disposed.
      swapController1.dispose();
      swapController2.dispose();
      super.dispose();
    }

    // Initialize the list
    for (int i = 0; i < 10; i++) {
      myItem item = new myItem(i, 0);
      itemList.add(item);
    }  // for ()

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 130.0,
                height: 55,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: swapController1,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        filled: true,
                        contentPadding: EdgeInsets.all(8.0),
                        hintStyle: TextStyle(fontSize:15, color: Colors.grey[800]),
                        hintText: "請輸入index 1",

                        fillColor: Colors.white70),
                  ),
                ),
              ),
              SizedBox(
                width: 130.0,
                height: 55,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: swapController2,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        filled: true,
                        contentPadding: EdgeInsets.all(8.0),
                        hintStyle: TextStyle(fontSize:15, color: Colors.grey[800]),
                        hintText: "請輸入index 2",
                        fillColor: Colors.white70),
                  ),
                ),
              ),
              SizedBox(
                  height: 50,
                  width: 80,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        final i = int.parse(swapController1.text);
                        final j = int.parse(swapController2.text);
                        final myItem temp = itemList[i];
                        stateSetter(i, j, temp);
                      },
                      child: const Text("交換"),
                    ),
                  )
              )
            ]
          ),
          Expanded(
            child: ListView.builder(
              itemExtent: 60.0,
              itemCount: 10,//CHANGED
              itemBuilder: (context, index) => Container(
                child: Material(
                  elevation: 4.0,
                  color: itemList[index].color,
                  child: Center(
                    child: ListTitleItem(item: itemList[index], index: index),
                    // Build the list with item and its index.
                  ),
                ),
              ),
            )
          )
        ],
      )
    );
  }
}

class ListTitleItem extends StatefulWidget {

  myItem item;
  int index;
  ListTitleItem({required this.item, required this.index});

  @override
  _ListTitleItemState createState() => _ListTitleItemState(index);
}

class _ListTitleItemState extends State<ListTitleItem> {
  int _itemCount = 0;
  int index = 0;
  _ListTitleItemState(int index) {
    this.index = index;
  }

  @override
  Widget build(BuildContext context) {

    return ListTile(
      title: Text(
            '${widget.item.index}.點擊數量${widget.item.count}',
            style: TextStyle(fontSize:12, color: Colors.white),
          ),
      onTap: () {},
      trailing: _buildTrailingWidget(),
    );
  }


  void stateSetter(int _itemCount) {
    setState(() {
      // set the count and update in list
      widget.item.count = _itemCount;
      itemList[index].count = widget.item.count;
    });
  }

  Widget _buildTrailingWidget() {
    return FittedBox(
      child: Row(children: [
        ElevatedButton(
          onPressed: () { stateSetter(++_itemCount); },
          style: ElevatedButton.styleFrom(
            primary: Colors.white, // Background color
            onPrimary: Colors.black, // Text Color
          ),
          child: Row(
            children: <Widget>[
              const Text(
                '點擊+1',
                style: TextStyle(fontSize: 12),
              ),
            ]
          ),
        )
      ],),
    );
  }

}
