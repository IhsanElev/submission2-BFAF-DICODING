part of 'pages.dart';

class DetailScreen extends StatefulWidget {
  static const routeName = '/restaurant_detail';

  final Restaurant restaurant;

  const DetailScreen({
    required this.restaurant,
    Key? key,
  }) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool foodExpanded = false;
  bool drinkExpanded = false;

  Widget _buildAppBar({List<Widget>? actions}) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 200,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      iconTheme: IconThemeData(
        color: Theme.of(context).primaryColor,
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: widget.restaurant.pictureId,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(16.0),
              bottomRight: Radius.circular(16.0),
            ),
            child: Image.network(
              ApiService().urlImage + widget.restaurant.pictureId,
              fit: BoxFit.cover,
            
            ),
          ),
        ),
      ),
      actions: actions,
    );
  }

  Widget _buildBody(Restaurant restaurant) {
    var rating = restaurant.rating.toDouble();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        restaurant.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          children: [
                            const WidgetSpan(
                              child: Icon(
                                Icons.location_on,
                                size: 16,
                                color: blue,
                              ),
                            ),
                            TextSpan(
                              text:
                                  ' ${restaurant.address}, ${restaurant.city}',
                            )
                          ],
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    ],
                  ),
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
                const SizedBox(
                  width: 10,
                ),
                Text(
                  rating.toString(),
                  style: Theme.of(context).textTheme.subtitle2,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          restaurant.categories != null
              ? _buildListCategories(restaurant.categories!)
              : Container(),
          const SizedBox(
            height: 16.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ReadMoreText(
              restaurant.description,
              style: Theme.of(context).textTheme.bodyText2,
              trimLines: 5,
              colorClickableText: Colors.blue,
              trimMode: TrimMode.Line,
              trimCollapsedText: 'Show more',
              trimExpandedText: 'Show less',
            ),
          ),
          const SizedBox(
            height: 32.0,
          ),
          _buildListMenu(restaurant.menu!),
          const SizedBox(
            height: 32.0,
          ),
          if (restaurant.reviews != null)
            _buildListReview(restaurant.reviews!)
          else
            Container(),
          const SizedBox(
            height: 24,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return ItemDialogAddReview(
                        id: widget.restaurant.id,
                      );
                    });
              },
              child: Text(
                'Add Review',
                style: Theme.of(context)
                    .textTheme
                    .button
                    ?.copyWith(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }

  Widget _buildListCategories(List<Categories> categories) {
    return SizedBox(
      height: 25,
      child: ListView.builder(
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(left: index == 0 ? 16.0 : 8.0),
            child: ItemCategories(name: categories[index].name),
          );
        },
      ),
    );
  }

  Widget _buildListMenu(Menu menu) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Foods',
                style: Theme.of(context).textTheme.headline6,
              )
            ],
          ),
        ),
        SizedBox(
          height: (MediaQuery.of(context).size.height * 0.15),
          width: (MediaQuery.of(context).size.width * 0.94),
          child: ListView(
              scrollDirection: Axis.horizontal,
              children: menu.foods.map((foods) {
                return SizedBox(
                  width: 150,
                  height: 200,
                  child: Card(
                    elevation: 2,
                    child: Column(
                      children: [
                        Container(
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/food2.png'),
                                    fit: BoxFit.fitHeight)),
                            height: (MediaQuery.of(context).size.height * 0.1)),
                        Container(
                          alignment: Alignment.bottomCenter,
                          child: Text(foods.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyText2),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList()),
        ),
        const SizedBox(
          height: 18,
        ),
        Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Drinks',
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
        ),
        SizedBox(
          height: (MediaQuery.of(context).size.height * 0.15),
          width: (MediaQuery.of(context).size.width * 0.94),
          child: ListView(
              scrollDirection: Axis.horizontal,
              children: menu.drinks.map((drinks) {
                return SizedBox(
                  width: 150,
                  child: Card(
                    elevation: 2,
                    child: Column(
                      children: [
                        Container(
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/images/ice.png'),
                                    fit: BoxFit.fitHeight)),
                            height: (MediaQuery.of(context).size.height * 0.1)),
                        Container(
                          alignment: Alignment.bottomCenter,
                          child: Text(drinks.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyText2),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList()),
        ),
      ],
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, isScrolled) {
          return [
            _buildAppBar(
              actions: [],
            ),
          ];
        },
        body: Consumer<DetailRestaurantProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.state == ResultState.hasData) {
              return _buildBody(state.result.restaurants);
            } else if (state.state == ResultState.noData) {
              return Center(
                child: Text(
                  state.message,
                  style: Theme.of(context)
                      .textTheme
                      .overline
                      ?.copyWith(color: grey),
                ),
              );
            } else if (state.state == ResultState.error) {
              return Center(
                child: Text(
                  state.message,
                  style: Theme.of(context)
                      .textTheme
                      .overline
                      ?.copyWith(color: grey),
                ),
              );
            } else {
              return const Center(child: Text(''));
            }
          },
        ),
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          _buildAppBar(
            actions: [],
          ),
          SliverToBoxAdapter(
            child: Consumer<DetailRestaurantProvider>(
              builder: (context, state, _) {
                if (state.state == ResultState.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.state == ResultState.hasData) {
                  return Center(
                    child: _buildBody(state.result.restaurants),
                  );
                } else if (state.state == ResultState.noData) {
                  return Center(
                    child: Text(
                      state.message,
                      style: Theme.of(context)
                          .textTheme
                          .overline
                          ?.copyWith(color: grey),
                    ),
                  );
                } else if (state.state == ResultState.error) {
                  return Center(
                    child: Text(
                      state.message,
                      style: Theme.of(context)
                          .textTheme
                          .overline
                          ?.copyWith(color: grey),
                    ),
                  );
                } else {
                  return const Center(child: Text(''));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListReview(List<Review> reviews) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Reviews',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        if (reviews.isNotEmpty)
          SizedBox(
            height: 110,
            child: ListView.builder(
              itemCount: reviews.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: ItemReview(review: reviews[index]),
              ),
            ),
          )
        else
          const Text('No data')
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailRestaurantProvider>(
      create: (_) => DetailRestaurantProvider(
          apiService: ApiService(), id: widget.restaurant.id),
      child: PlatformWidget(
        androidBuilder: _buildAndroid,
        iosBuilder: _buildIos,
      ),
    );
  }
}
