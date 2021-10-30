import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CachedEventImage extends StatelessWidget {
  final String url;
  final bool? takingGuest;
  final double width, height;

  final String page;
  const CachedEventImage(
      this.url, this.width, this.height, this.page, this.takingGuest);

  Widget _showTakingGuest(BuildContext context) {
    return takingGuest!
        ? Positioned(
            bottom: 0,
            right: 0,
            child: ClipOval(
              child: Container(
                padding: EdgeInsets.all(2),
                color: Theme.of(context).colorScheme.primary,
                child: Row(
                  children: [
                    Icon(
                      Icons.plus_one,
                      color: Colors.white,
                      size: 12,
                    ),
                  ],
                ),
              ),
            ),
          )
        : SizedBox();
  }

  _buildPlaceholder(BuildContext context) {
    return Stack(
      children: [
        Container(
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
        ),
        _showTakingGuest(context)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return url.isEmpty
        ? _buildPlaceholder(context)
        : CachedNetworkImage(
            cacheKey: url,
            fadeInDuration: Duration(milliseconds: 0),
            placeholderFadeInDuration: Duration(milliseconds: 0),
            fadeOutDuration: Duration(milliseconds: 0),
            imageUrl: url,
            imageBuilder: (context, imageProvider) {
              return Stack(
                children: [
                  Container(
                    width: width,
                    height: height,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  _showTakingGuest(context)
                ],
              );
            },
            placeholder: (context, url) => _buildPlaceholder(context),
            errorWidget: (context, url, error) => _buildPlaceholder(context),
          );
  }
}
