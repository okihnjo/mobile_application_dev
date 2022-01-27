import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatTrailingInfo extends StatelessWidget {
  @override
  ChatTrailingInfo({this.datetime});
  final datetime;
  Widget build(BuildContext context) {
    print(DateFormat.Hms()
        .format((datetime.toDate() as DateTime))
        .toString()
        .substring(0, 4));
    return Container(
      width: 60,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // friendsList[i]['seen']
              true
                  ? Icon(
                      Icons.check,
                      size: 15,
                    )
                  : Container(height: 15, width: 15),
              // Text("${friendsList[i]['lastMsgTime']}")
              Text(DateFormat.Hms()
                  .format((datetime.toDate() as DateTime))
                  .toString()
                  .substring(0, 5))
            ],
          ),
          SizedBox(
            height: 5.0,
          ),
          // friendsList[i]['hasUnSeenMsgs']
          false
              ? Container(
                  alignment: Alignment.center,
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    color: Colors.green[400],
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    // "${friendsList[i]['unseenCount']}",
                    '2',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : Container(
                  height: 25,
                  width: 25,
                ),
        ],
      ),
    );
  }
}
