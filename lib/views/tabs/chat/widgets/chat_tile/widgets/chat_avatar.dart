import 'package:flutter/material.dart';

class ChatAvatar extends StatelessWidget {
  final String picture;
  ChatAvatar({required this.picture});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(.3),
              offset: Offset(0, 5),
              blurRadius: 25)
        ],
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: CircleAvatar(
              // backgroundImage: NetworkImage(friendsList[i]['imgUrl']),
              backgroundImage: NetworkImage((picture != null)
                  ? picture
                  : 'https://cdn.pixabay.com/photo/2019/11/06/17/26/gear-4606749_960_720.jpg'),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              height: 15,
              width: 15,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 3,
                ),
                shape: BoxShape.circle,
                color: Colors.green,
              ),
            ),
          )
        ],
      ),
    );
  }
}
