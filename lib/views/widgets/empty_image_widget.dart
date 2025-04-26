import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class EmptyImageWidget extends StatelessWidget {
  const EmptyImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: double.infinity,
      imageUrl: Constants.emptyImagePath,
      fit: BoxFit.cover,
    );
  }
}
