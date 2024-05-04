import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsappi/controller/home_screen_controller.dart';
import 'package:newsappi/view/home_screen/widget/content_details_continer.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

String? selectedDropdown;

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<HomeScreenController>().getCategoryData();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final providerObj = Provider.of<HomeScreenController>(context);
    return DefaultTabController(
      length: providerObj.category.length,
      child: Scaffold(
          drawer: Drawer(
              // child: Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     DropdownButton(
              //       value: selectedDropdown,
              //       hint: Text("LANGUAGE"),
              //       items: List.generate(
              //           providerObj.language.length,
              //           (index) => DropdownMenuItem(
              //                 child: Text(providerObj.languageIndex[index]),
              //                 value: providerObj.languageIndex[index],
              //                 onTap: () {
              //                   providerObj
              //                       .getLanguageData(providerObj.language[index]);

              //                 },
              //               )),
              //       onChanged: (value) {
              //         selectedDropdown = value;
              //         setState(() {});
              //       },
              //     ),
              //   ],
              // ),
              ),
          appBar: AppBar(
            centerTitle: true,
            title: Text("WORLD NEWS",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
            actions: [
              //
              IconButton(
                  onPressed: () {
                    // TextField(
                    //   decoration: InputDecoration(hintText: "ss"),
                    // );
                  },
                  icon: Icon(Icons.search))
            ],
            bottom: TabBar(
                unselectedLabelColor: Colors.black,
                labelColor: Colors.white,
                indicator: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(40)),
                indicatorSize: TabBarIndicatorSize.tab,
                onTap: (value) {
                  providerObj.getCategory(value);
                },
                isScrollable: true,
                tabs: List.generate(
                    providerObj.category.length,
                    (index) => Tab(
                          text: "${providerObj.category[index].toUpperCase()}",
                        ))),
          ),
          body: providerObj.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.separated(
                  itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ContinerWidget(
                                      articles: providerObj
                                          .restbyCategory?.articles?[index]),
                                ));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(.2),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: providerObj.restbyCategory
                                          ?.articles?[index].urlToImage ??
                                      "",
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                          "asset/image/no-image-icon-11.png"),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  providerObj.restbyCategory?.articles?[index]
                                          .title ??
                                      "",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(providerObj.restbyCategory
                                        ?.articles?[index].description ??
                                    "")
                              ],
                            ),
                          ),
                        ),
                      ),
                  separatorBuilder: (context, index) => SizedBox(
                        height: 15,
                      ),
                  itemCount: providerObj.restbyCategory?.articles?.length ?? 0)
          // :
          // ListView.builder(
          //     itemCount: providerObj.restbyCategory?.articles?.length ?? 0,
          //     itemBuilder: (context, index) => ListTile(
          //       title: Text(
          //           providerObj.restbyCategory?.articles?[index].title ?? ""),
          //     ),
          //   ),
          ),
    );
  }
}
