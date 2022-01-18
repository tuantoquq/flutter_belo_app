import 'package:belo_app/screens/dashboard/new_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:belo_app/widgets/post_card.dart';
import 'package:belo_app/models/post.dart';

class NewsFeedScreen extends StatefulWidget {
  const NewsFeedScreen({Key? key}) : super(key: key);

  @override
  _NewsFeedScreenState createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen> {

  List<PostCardModel>  listPosts = [
    PostCardModel(
        author: "Tuan Nguyen",
        describe: "Hi tomorrow",
        countLikes: 12,
        countComment: 0,
        linkImage: 'assets/images/cat.jpg',
        isLiked: false,
        timeElement: '10:20',
        isReported: false,
    ),
    PostCardModel(
      author: "Tuan Nguyen",
      describe: "Hi tomorrow",
      countLikes: 12,
      countComment: 10,
      linkImage: 'assets/images/cat.jpg',
      isLiked: false,
      timeElement: '10:20',
      isReported: false,
    ),
    PostCardModel(
      author: "Tuan Nguyen",
      describe: "Hi tomorrow",
      countLikes: 12,
      countComment: 10,
      linkImage: 'assets/images/cat.jpg',
      isLiked: false,
      timeElement: '10:20',
      isReported: false,
    ),
    PostCardModel(
      author: "Tuan Nguyen",
      describe: "Hi tomorrow",
      countLikes: 12,
      countComment: 10,
      linkImage: 'assets/images/cat.jpg',
      isLiked: false,
      timeElement: '10:20',
      isReported: false,
    ),
    PostCardModel(
      author: "Tuan Nguyen",
      describe: "Hi tomorrow \n hello anh em",
      countLikes: 0,
      countComment: 10,
      linkImage: 'assets/images/cat.jpg',
      isLiked: false,
      timeElement: '10:20',
      isReported: false,
    ),
    PostCardModel(
      author: "Tuan Nguyen",
      describe: "Hi tomorrow",
      countLikes: 12,
      countComment: 10,
      linkImage: 'assets/images/cat.jpg',
      isLiked: false,
      timeElement: '10:20',
      isReported: false,
    ),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white70,
              border: Border(
                bottom: BorderSide(
                  color: Colors.blue,
                  width: 2.0,
                )
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 10,),
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/logo.png'),
                  radius: 40,
                ),
                const SizedBox(width: 30,),
                TextButton.icon(
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const NewsPostScreen()),
                        );
                  },
                  icon: const Icon(Icons.edit, size: 25,),
                  label: const Text('How are you today ?', ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Scrollbar(child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: listPosts.length,
              itemBuilder: (context, index) => PostCard(postCardModel: listPosts[index]),
            ),
            )
          ),
        ],
      )
    );
  }
}

