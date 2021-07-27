// Copyright 2021 Leptopoda. All rights reserved.
// Use of this source code is governed by an APACHE-style license that can be
// found in the LICENSE file.

part of 'package:bierverkostung/screens/beertasting/tasting_data.dart';

/// This class converts EBC values to approximately resembling RGB colour values.
///
/// The values as well as the conversion algorithm are taken from the original project who took it from:
/// <a href="https://github.com/Gremmel/kleiner-brauhelfer/blob/22c95099d6302f3319a1e9799f1e2199f3547895/source/src/berechnungen.cpp#L968">Kleiner Brauhelfer</a>.
@immutable
class EbcColor {
  const EbcColor._();

  /// An EBC value above this threshold is such dark that it requires a bright text colour to gain enough contrast.
  @Deprecated('This is a currently unused parameter in the app')
  static const double darkEbcValueThreshold = 30.0;

  static const List<Color> _srmRgbColors = [
    Color.fromRGBO(250, 250, 210, 1),
    Color.fromRGBO(250, 250, 204, 1),
    Color.fromRGBO(250, 250, 199, 1),
    Color.fromRGBO(250, 250, 193, 1),
    Color.fromRGBO(250, 250, 188, 1),
    Color.fromRGBO(250, 250, 182, 1),
    Color.fromRGBO(250, 250, 177, 1),
    Color.fromRGBO(250, 250, 171, 1),
    Color.fromRGBO(250, 250, 166, 1),
    Color.fromRGBO(250, 250, 160, 1),
    Color.fromRGBO(250, 250, 155, 1),
    Color.fromRGBO(250, 250, 149, 1),
    Color.fromRGBO(250, 250, 144, 1),
    Color.fromRGBO(250, 250, 138, 1),
    Color.fromRGBO(250, 250, 133, 1),
    Color.fromRGBO(250, 250, 127, 1),
    Color.fromRGBO(250, 250, 122, 1),
    Color.fromRGBO(250, 250, 116, 1),
    Color.fromRGBO(250, 250, 111, 1),
    Color.fromRGBO(250, 250, 105, 1),
    Color.fromRGBO(250, 250, 100, 1),
    Color.fromRGBO(250, 250, 94, 1),
    Color.fromRGBO(250, 250, 89, 1),
    Color.fromRGBO(250, 250, 83, 1),
    Color.fromRGBO(250, 250, 78, 1),
    Color.fromRGBO(249, 250, 72, 1),
    Color.fromRGBO(248, 249, 67, 1),
    Color.fromRGBO(247, 248, 61, 1),
    Color.fromRGBO(246, 247, 56, 1),
    Color.fromRGBO(245, 246, 50, 1),
    Color.fromRGBO(244, 245, 45, 1),
    Color.fromRGBO(243, 244, 45, 1),
    Color.fromRGBO(242, 242, 45, 1),
    Color.fromRGBO(241, 240, 46, 1),
    Color.fromRGBO(240, 238, 46, 1),
    Color.fromRGBO(239, 236, 46, 1),
    Color.fromRGBO(238, 234, 46, 1),
    Color.fromRGBO(237, 232, 47, 1),
    Color.fromRGBO(236, 230, 47, 1),
    Color.fromRGBO(235, 228, 47, 1),
    Color.fromRGBO(234, 226, 47, 1),
    Color.fromRGBO(233, 224, 48, 1),
    Color.fromRGBO(232, 222, 48, 1),
    Color.fromRGBO(231, 220, 48, 1),
    Color.fromRGBO(230, 218, 48, 1),
    Color.fromRGBO(229, 216, 49, 1),
    Color.fromRGBO(228, 214, 49, 1),
    Color.fromRGBO(227, 212, 49, 1),
    Color.fromRGBO(226, 210, 49, 1),
    Color.fromRGBO(225, 208, 50, 1),
    Color.fromRGBO(224, 206, 50, 1),
    Color.fromRGBO(223, 204, 50, 1),
    Color.fromRGBO(222, 202, 50, 1),
    Color.fromRGBO(221, 200, 51, 1),
    Color.fromRGBO(220, 198, 51, 1),
    Color.fromRGBO(219, 196, 51, 1),
    Color.fromRGBO(218, 194, 51, 1),
    Color.fromRGBO(217, 192, 52, 1),
    Color.fromRGBO(216, 190, 52, 1),
    Color.fromRGBO(215, 188, 52, 1),
    Color.fromRGBO(214, 186, 52, 1),
    Color.fromRGBO(213, 184, 53, 1),
    Color.fromRGBO(212, 182, 53, 1),
    Color.fromRGBO(211, 180, 53, 1),
    Color.fromRGBO(210, 178, 53, 1),
    Color.fromRGBO(209, 176, 54, 1),
    Color.fromRGBO(208, 174, 54, 1),
    Color.fromRGBO(207, 172, 54, 1),
    Color.fromRGBO(206, 170, 54, 1),
    Color.fromRGBO(205, 168, 55, 1),
    Color.fromRGBO(204, 166, 55, 1),
    Color.fromRGBO(203, 164, 55, 1),
    Color.fromRGBO(202, 162, 55, 1),
    Color.fromRGBO(201, 160, 56, 1),
    Color.fromRGBO(200, 158, 56, 1),
    Color.fromRGBO(200, 156, 56, 1),
    Color.fromRGBO(199, 154, 56, 1),
    Color.fromRGBO(199, 152, 56, 1),
    Color.fromRGBO(198, 150, 56, 1),
    Color.fromRGBO(198, 148, 56, 1),
    Color.fromRGBO(197, 146, 56, 1),
    Color.fromRGBO(197, 144, 56, 1),
    Color.fromRGBO(196, 142, 56, 1),
    Color.fromRGBO(196, 141, 56, 1),
    Color.fromRGBO(195, 140, 56, 1),
    Color.fromRGBO(195, 139, 56, 1),
    Color.fromRGBO(194, 139, 56, 1),
    Color.fromRGBO(194, 138, 56, 1),
    Color.fromRGBO(193, 137, 56, 1),
    Color.fromRGBO(193, 136, 56, 1),
    Color.fromRGBO(192, 136, 56, 1),
    Color.fromRGBO(192, 135, 56, 1),
    Color.fromRGBO(192, 134, 56, 1),
    Color.fromRGBO(192, 133, 56, 1),
    Color.fromRGBO(192, 133, 56, 1),
    Color.fromRGBO(192, 132, 56, 1),
    Color.fromRGBO(192, 131, 56, 1),
    Color.fromRGBO(192, 130, 56, 1),
    Color.fromRGBO(192, 130, 56, 1),
    Color.fromRGBO(192, 129, 56, 1),
    Color.fromRGBO(192, 128, 56, 1),
    Color.fromRGBO(192, 127, 56, 1),
    Color.fromRGBO(192, 127, 56, 1),
    Color.fromRGBO(192, 126, 56, 1),
    Color.fromRGBO(192, 125, 56, 1),
    Color.fromRGBO(192, 124, 56, 1),
    Color.fromRGBO(192, 124, 56, 1),
    Color.fromRGBO(192, 123, 56, 1),
    Color.fromRGBO(192, 122, 56, 1),
    Color.fromRGBO(192, 121, 56, 1),
    Color.fromRGBO(192, 121, 56, 1),
    Color.fromRGBO(192, 120, 56, 1),
    Color.fromRGBO(192, 119, 56, 1),
    Color.fromRGBO(192, 118, 56, 1),
    Color.fromRGBO(192, 118, 56, 1),
    Color.fromRGBO(192, 117, 56, 1),
    Color.fromRGBO(192, 116, 56, 1),
    Color.fromRGBO(192, 115, 56, 1),
    Color.fromRGBO(192, 115, 56, 1),
    Color.fromRGBO(192, 114, 56, 1),
    Color.fromRGBO(192, 113, 56, 1),
    Color.fromRGBO(192, 112, 56, 1),
    Color.fromRGBO(192, 112, 56, 1),
    Color.fromRGBO(192, 111, 56, 1),
    Color.fromRGBO(192, 110, 56, 1),
    Color.fromRGBO(192, 109, 56, 1),
    Color.fromRGBO(192, 109, 56, 1),
    Color.fromRGBO(192, 108, 56, 1),
    Color.fromRGBO(191, 107, 56, 1),
    Color.fromRGBO(190, 106, 56, 1),
    Color.fromRGBO(189, 106, 56, 1),
    Color.fromRGBO(188, 105, 56, 1),
    Color.fromRGBO(187, 104, 56, 1),
    Color.fromRGBO(186, 103, 56, 1),
    Color.fromRGBO(185, 103, 56, 1),
    Color.fromRGBO(184, 102, 56, 1),
    Color.fromRGBO(183, 101, 56, 1),
    Color.fromRGBO(182, 100, 56, 1),
    Color.fromRGBO(181, 100, 56, 1),
    Color.fromRGBO(180, 99, 56, 1),
    Color.fromRGBO(179, 98, 56, 1),
    Color.fromRGBO(178, 97, 56, 1),
    Color.fromRGBO(177, 97, 56, 1),
    Color.fromRGBO(175, 96, 55, 1),
    Color.fromRGBO(174, 95, 55, 1),
    Color.fromRGBO(172, 94, 55, 1),
    Color.fromRGBO(171, 94, 55, 1),
    Color.fromRGBO(169, 93, 54, 1),
    Color.fromRGBO(168, 92, 54, 1),
    Color.fromRGBO(167, 91, 54, 1),
    Color.fromRGBO(165, 91, 54, 1),
    Color.fromRGBO(164, 90, 53, 1),
    Color.fromRGBO(162, 89, 53, 1),
    Color.fromRGBO(161, 88, 53, 1),
    Color.fromRGBO(159, 88, 53, 1),
    Color.fromRGBO(158, 87, 52, 1),
    Color.fromRGBO(157, 86, 52, 1),
    Color.fromRGBO(155, 85, 52, 1),
    Color.fromRGBO(154, 85, 52, 1),
    Color.fromRGBO(152, 84, 51, 1),
    Color.fromRGBO(151, 83, 51, 1),
    Color.fromRGBO(149, 82, 51, 1),
    Color.fromRGBO(148, 82, 51, 1),
    Color.fromRGBO(147, 81, 50, 1),
    Color.fromRGBO(145, 80, 50, 1),
    Color.fromRGBO(144, 79, 50, 1),
    Color.fromRGBO(142, 78, 50, 1),
    Color.fromRGBO(141, 77, 49, 1),
    Color.fromRGBO(139, 76, 49, 1),
    Color.fromRGBO(138, 75, 48, 1),
    Color.fromRGBO(137, 75, 47, 1),
    Color.fromRGBO(135, 74, 47, 1),
    Color.fromRGBO(134, 73, 46, 1),
    Color.fromRGBO(132, 72, 45, 1),
    Color.fromRGBO(131, 72, 45, 1),
    Color.fromRGBO(129, 71, 44, 1),
    Color.fromRGBO(128, 70, 43, 1),
    Color.fromRGBO(127, 69, 43, 1),
    Color.fromRGBO(125, 69, 42, 1),
    Color.fromRGBO(124, 68, 41, 1),
    Color.fromRGBO(122, 67, 41, 1),
    Color.fromRGBO(121, 66, 40, 1),
    Color.fromRGBO(119, 66, 39, 1),
    Color.fromRGBO(118, 65, 39, 1),
    Color.fromRGBO(117, 64, 38, 1),
    Color.fromRGBO(115, 63, 37, 1),
    Color.fromRGBO(114, 63, 37, 1),
    Color.fromRGBO(112, 62, 36, 1),
    Color.fromRGBO(111, 61, 35, 1),
    Color.fromRGBO(109, 60, 34, 1),
    Color.fromRGBO(108, 60, 33, 1),
    Color.fromRGBO(107, 59, 32, 1),
    Color.fromRGBO(105, 58, 31, 1),
    Color.fromRGBO(104, 57, 29, 1),
    Color.fromRGBO(102, 57, 28, 1),
    Color.fromRGBO(101, 56, 27, 1),
    Color.fromRGBO(99, 55, 26, 1),
    Color.fromRGBO(98, 54, 25, 1),
    Color.fromRGBO(97, 54, 24, 1),
    Color.fromRGBO(95, 53, 23, 1),
    Color.fromRGBO(94, 52, 21, 1),
    Color.fromRGBO(92, 51, 20, 1),
    Color.fromRGBO(91, 51, 19, 1),
    Color.fromRGBO(89, 50, 18, 1),
    Color.fromRGBO(88, 49, 17, 1),
    Color.fromRGBO(87, 48, 16, 1),
    Color.fromRGBO(85, 48, 15, 1),
    Color.fromRGBO(84, 47, 13, 1),
    Color.fromRGBO(82, 46, 12, 1),
    Color.fromRGBO(81, 45, 11, 1),
    Color.fromRGBO(79, 45, 10, 1),
    Color.fromRGBO(78, 44, 9, 1),
    Color.fromRGBO(77, 43, 8, 1),
    Color.fromRGBO(75, 42, 9, 1),
    Color.fromRGBO(74, 42, 9, 1),
    Color.fromRGBO(72, 41, 10, 1),
    Color.fromRGBO(71, 40, 10, 1),
    Color.fromRGBO(69, 39, 11, 1),
    Color.fromRGBO(68, 39, 11, 1),
    Color.fromRGBO(67, 38, 12, 1),
    Color.fromRGBO(65, 37, 12, 1),
    Color.fromRGBO(64, 36, 13, 1),
    Color.fromRGBO(62, 36, 13, 1),
    Color.fromRGBO(61, 35, 14, 1),
    Color.fromRGBO(59, 34, 14, 1),
    Color.fromRGBO(58, 33, 15, 1),
    Color.fromRGBO(57, 33, 15, 1),
    Color.fromRGBO(55, 32, 16, 1),
    Color.fromRGBO(54, 31, 16, 1),
    Color.fromRGBO(52, 30, 17, 1),
    Color.fromRGBO(51, 30, 17, 1),
    Color.fromRGBO(49, 29, 18, 1),
    Color.fromRGBO(48, 28, 18, 1),
    Color.fromRGBO(47, 27, 19, 1),
    Color.fromRGBO(45, 27, 19, 1),
    Color.fromRGBO(44, 26, 20, 1),
    Color.fromRGBO(42, 25, 20, 1),
    Color.fromRGBO(41, 24, 21, 1),
    Color.fromRGBO(39, 24, 21, 1),
    Color.fromRGBO(38, 23, 22, 1),
    Color.fromRGBO(37, 22, 21, 1),
    Color.fromRGBO(37, 22, 21, 1),
    Color.fromRGBO(36, 22, 21, 1),
    Color.fromRGBO(36, 21, 20, 1),
    Color.fromRGBO(35, 21, 20, 1),
    Color.fromRGBO(35, 21, 20, 1),
    Color.fromRGBO(34, 20, 19, 1),
    Color.fromRGBO(34, 20, 19, 1),
    Color.fromRGBO(33, 20, 19, 1),
    Color.fromRGBO(33, 19, 18, 1),
    Color.fromRGBO(32, 19, 18, 1),
    Color.fromRGBO(32, 19, 18, 1),
    Color.fromRGBO(31, 18, 17, 1),
    Color.fromRGBO(31, 18, 17, 1),
    Color.fromRGBO(30, 18, 17, 1),
    Color.fromRGBO(30, 17, 16, 1),
    Color.fromRGBO(29, 17, 16, 1),
    Color.fromRGBO(29, 17, 16, 1),
    Color.fromRGBO(28, 16, 15, 1),
    Color.fromRGBO(28, 16, 15, 1),
    Color.fromRGBO(27, 16, 15, 1),
    Color.fromRGBO(27, 15, 14, 1),
    Color.fromRGBO(26, 15, 14, 1),
    Color.fromRGBO(26, 15, 14, 1),
    Color.fromRGBO(25, 14, 13, 1),
    Color.fromRGBO(25, 14, 13, 1),
    Color.fromRGBO(24, 14, 13, 1),
    Color.fromRGBO(24, 13, 12, 1),
    Color.fromRGBO(23, 13, 12, 1),
    Color.fromRGBO(23, 13, 12, 1),
    Color.fromRGBO(22, 12, 11, 1),
    Color.fromRGBO(22, 12, 11, 1),
    Color.fromRGBO(21, 12, 11, 1),
    Color.fromRGBO(21, 11, 10, 1),
    Color.fromRGBO(20, 11, 10, 1),
    Color.fromRGBO(20, 11, 10, 1),
    Color.fromRGBO(19, 10, 9, 1),
    Color.fromRGBO(19, 10, 9, 1),
    Color.fromRGBO(18, 10, 9, 1),
    Color.fromRGBO(18, 9, 8, 1),
    Color.fromRGBO(17, 9, 8, 1),
    Color.fromRGBO(17, 9, 8, 1),
    Color.fromRGBO(16, 8, 7, 1),
    Color.fromRGBO(16, 8, 7, 1),
    Color.fromRGBO(15, 8, 7, 1),
    Color.fromRGBO(15, 7, 6, 1),
    Color.fromRGBO(14, 7, 6, 1),
    Color.fromRGBO(14, 7, 6, 1),
    Color.fromRGBO(13, 6, 5, 1),
    Color.fromRGBO(13, 6, 5, 1),
    Color.fromRGBO(12, 6, 5, 1),
    Color.fromRGBO(12, 5, 4, 1),
    Color.fromRGBO(11, 5, 4, 1),
    Color.fromRGBO(11, 5, 4, 1),
    Color.fromRGBO(10, 4, 3, 1),
    Color.fromRGBO(10, 4, 3, 1),
    Color.fromRGBO(9, 4, 3, 1),
    Color.fromRGBO(9, 3, 2, 1),
    Color.fromRGBO(8, 3, 2, 1),
    Color.fromRGBO(8, 3, 2, 1),
  ];

  /// converts the given [ebcValue] into an [Color], returns transparent when the input is null
  static Color toColor(final num? ebcValue) {
    if (ebcValue != null) {
      final double _srmValue = ebcValue / 1.97;
      int _index = (_srmValue * 10).round();
      if (_srmRgbColors.length < _index) {
        _index = _srmRgbColors.length;
      }

      return _srmRgbColors[_index - 1];
    }
    return const Color.fromRGBO(0, 0, 0, 0);
  }
}
