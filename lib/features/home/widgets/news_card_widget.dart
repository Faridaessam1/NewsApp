import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/constants/theme/app_styles.dart';
import 'package:provider/provider.dart';
import '../../../constants/widgets/custom_elevated_button.dart';
import '../../../models/articles_model.dart';
import '../../../provider/viewModel/home_view_model.dart';

class NewsCardWidget extends StatelessWidget {
  int index;

  NewsCardWidget({required this.index});

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<HomeViewModel>(context);
    final article = viewModel.articleList[index];
    if (viewModel.articleList.length <= index) {
      return Container(
        padding: const EdgeInsets.all(15),
        child: const Center(child: Text("No Data")),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.black, width: 2)),
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 320,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: CachedNetworkImage(
                  imageUrl:viewModel.articleList[index]!.urlToImage,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(viewModel.articleList[index]!.title, style: AppStyles.W700Black16),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "by:  ${viewModel.articleList[index]!.author}",
                    style: AppStyles.W500Black20.copyWith(
                      color: const Color(0xffA0A0A0),
                      fontSize: 12,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  viewModel.timeAgo(viewModel.articleList[index]!.publishedAt),
                  style: AppStyles.W500Black20.copyWith(
                    color: const Color(0xffA0A0A0),
                    fontSize: 12,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

}
