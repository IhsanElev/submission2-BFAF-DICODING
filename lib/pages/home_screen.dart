part of 'pages.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Widget _buildAndroid(BuildContext context) {
    return const Scaffold(
      body: ListRestaurantScreen(),
    );
  }

  Widget _buildIos(BuildContext context) {
    return const CupertinoPageScaffold(
      child: ListRestaurantScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
