import 'package:belo_app/screens/chat/detail_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:belo_app/models/post.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:belo_app/screens/dashboard/news_feed_screen.dart';

class PostCard extends StatelessWidget {
  final PostCardModel postCardModel;
  PostCard(
      {Key? key,
        required this.postCardModel})
      : super(key: key);

  Widget build(BuildContext context){
    return InkWell(
      onTap: () {

      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: SvgPicture.asset(
                'assets/icons/user_avt.svg',
                color: Colors.white,
                height: 36,
                width: 36,
              ),
              backgroundColor: Colors.grey,
            ),
            title: Text(
              postCardModel.author,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'added a new post: '+ postCardModel.timeElement,
              style: const TextStyle(fontSize: 14),
            ),
            trailing: IconButton(
              onPressed: (){

              },
              icon: Icon(Icons.warning_amber_sharp, size: 18,),
            ),
          ),
          const Padding(
              padding: EdgeInsets.only(right: 20, left: 80),
              child: Divider(
              thickness: 1,
              ),
          ),
          Container(
              child: Column(
                children: [
                  Row(
                    children:[
                      SizedBox(width: 30,),
                      Text(postCardModel.describe,style: TextStyle(fontSize: 16),),
                    ]
                  ),
                  SizedBox(height: 5,),
                  Container(
                    width: 370,
                    height: 370,
                    decoration: BoxDecoration(
                      color: Colors.white54,
                      border: Border.all(color: Colors.blue, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Image.asset(postCardModel.linkImage),
                  ),
                  Container(
                    child: Row(
                      children: [
                        SizedBox(width: 20,),
                        IconButton(
                            onPressed:(){

                        },
                            icon: Icon(Icons.thumb_up_outlined, color: Colors.blue,),
                        ),
                        Text(
                          postCardModel.countLikes != 0 ? ((postCardModel.countLikes).toString())+ ' likes' : '',
                        ),
                        SizedBox(width: 40,),
                        IconButton(
                            onPressed:(){

                        },
                            icon: Icon(Icons.comment_bank, color: Colors.blue,)
                        ),
                        Text(
                          postCardModel.countComment != 0? ((postCardModel.countComment).toString())+ ' commments' : '',
                        ),
                      ],
                    ),
                  ),
                ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 20, left: 20),
            child: Divider(
              color: Colors.blue,
              thickness: 1,
            ),
          )
        ],
      ),
    );
  }

}