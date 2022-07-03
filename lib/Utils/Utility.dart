// import 'dart:convert';
// import '../models/Media.dart';
// import '../models/LiveStreams.dart';
// import 'package:intl/intl.dart';
//
// class Utility {
//   static String getBase64EncodedString(String text) {
//     Codec<String, String> stringToBase64 = utf8.fuse(base64);
//     return stringToBase64.encode(text.trim());
//   }
//
//   static String getBase64DecodedString(String text) {
//     //print(text);
//     Codec<String, String> stringToBase64 = utf8.fuse(base64);
//     return stringToBase64.decode(text.trim());
//   }
//
//   static List<Media> extractMediaByType(List<Media> mediaList, String type) {
//     List<Media> newList = [];
//     for (Media item in mediaList) {
//       if (item.mediaType == type) {
//         newList.add(item);
//       }
//     }
//     return newList;
//   }
//
//   static List<Media> removeCurrentMediaFromList(
//       List<Media> mediaList, Media media) {
//     List<Media> playlist = [];
//     for (Media item in mediaList) {
//       if (item.id != media.id) {
//         playlist.add(item);
//       }
//     }
//     return playlist;
//   }
//
//   static List<LiveStreams> removeCurrentLiveStreamsFromList(
//       List<LiveStreams> mediaList, LiveStreams media) {
//     List<LiveStreams> playlist = [];
//     for (LiveStreams item in mediaList) {
//       if (item.id != media.id) {
//         playlist.add(item);
//       }
//     }
//     return playlist;
//   }
//
//   static bool isPreviewDuration(
//       Media media, int currentDuration, bool isUserSubscribed) {
//     if (isUserSubscribed) return false;
//     if (media.isFree) return false;
//     if (currentDuration >= media.previewDuration) {
//       return true;
//     }
//     return false;
//   }
//
//   static bool isMediaRequireUserSubscription(
//       Media media, bool isUserSubscribed) {
//     if (isUserSubscribed) return false;
//     if (!media.isFree && media.previewDuration == 0) {
//       return true;
//     }
//     return false;
//   }
//
//   static String formatNumber(int number) {
//     if (number == 0) return "";
//     return NumberFormat.compact().format(number);
//   }
// }
