part of 'widgets.dart';

class ItemRestaurant extends StatelessWidget {
  final Restaurant restaurant;

  const ItemRestaurant({
    required this.restaurant,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double rating = restaurant.rating.toDouble();
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: AppLayout.getHeight(12),
                horizontal: AppLayout.getWidth(12)),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(
                  vertical: AppLayout.getHeight(8),
                  horizontal: AppLayout.getWidth(8)),
              leading: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: AppLayout.getWidth(80),
                  minHeight: AppLayout.getHeight(80),
                  maxWidth: AppLayout.getWidth(80),
                  maxHeight: AppLayout.getHeight(80),
                ),
                child: Hero(
                    tag: restaurant.pictureId,
                    child: Image.network(ApiService().urlImage+restaurant.pictureId),),
              ),
              title: Text(restaurant.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.location_city),
                      Text(restaurant.city),
                    ],
                  ),
                  Row(
                    children: [
                      Text(rating.toString()),
                      const SizedBox(),
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
                  )
                ],
              ),
            ),
          ),
          onTap: ()=> Get.to(DetailScreen(restaurant: restaurant))),
    );
  }
}
