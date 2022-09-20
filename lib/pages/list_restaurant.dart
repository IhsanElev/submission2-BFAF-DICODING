part of 'pages.dart';

class ListRestaurantScreen extends StatefulWidget {
  const ListRestaurantScreen({Key? key}) : super(key: key);

  @override
  State<ListRestaurantScreen> createState() => _ListRestaurantScreenState();
}

class _ListRestaurantScreenState extends State<ListRestaurantScreen> {
  Widget _titleAppBar(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            'Restaurant APP',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }

  Widget _buildList(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 12,
            ),
            Hero(
              tag: SearchScreen.routeName,
              child: SearchTextField(
                readOnly: true,
                autoFocus: false,
                onTap: () =>
                    Navigator.pushNamed(context, SearchScreen.routeName),
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            Text(
              'Restaurant',
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              'Recomendation restaurant for you',
              style:
                  Theme.of(context).textTheme.bodyText2?.copyWith(color: grey),
            ),
            const SizedBox(
              height: 14,
            ),
            Expanded(
              child: Consumer<RestaurantsProvider>(
                builder: (context, state, _) {
                  if (state.state == ResultState.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.state == ResultState.hasData) {
                    return ListView.builder(
                      itemCount: state.result.restaurants.length,
                      itemBuilder: (context, index) {
                        return ItemRestaurant(
                            restaurant: state.result.restaurants[index]);
                      },
                    );
                  } else if (state.state == ResultState.noData) {
                    return Center(
                               child: Text(state.message, style: Theme.of(context).textTheme.overline?.copyWith(color: grey),),
                    );
                  } else if (state.state == ResultState.error) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(state.message, style: Theme.of(context).textTheme.overline?.copyWith(color: grey),),
                    );
                  } else {
                    return const Center(child: Text(''));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: _titleAppBar(context),
      body: _buildList(context),
    );
  }
}
