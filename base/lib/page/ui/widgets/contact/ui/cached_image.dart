import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CachedImage extends StatelessWidget {
  const CachedImage(
      {required this.id,
      required this.url,
      required this.width,
      required this.height,
      required this.page});

  final String id;
  final String url;
  final double width, height;
  final String page;

  _buildPlaceholder(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: CircleAvatar(
        backgroundColor: Colors.grey[200],
        child: FaIcon(
          FontAwesomeIcons.userAlt,
          color: Color.fromRGBO(169, 204, 255, 1),
          size: width / 2,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      transitionOnUserGestures: true,
      tag: id + url + page,
      child: url.isEmpty || !Uri.parse(url).isAbsolute
          ? _buildPlaceholder(context)
          : CachedNetworkImage(
              cacheKey: url,
              fadeInDuration: Duration(milliseconds: 0),
              placeholderFadeInDuration: Duration(milliseconds: 0),
              fadeOutDuration: Duration(milliseconds: 0),
              imageUrl: url,
              imageBuilder: (context, imageProvider) => Container(
                width: width,
                height: height,
                decoration: page == 'p'
                    ? BoxDecoration(
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.fill),
                      )
                    : BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
              ),
              placeholder: (context, url) => _buildPlaceholder(context),
              errorWidget: (context, url, error) => _buildPlaceholder(context),
            ),
    );
  }
}
