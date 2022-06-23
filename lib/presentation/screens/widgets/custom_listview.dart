import 'package:egytimes/presentation/screens/widgets/news_page_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyCustomListView extends StatelessWidget {
  const MyCustomListView({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  final cubit;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'business-news',
      child: ListView.builder(
        itemCount: cubit.articles?.length ?? 5,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsDetailsPage(
                    article: cubit.articles[index],
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xffF5F2E8),
                  border: Border.all(
                    color: const Color(0x00F5F2E8),
                    width: 1,
                  ),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(8.0),
                  leading: cubit.articles?[index].urlToImage == null
                      ? Image.asset(
                          'assets/images/business-news.png',
                          width: 100,
                          fit: BoxFit.fill,
                        )
                      : Image.network(
                          cubit.articles?[index].urlToImage ??
                              'https://www.queenstownairport.co.nz/themes/qac/images/placeholder/news-placeholder.png',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                  title: Text(cubit.articles?[index].title ?? '',
                      maxLines: 1,
                      // overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      )),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cubit.articles?[index].description ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        DateFormat('dd MMMM yyyy').format(
                          DateTime.parse(cubit.articles?[index].publishedAt ??
                              '2020-01-01'),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
