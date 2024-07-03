import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vdo_app_api/search_home_page.dart';
import 'package:vdo_app_api/services/pexel_services.dart';

import 'VideoItem.dart';

class VideoHomeScreen extends StatefulWidget {
  const VideoHomeScreen({super.key});

  @override
  State<VideoHomeScreen> createState() => _VideoHomeScreenState();
}

class _VideoHomeScreenState extends State<VideoHomeScreen> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(
          'Videos',
          style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => VideoSearchScreen()));
            },
            icon: Icon(Icons.search, color: Colors.white,),
          )
        ],
      ),
      body: Container(
        width: width,
        child: FutureBuilder(
          future: PixelServices().getPixelApi(),
          builder: (context, snapshot) {
            var data = snapshot.data;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _buildShimmerEffect(MediaQuery.of(context).size);
            } else if (snapshot.hasError) {
              return Center(child: Text('Error occurred: ${snapshot.error}'));
            }
            if (!snapshot.hasData || data!.videos!.isEmpty) {
              return Center(child: Text('No videos available'));
            }
            return ListView.builder(
              itemCount: data.videos!.length,
              itemBuilder: (context, index) {
                var video = data.videos![index];
                return Container(
                  width: width,
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              video.user!.name!,
                              style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                            Icon(Icons.favorite_border, color: Colors.red), // Example of favorite icon
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        width: width,
                        height: 160,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: video.videoPictures!.length,
                          itemBuilder: (_, picIndex) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => VideoDetailPage(video: video)),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(7),
                                      child: Image.network(
                                        video.videoPictures![picIndex].picture!,
                                        width: 200,
                                        height: 160,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Icon(
                                        CupertinoIcons.play_arrow_solid,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildShimmerEffect(Size size) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (_, index){
        return Padding(
          padding: EdgeInsets.all(10),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 150,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 220,
                  height: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}
