part of 'widgets.dart';

class ItemDialogAddReview extends StatefulWidget {
  final String id;
  const ItemDialogAddReview({super.key, required this.id});

  @override
  State<ItemDialogAddReview> createState() => _ItemDialogAddReviewState();
}

class _ItemDialogAddReviewState extends State<ItemDialogAddReview> {
final nameController = TextEditingController();
  final reviewController = TextEditingController();

  final String title = "Add Review";
  final String nameHint = 'Type name here';
  final String reviewHint = 'Type review here';

  Future<void> _onPressYes(BuildContext context) async {
    var errorResponse =
        await Provider.of<DetailRestaurantProvider>(context, listen: false)
            .postReview(
      widget.id,
      nameController.text,
      reviewController.text,
    );
    Get.back();
    if (errorResponse != null) {
      showDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text(errorResponse),
              actions: [
                CupertinoDialogAction(
                  child: Text(
                    'Ok',
                    style: Theme.of(context).textTheme.button,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ],
            );
          });
    } else {
      Get.back();
    }
  }

  void _onPressNo() {
    Get.back();
  }

  Widget _buildAndroid(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Wrap(
        runSpacing: 12.0,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: lightGrey,
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextField(
              controller: nameController,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                hintText: nameHint,
                hintStyle: const TextStyle(color: grey),
              ),
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: lightGrey,
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextField(
              controller: reviewController,
              textAlignVertical: TextAlignVertical.top,
              maxLines: 4,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                hintText: reviewHint,
                hintStyle: const TextStyle(color: grey),
              ),
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text(
            'Yes',
            style: Theme.of(context).textTheme.button,
          ),
          onPressed: () {
            _onPressYes(context);
          },
        ),
        TextButton(
          onPressed: _onPressNo,
          child: Text(
            'No',
            style: Theme.of(context).textTheme.button,
          ),
        ),
      ],
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Column(
        children: [
          const SizedBox(height: 16),
          CupertinoTextField(
            controller: nameController,
            placeholder: nameHint,
            textAlignVertical: TextAlignVertical.center,
            maxLines: 1,
            placeholderStyle: const TextStyle(color: grey),
          ),
          const SizedBox(height: 12),
          CupertinoTextField(
            controller: reviewController,
            placeholder: reviewHint,
            textAlignVertical: TextAlignVertical.top,
            maxLines: 4,
            placeholderStyle: const TextStyle(color: grey),
          ),
        ],
      ),
      actions: [
        CupertinoDialogAction(
          child: const Text('Yes'),
          onPressed: () {
            _onPressYes(context);
          },
        ),
        CupertinoDialogAction(
          onPressed: _onPressNo,
          child: const Text('No'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailRestaurantProvider>(
      create: (context) =>
          DetailRestaurantProvider(apiService: ApiService(), id: widget.id),
      child: PlatformWidget(
        androidBuilder: _buildAndroid,
        iosBuilder: _buildIos,
      ),
    );
  }
}