import 'package:flutter/material.dart';
import '../config/app_colors.dart';

class MessageWidget extends StatelessWidget {
  final String content;
  final bool isCurrentUser;
  final String profileUrl;

  const MessageWidget({
    super.key,
    required this.content,
    required this.isCurrentUser,
    required this.profileUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
      isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isCurrentUser)
          CircleAvatar(
            backgroundImage: NetworkImage(profileUrl),
            radius: 15,
          ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isCurrentUser ? AppColors.primary : AppColors.greyTextColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            content,
            style: TextStyle(
              color: isCurrentUser ? Colors.white : Colors.black,
            ),
          ),
        ),
        if (isCurrentUser)
          CircleAvatar(
            radius: 15,
            child: ClipOval(
              child: Image.network(
                profileUrl,
                fit: BoxFit.cover,
                width: 30,
                height: 30,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/nurse.png',
                    fit: BoxFit.cover,
                    width: 30,
                    height: 30,
                  );
                },
              ),
            ),
          )
      ],
    );
  }
}
