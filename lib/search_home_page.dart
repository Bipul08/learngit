import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vdo_app_api/services/pexel_services.dart';
import 'package:shimmer/shimmer.dart';

import 'VideoItem.dart';
// import 'VideoDetailPage.dart';

class VideoSearchScreen extends StatefulWidget {
  const VideoSearchScreen({Key? key}) : super(key: key);

  @override
  State<VideoSearchScreen> createState() => _VideoSearchScreenState();
}

class _VideoSearchScreenState extends State<VideoSearchScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: SizedBox(
              width: 280,
              height: 45,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    fillColor: Colors.white,
                    filled: true,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {});
                      },
                      icon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: viewSearchData(),
    );
  }

  Widget viewSearchData() {
    return FutureBuilder(
      future: PixelServices().searchApi(searchController.text.toString()),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildShimmerEffect(MediaQuery.of(context).size);
        } else if (snapshot.hasError) {
          return Center(child: Text('Location not found '));
        } else if (!snapshot.hasData || (snapshot.data?.videos?.isEmpty ?? true)) {
          return Center(
            child: Text('Search a video'),
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.videos!.length,
            itemBuilder: (context, index) {
              var video = snapshot.data!.videos![index];
              return Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      video.user?.name ?? '',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 7),
                    Container(
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: video.videoFiles?.length ?? 0,
                        itemBuilder: (context, fileIndex) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VideoDetailPage(video: video),
                                ),
                              );
                            },
                            child: Container(
                              width: 160,
                              height: 120,
                              margin: EdgeInsets.only(right: 10),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      video.image ?? '',
                                      width: 160,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Icon(
                                    CupertinoIcons.play_arrow_solid,
                                    size: 40,
                                    color: Colors.white,
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
        }
      },
    );
  }


  Widget _buildShimmerEffect(Size size) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (_, index) {
        return Padding(
          padding: EdgeInsets.all(10),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 200,
                  height: 30,
                  color: Colors.white,
                ),
                SizedBox(height: 10),
                Container(
                  width: size.width,
                  height: 120,
                  color: Colors.white,
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
