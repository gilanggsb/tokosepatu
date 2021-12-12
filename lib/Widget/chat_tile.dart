import 'package:flutter/material.dart';
import 'package:tokosepatu/models/message_model.dart';
import 'package:tokosepatu/models/product_model.dart';
import 'package:tokosepatu/pages/home/detail_chat_page.dart';
import 'package:tokosepatu/theme.dart';

class ChatTile extends StatelessWidget {
  final MessageModel message;
  const ChatTile({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DetailChatPage(product: UnintializedProductModel())));
      },
      child: Container(
        margin: const EdgeInsets.only(
          top: 33,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/images/image_shop_logo.png',
                  width: 54,
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Shoe Store',
                        style: primaryTextStyle.copyWith(
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        message.message,
                        overflow: TextOverflow.ellipsis,
                        style: secondaryTextStyle.copyWith(
                          fontWeight: light,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Now',
                  style: secondaryTextStyle.copyWith(
                    fontSize: 10,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                const Divider(
                  thickness: 1,
                  color: Color(0xFF2B2939),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
