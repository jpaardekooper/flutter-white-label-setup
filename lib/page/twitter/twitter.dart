import 'package:base/ui/widgets/components/logo.dart';
import 'package:config/flavor_assets.dart';
import 'package:flutter/material.dart';
import 'package:base/state/social_state.dart';
import 'package:provider/provider.dart';
import 'package:tweet_ui/embedded_tweet_view.dart';
import 'package:tweet_ui/models/viewmodels/tweet_vm.dart';

class SocialScreen extends StatefulWidget {
  @override
  _SocialScreenState createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    Provider.of<SocialState>(context, listen: false).fetchTweets(200);
    _scrollController = ScrollController();
    super.initState();
  }

  Future<void> refreshData() async {
    await Provider.of<SocialState>(context, listen: false).fetchTweets(200);
  }

  @override
  Widget build(BuildContext context) {
    var socialState = Provider.of<SocialState>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: const Logo(scale: FlavorAssets.scale),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: socialState.tweetList.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: refreshData,
              child: Scrollbar(
                key: UniqueKey(),
                isAlwaysShown: true,
                controller: _scrollController,
                child: ListView.builder(
                  shrinkWrap: true,
                  controller: _scrollController,
                  itemCount: socialState.tweetList.length,
                  itemBuilder: (BuildContext context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8.0),
                      child: EmbeddedTweetView(
                          TweetVM.fromApiModel(
                              socialState.tweetList[index], null),
                          darkMode: false,
                          useVideoPlayer: true,
                          videoHighQuality: false),
                    );
                  },
                ),
              ),
            ),
    );
  }
}
