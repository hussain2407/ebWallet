import 'package:app/model/User.dart';
import 'package:app/view/Order.dart';
import 'package:app/view/dashboard.dart';
import 'package:flutter/material.dart';

class ChooseToOrder extends StatefulWidget {
  final List<User> data;

  const ChooseToOrder(
    this.data, {
    Key key,
  }) : super(key: key);
  _ChooseToOrderState createState() => _ChooseToOrderState(this.data);
}

class _ChooseToOrderState extends State<ChooseToOrder> {
  final List<User> data;
  List<bool> checkData;
  _ChooseToOrderState(this.data) {
    print(data);
    int length = data.length;

    checkData = List(length);

    for (var i = 0; i < length; i++) {
      checkData[i] = (false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users to Order"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemBuilder: (C, i) => itemBuilder(i),
              itemCount: data.length,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              RaisedButton(
                // shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Text(
                  "CANCEL",
                  style: TextStyle(color: Colors.blueAccent[700]),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (C) => DashboardMainPage()));
                },
              ),
              RaisedButton(
                // shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.blueAccent[700]),
                ),
                onPressed: () {
                  List<User> selected = List();
                  int selectedCount = 0;
                  int counter = 0;
                  data.forEach((user) {
                    if (checkData[counter]) {
                      selectedCount++;
                      selected.add(data[counter]);
                    }
                    counter++;
                  });
                  if (selectedCount < 2)
                    showDialog(
                      child: AlertDialog(
                        title: Text(
                          "You Must Select at least 2",
                        ),
                        actions: <Widget>[Icon(Icons.error)],
                      ),
                      context: context,
                    );
                  else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (C) =>
                                OrderPage(selected, selectedCount)));
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget itemBuilder(int index) {
    return Column(
      children: <Widget>[
        InkWell(
          child: ListTile(
            isThreeLine: false,
            enabled: true,
            //title: Text(data[index].username),
            title: Text(data[index].firstName + " " + data[index].lastName),
            trailing: Wrap(
              children: <Widget>[
                //Text("${data[index].amount.toStringAsFixed(2)}"),
                Checkbox(
                    value: checkData[index],
                    onChanged: (value) {
                      if (mounted)
                        setState(() {
                          checkData[index] = value;
                        });
                    })
              ],
            ),
            // leading: CircleAvatar(
            //   maxRadius: 25,
            //   child: Text(
            //     "" +
            //         data[index].firstName.substring(0, 1).toUpperCase() +
            //         data[index].lastName.substring(0, 1).toUpperCase(),
            //     style: TextStyle(fontSize: 18),
            //   ),
            // ),
            //subtitle: Text(data[index].firstName + " " + data[index].lastName),
          ),
          onTap: () {
            if (mounted)
              setState(() {
                if (checkData[index])
                  checkData[index] = false;
                else
                  checkData[index] = true;
              });
          },
        ),
        Divider()
      ],
    );
  }
}
