import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:livestreamingapp/models/livestream.dart';
import 'package:livestreamingapp/providers/user_provider.dart';
import 'package:livestreamingapp/utils/utils.dart';
import 'package:provider/provider.dart';

import 'storage_methods.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StorageMethods _storageMethods = StorageMethods();

  Future<String> startLiveStream(
      BuildContext context, String title, Uint8List? image) async {
    final user = Provider.of<UserProvider>(context, listen: false);
    String channelId = '';
    try {
      if (title.isNotEmpty && image != null) {
        if (!((await _firestore
                .collection("LiveStream")
                .doc('${user.user.uid}${user.user.username}')
                .get())
            .exists)) {
          String thumbnailUrl = await _storageMethods.uploadImageToStorage(
            "LiveStream-thumbnails",
            image,
            user.user.uid,
          );
          String channelId = '${user.user.uid}${user.user.username}';
          LiveStream liveStream = LiveStream(
            title: title,
            image: thumbnailUrl,
            uid: user.user.uid,
            username: user.user.username,
            startedAt: DateTime.now(),
            channelId: channelId,
            viewers: 0,
          );
          _firestore
              .collection('LiveStream')
              .doc(channelId)
              .set(liveStream.toMap());
        } else {
          showSnackBar(context, "Two LiveStream not start at a same Time");
        }
      } else {
        showSnackBar(context, "Please enter all the fields");
      }
    } on FirebaseException catch (e) {
      showSnackBar(context, e.message!);
    }
    return channelId;
  }
}
