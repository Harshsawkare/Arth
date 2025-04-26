import 'package:flutter/material.dart';

class ShimmerArticlePlaceholder extends StatelessWidget {
  const ShimmerArticlePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: theme.cardColor),
      ),
      child: Column(
        children: [
          /// Image Placeholder
          SizedBox(
            height: 150,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10),
              ),
              child: Container(
                color: theme.cardColor, // Add a color to simulate an image
              ),
            ),
          ),

          /// Info Placeholder
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: 20,
                    color: theme.cardColor, // Simulate a title
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    height: 20,
                    color: theme.cardColor, // Simulate a subtitle
                  ),
                ),
                const Spacer(),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 2),
                  child: Divider(thickness: 0.5),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    bottom: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 20,
                        width: 50,
                        color: theme.cardColor, // Simulate a source name
                      ),
                      const Spacer(),
                      Container(
                        height: 20,
                        width: 50,
                        color: theme.cardColor, // Simulate a date
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
