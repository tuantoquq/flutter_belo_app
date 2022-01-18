class PostCardModel {

  String linkImage;
  int countLikes;
  int countComment;
  String timeElement ;
  String author;
  String describe;
  bool isLiked;
  bool isReported;

  PostCardModel(
      { required this.author,
        required this.timeElement,
        required this.countComment,
        required this.countLikes,
        required this.describe,
        required this.isLiked,
        required this.linkImage,
        required this.isReported,
      });
}