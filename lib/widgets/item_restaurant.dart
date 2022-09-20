part of 'widgets.dart';

class ItemRestaurant extends StatelessWidget {
  final Restaurant restaurant;

  const ItemRestaurant({
    required this.restaurant,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var rating = restaurant.rating.toDouble();
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Get.to(() => DetailScreen(
                  restaurant: restaurant,
                ));
          },
          borderRadius: BorderRadius.circular(16.0),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 12.0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Hero(
                    tag: restaurant.pictureId,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.network(
                        ApiService().urlImage + restaurant.pictureId,
                        fit: BoxFit.cover,
                        height: 80,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12.0,
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 2.0,
                      ),
                      Text(
                        restaurant.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      const SizedBox(
                        height: 2.0,
                      ),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          children: [
                            const WidgetSpan(
                              child: Icon(
                                Icons.location_on,
                                size: 14,
                                color: blue,
                              ),
                            ),
                            TextSpan(
                              text: ' ${restaurant.city}',
                            )
                          ],
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                      const SizedBox(
                        height: 2.0,
                      ),
                       RatingBarIndicator(
                      rating: rating,
                      itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      direction: Axis.horizontal,
                      itemSize: 20,
                    ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
