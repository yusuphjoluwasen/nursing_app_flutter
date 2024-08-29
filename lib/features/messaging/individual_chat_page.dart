import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nursing_mother_medical_app/reusables/form/input_decoration.dart';
import 'package:provider/provider.dart';
import 'package:nursing_mother_medical_app/config/app_colors.dart';
import 'package:nursing_mother_medical_app/features/messaging/report_page.dart';
import 'package:nursing_mother_medical_app/provider/chat_provider.dart';

import '../../reusables/message_widget.dart';

class PrivateChatPage extends StatefulWidget {
  const PrivateChatPage({super.key, required this.pageTitle, required this.docId});

  final String pageTitle;
  final String docId;

  @override
  State<PrivateChatPage> createState() => _PrivateChatPageState();
}

class _PrivateChatPageState extends State<PrivateChatPage> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.pageTitle,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: AppColors.black),
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);  // Go back to the previous page
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),  // More icon
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReportPage(groupId: widget.docId),
                ),
              );
            },
          ),
        ],
        backgroundColor: AppColors.bgColor,
      ),
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: chatProvider.getPrivateChatStream(widget.docId, 'currentUserId', 20),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(child: Text('No messages available'));
                    }
                    final messages = snapshot.data!.docs;
                    return ListView.builder(
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        final isCurrentUser = message['idFrom'] == 'currentUserId';
                        final profileUrl = isCurrentUser ? 'currentUserProfileUrl' : 'otherUserProfileUrl';
                        return MessageWidget(
                          content: message['content'],
                          isCurrentUser: isCurrentUser,
                          profileUrl: profileUrl,
                        );
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: buildInputDecoration(hintText: "Type a message"),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        final text = _messageController.text.trim();
                        if (text.isNotEmpty) {
                          chatProvider.sendPrivateMessage(text, 'text', widget.docId, 'currentUserId');
                          _messageController.clear();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
