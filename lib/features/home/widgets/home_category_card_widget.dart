import 'package:flutter/material.dart';
import 'package:news_app/models/categoryModel.dart';

import '../../../constants/theme/app_colors.dart';
import '../../../constants/theme/app_styles.dart';

class HomeCategoryCardWidget extends StatelessWidget {
  int index;

  HomeCategoryCardWidget({
    required this.index,
    required this.categories,
  });

  List<CategoryDataModel> categories;

  @override
  Widget build(BuildContext context) {
    return Stack(
        alignment:
            index % 2 == 0 ? Alignment.bottomRight : Alignment.bottomLeft,
        children: [
          Container(
            padding: EdgeInsets.all(3),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(
                categories[index].CategoryImg,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            width: 170,
            height: 55,
            decoration: BoxDecoration(
              color: AppColors.primaryColorLight.withOpacity(0.4),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Directionality(
              textDirection:
                  index % 2 == 0 ? TextDirection.ltr : TextDirection.rtl,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "View All",
                    textAlign: TextAlign.center,
                    style:AppStyles.W500Black24,
                  ),
                  Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColorLight,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.arrow_forward_ios),
                  )
                ],
              ),
            ),
          ),
        ]);
  }
}
