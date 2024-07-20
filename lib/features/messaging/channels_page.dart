import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nursing_mother_medical_app/config/app_colors.dart';
import 'package:nursing_mother_medical_app/config/app_strings.dart';
import 'package:nursing_mother_medical_app/features/supportlibrary/support_library.dart';
import 'package:nursing_mother_medical_app/reusables/form/input_decoration.dart';
import 'package:provider/provider.dart';
import '../../provider/providers.dart';
import 'group_chat_page.dart';

class MessagingPage extends StatelessWidget {
  const MessagingPage({super.key});

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
                    final channels = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: channels.length,
                      itemBuilder: (context, index) {
                        final channel = channels[index];
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
                                  child: CardItem(cardItem: {'title':  channel['title'], 'image': "assets/images/messaging_item_icon.png"}),
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
