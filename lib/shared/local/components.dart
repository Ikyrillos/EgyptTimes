import 'package:egytimes/data/models/articlesModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';


Widget buildCardItem({required Articles article}) {
  DateTime date = DateTime.parse(article.publishedAt as String);

  return Padding(
    padding:
        const EdgeInsets.only(bottom: 8.0, left: 5.0, right: 5.0, top: 8.0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 4,
            blurRadius: 4,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Card(
        child: GridTile(
            header: Container(
              color: Colors.white70,
              child: Center(
                child: Text(
                  DateFormat.yMMMEd().format(date),
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            footer: Container(
              color: Colors.white60,
              alignment: Alignment.centerRight,
              child: Text(
                article.title.toString(),
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.roboto(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
              ),
            ),
            child: Image.network(
              article.urlToImage ??
                  'https://wcssg.co.uk/wp-content/uploads/2014/10/News_placeholder-image.jpg',
              fit: BoxFit.contain,
            )),
      ),
    ),
  );
}



  Widget buildMyListView(var cubit) {
    return AnimatedList(
      
      key: const Key('business_news_list'),
      itemBuilder: ((context, index, animation) =>
          _buildItem(context, index, animation, cubit)),
    );
  }

  _buildItem(
      BuildContext context, int index, Animation<double> animation, var cubit) {
    return SlideTransition(
      position: animation.drive(Tween(begin: const Offset(0, 1), end: Offset.zero)
          .chain(CurveTween(curve: Curves.easeIn))),
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
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                )),
            subtitle: Text(
              cubit.articles?[index].description ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }