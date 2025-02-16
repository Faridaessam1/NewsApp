import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/constants/theme/app_styles.dart';
import 'package:provider/provider.dart';
import '../../../models/articles_model.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../provider/viewModel/home_view_model.dart';

class NewsCardWidget extends StatelessWidget {
  int index;
  NewsCardWidget({required this.index});

  @override
  Widget build(BuildContext context) {

    var viewModel = Provider.of<HomeViewModel>(context);
    final article = viewModel.articleList[index];
    final DateTime publishedDate = DateTime.parse(article!.publishedAt );
    final date = DateTime.now().difference(publishedDate);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.37,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.black, width: 3)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.black, width: 3),
                ),
                child: Expanded(
                  child: CachedNetworkImage(
                    imageUrl: article.urlToImage,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(
                      color: Colors.black,
                    )),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
            ),
            Text(article.title,
                style: AppStyles.W700Black16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                      child:Text("by:  ${article.author}",
                    style: AppStyles.W500Black20.copyWith(
                      color: const Color(0xffA0A0A0),
                      fontSize: 12,
                    ),
                  ),
                  ),
                  const Spacer(),
                  Expanded(
                      child: Text(viewModel.timeAgo(article.publishedAt) ,
                        style: AppStyles.W500Black20.copyWith(
                        color: const Color(0xffA0A0A0),
                        fontSize: 12,
                      ),
                      ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
