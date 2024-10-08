import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nursing_mother_medical_app/features/supportlibrary/support_library_list_item.dart';

import '../../config/app_colors.dart';
import '../../config/app_strings.dart';
import '../../reusables/data.dart';
import '../../reusables/form/app_button.dart';
import '../../reusables/form/input_decoration.dart';

class SupportLibraryPage extends StatefulWidget {
  const SupportLibraryPage({super.key});

  @override
  _SupportLibraryPageState createState() => _SupportLibraryPageState();
}

class _SupportLibraryPageState extends State<SupportLibraryPage> {
  List<Map<String, String>> _filteredSupportList = supportLibraryList;

  void _filterSupportList(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredSupportList = supportLibraryList;
      } else {
        _filteredSupportList = supportLibraryList
            .where((item) =>
            item['title']!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          AppStrings.supportLibrary,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: AppColors.black),
          textAlign: TextAlign.center,
        ),
        backgroundColor: AppColors.bgColor,
      ),
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Image(
                image: AssetImage('assets/images/dashboard_image.png'),
              ),
              const SizedBox(height: 25),
              TextFormField(
                decoration: buildInputDecoration(hintText: 'Search'),
                onChanged: _filterSupportList,
              ),
              const SizedBox(height: 15),
              Expanded(
                child: SupportLibraryList(
                  supportList: _filteredSupportList,
                  pageBuilder: (context, item) {
                    return SupportLibraryListItemPage(pageTitle:
                    item['title']!,  pageDetail: item['details']!);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SupportLibraryList extends StatelessWidget {
  const SupportLibraryList({
    super.key,
    required this.supportList,
    required this.pageBuilder,
  });

  final List<Map<String, String>> supportList;
  final Widget Function(BuildContext context, Map<String, String> item) pageBuilder;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: supportList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => pageBuilder(context, supportList[index]),
              ),
            );
          },
          child: CardItem(cardItem: supportList[index]),
        );
      },
    );
  }
}

class CardItem extends StatelessWidget {
  CardItem({
    super.key,
    required this.cardItem,
  });

  Map<String, String> cardItem;

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.white,
      color: Colors.white,
      elevation: 0.2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Image.asset(
              cardItem['image']!,
              width: 44,  // Set to a more appropriate size
              height: 44, // Set to a more appropriate size
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                cardItem['title']!,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
