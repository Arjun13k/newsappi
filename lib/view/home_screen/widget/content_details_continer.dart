import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsappi/model/news_api_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ContinerWidget extends StatelessWidget {
  const ContinerWidget({super.key, required this.articles});
  final Article? articles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(.2),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              CachedNetworkImage(
                imageUrl: articles?.urlToImage ?? "",
                errorWidget: (context, url, error) =>
                    Image.asset("asset/image/no-image-icon-11.png"),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                articles?.title ?? "",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              SizedBox(
                height: 10,
              ),
              Text(articles?.description ?? ""),
              SizedBox(
                height: 10,
              ),
              Text(articles?.content ?? ""),
              ElevatedButton(
                  onPressed: () async {
                    await launchUrl(Uri.parse(articles?.url ?? ""));
                  },
                  child: Text("Read more"))
            ],
          ),
        ),
      ),
    );
  }
}
