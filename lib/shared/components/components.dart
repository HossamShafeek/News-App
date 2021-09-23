import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/web_view/web_view_screen.dart';

Widget itemNews(list) {
  return Padding(
    padding: const EdgeInsets.only(top: 10.0),
    child: ListView.builder(
      padding: const EdgeInsets.only(top: 10.0),
      physics: BouncingScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 20.0),
        child: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return WebViewScreen(list[index]['url']);
            }));
          },
          child: Container(
            width: double.infinity,
            height: 105,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Theme.of(context).backgroundColor,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: list[index]['urlToImage'],
                      fit: BoxFit.cover,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                        child: CircularProgressIndicator(
                          value: downloadProgress.progress,
                          strokeWidth: 3,
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error,color: Colors.deepOrange,),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          list[index]['title'],
                          style: Theme.of(context).textTheme.bodyText1,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        Row(
                          //textBaseline: TextBaseline.ideographic,
                          //crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: [
                            Icon(
                              Icons.watch_later_outlined,
                              size: 16,
                              color: Colors.deepOrange,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              list[index]['publishedAt'],
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
