import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nursing_mother_medical_app/config/app_colors.dart';
import 'package:nursing_mother_medical_app/config/app_strings.dart';
import 'package:nursing_mother_medical_app/features/supportlibrary/support_library.dart';
import 'package:nursing_mother_medical_app/reusables/form/input_decoration.dart';
import 'package:provider/provider.dart';
import '../../provider/providers.dart';
import 'group_chat_page.dart';

class MessagingPage extends StatefulWidget {
  const MessagingPage({super.key});

  @override
  State<MessagingPage> createState() => _MessagingPageState();
}

class _MessagingPageState extends State<MessagingPage> {
  List<QueryDocumentSnapshot> _allChannels = [];
  List<QueryDocumentSnapshot> _filteredChannels = [];
  bool _isLoading = true;

  void _filterChannels(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredChannels = _allChannels;
      } else {
        _filteredChannels = _allChannels
            .where((channel) =>
            (channel['title'] ?? '').toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          AppStrings.messaging,
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
                image: AssetImage('assets/images/messaging.png'),
              ),
              const SizedBox(height: 25),
              TextFormField(
                decoration: buildInputDecoration(hintText: 'Search'),
                onChanged: _filterChannels,
              ),
              const SizedBox(height: 15),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: chatProvider.getChannelListStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text('No channels available'));
                    }
                    _allChannels = snapshot.data!.docs;
                    _filteredChannels = _filteredChannels.isEmpty
                        ? _allChannels
                        : _filteredChannels;
                    return ListView.builder(
                      itemCount: _filteredChannels.length,
                      itemBuilder: (context, index) {
                        final channel = _filteredChannels[index];
                        final docId = channel.id;
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GroupChatPage(
                                  pageTitle: channel['title'] ?? 'No Name',
                                  docId: docId,
                                ),
                              ),
                            );
                          },
                          child: CardItem(cardItem: {
                            'title': channel['title'] ?? 'No Name',
                            'image': "assets/images/messaging_item_icon.png"
                          }),
                        );
                      },
                    );
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
