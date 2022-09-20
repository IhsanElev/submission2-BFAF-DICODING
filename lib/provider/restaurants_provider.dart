part of 'providers.dart';

class RestaurantsProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantsProvider({required this.apiService}) {
    _fetchRecommendationRestaurants();
  }

  late RestaurantsResult _restaurantsResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantsResult get result => _restaurantsResult;

  ResultState get state => _state;

  Future<dynamic> _fetchRecommendationRestaurants() async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final restaurant = await apiService.recommendationRestaurants();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Tidak ada data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantsResult = restaurant;
      }
    } on SocketException {
      _state = ResultState.error;
      notifyListeners();
      return _message =
          'Tidak ada koneksi internet, Silahkan hidupkan wifi atau data seluler lalu coba lagi';
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
