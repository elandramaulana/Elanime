import 'dart:math';

import 'package:flutter/material.dart';
import 'package:myanimelist/services/network.dart';
import 'package:myanimelist/layout/animeInfoPage.dart';
import 'package:myanimelist/utilities/constant.dart';
import 'package:myanimelist/widgets/custom_text.dart';

class SeasonalAnime extends StatefulWidget {
  const SeasonalAnime({Key? key}) : super(key: key);

  @override
  _SeasonalAnimeState createState() => _SeasonalAnimeState();
}

class _SeasonalAnimeState extends State<SeasonalAnime> {
  Networking netWorking = Networking();
  late Future seasonalAnimeReference;
  late Future seasonalAnime;
  int randomImageGenerator = 0;

  @override
  void initState() {
    randomImageGenerator = Random().nextInt(13);
    seasonalAnimeReference = netWorking.jikaApiSeasonalAnime();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              backColor,
              backColor,
            ],
            stops: const [0.3, 0.5],
          ),
        ),
        child: ListView(physics: const ClampingScrollPhysics(), children: [
          Padding(
            padding: EdgeInsets.only(
                left: width(context) * 0.05, top: width(context) * 0.05),
            child: CustomText(
                text: 'Top Anime',
                color: Colors.white.withOpacity(0.7),
                size: 20),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: FutureBuilder(
                future: seasonalAnimeReference,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                        child: Image.asset(
                      'images/image$randomImageGenerator.gif',
                      height: 200,
                      width: 200,
                    ));
                  }
                  return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.75,
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                      ),
                      itemCount: netWorking.lisResponseSeasonal.isEmpty
                          ? 0
                          : netWorking.lisResponseSeasonal.length,
                      itemBuilder: (context, index) {
                        return Hero(
                          tag: 'poster$index',
                          child: Stack(children: [
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                    netWorking.lisResponseSeasonal[index]
                                        ['images']['jpg']['image_url'],
                                  ),
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(5.0),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Material(
                                  color: primary_color.withOpacity(0.5),
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10.0),
                                        bottomRight: Radius.circular(5.0),
                                      ),
                                    ),
                                    child: CustomText(
                                      text: netWorking
                                          .lisResponseSeasonal[index]['title']
                                          .toString(),
                                      size: 18.0,
                                      color: secondary_color,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return AnimeInfoPage(
                                        netWorking.lisResponseSeasonal, index);
                                  }));
                                });
                              },
                            ),
                          ]),
                        );
                      });
                }),
          ),
        ]),
      ),
    );
  }
}
