/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/Poppins-Bold.ttf
  String get poppinsBold => 'assets/fonts/Poppins-Bold.ttf';

  /// File path: assets/fonts/Poppins-Light.ttf
  String get poppinsLight => 'assets/fonts/Poppins-Light.ttf';

  /// File path: assets/fonts/Poppins-Regular.ttf
  String get poppinsRegular => 'assets/fonts/Poppins-Regular.ttf';

  /// File path: assets/fonts/dsdigi.ttf
  String get dsdigi => 'assets/fonts/dsdigi.ttf';

  /// File path: assets/fonts/isepMisbah.ttf
  String get isepMisbah => 'assets/fonts/isepMisbah.ttf';

  /// List of all assets
  List<String> get values => [poppinsBold, poppinsLight, poppinsRegular, dsdigi, isepMisbah];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/al-quran.svg
  SvgGenImage get alQuran => const SvgGenImage('assets/icons/al-quran.svg');

  /// File path: assets/icons/ashar.svg
  SvgGenImage get ashar => const SvgGenImage('assets/icons/ashar.svg');

  /// File path: assets/icons/basmalah.svg
  SvgGenImage get basmalah => const SvgGenImage('assets/icons/basmalah.svg');

  /// File path: assets/icons/bg-pattern.svg
  SvgGenImage get bgPattern => const SvgGenImage('assets/icons/bg-pattern.svg');

  /// File path: assets/icons/compass-full.svg
  SvgGenImage get compassFull => const SvgGenImage('assets/icons/compass-full.svg');

  /// File path: assets/icons/compass.png
  AssetGenImage get compassPng => const AssetGenImage('assets/icons/compass.png');

  /// File path: assets/icons/compass.svg
  SvgGenImage get compassSvg => const SvgGenImage('assets/icons/compass.svg');

  /// File path: assets/icons/dzuhur.svg
  SvgGenImage get dzuhur => const SvgGenImage('assets/icons/dzuhur.svg');

  /// File path: assets/icons/isya.svg
  SvgGenImage get isya => const SvgGenImage('assets/icons/isya.svg');

  /// File path: assets/icons/last_read.svg
  SvgGenImage get lastRead => const SvgGenImage('assets/icons/last_read.svg');

  /// File path: assets/icons/maghrib.svg
  SvgGenImage get maghrib => const SvgGenImage('assets/icons/maghrib.svg');

  /// File path: assets/icons/mecca.svg
  SvgGenImage get mecca => const SvgGenImage('assets/icons/mecca.svg');

  /// File path: assets/icons/medina.svg
  SvgGenImage get medina => const SvgGenImage('assets/icons/medina.svg');

  /// File path: assets/icons/mosque.jpg
  AssetGenImage get mosque => const AssetGenImage('assets/icons/mosque.jpg');

  /// File path: assets/icons/needle.svg
  SvgGenImage get needle => const SvgGenImage('assets/icons/needle.svg');

  /// File path: assets/icons/pattern.svg
  SvgGenImage get pattern => const SvgGenImage('assets/icons/pattern.svg');

  /// File path: assets/icons/praying-hands.svg
  SvgGenImage get prayingHands => const SvgGenImage('assets/icons/praying-hands.svg');

  /// File path: assets/icons/rubhizb.svg
  SvgGenImage get rubhizb => const SvgGenImage('assets/icons/rubhizb.svg');

  /// File path: assets/icons/setting.png
  AssetGenImage get setting => const AssetGenImage('assets/icons/setting.png');

  /// File path: assets/icons/shalat.png
  AssetGenImage get shalatPng => const AssetGenImage('assets/icons/shalat.png');

  /// File path: assets/icons/shalat.svg
  SvgGenImage get shalatSvg => const SvgGenImage('assets/icons/shalat.svg');

  /// File path: assets/icons/subuh.svg
  SvgGenImage get subuh => const SvgGenImage('assets/icons/subuh.svg');

  /// File path: assets/icons/sunrise.svg
  SvgGenImage get sunrise => const SvgGenImage('assets/icons/sunrise.svg');

  /// File path: assets/icons/tasbih.svg
  SvgGenImage get tasbih => const SvgGenImage('assets/icons/tasbih.svg');

  /// List of all assets
  List<dynamic> get values => [
        alQuran,
        ashar,
        basmalah,
        bgPattern,
        compassFull,
        compassPng,
        compassSvg,
        dzuhur,
        isya,
        lastRead,
        maghrib,
        mecca,
        medina,
        mosque,
        needle,
        pattern,
        prayingHands,
        rubhizb,
        setting,
        shalatPng,
        shalatSvg,
        subuh,
        sunrise,
        tasbih
      ];
}

class $AssetsSourcesGen {
  const $AssetsSourcesGen();

  /// File path: assets/sources/al-quran-indopak.db
  String get alQuranIndopakDb => 'assets/sources/al-quran-indopak.db';

  /// File path: assets/sources/al-quran-indopak.sqbpro
  String get alQuranIndopakSqbpro => 'assets/sources/al-quran-indopak.sqbpro';

  /// File path: assets/sources/doa.json
  String get doa => 'assets/sources/doa.json';

  /// File path: assets/sources/surah.json
  String get surah => 'assets/sources/surah.json';

  /// List of all assets
  List<String> get values => [alQuranIndopakDb, alQuranIndopakSqbpro, doa, surah];
}

class Assets {
  Assets._();

  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsSourcesGen sources = $AssetsSourcesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme theme = const SvgTheme(),
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      theme: theme,
      colorFilter: colorFilter,
      color: color,
      colorBlendMode: colorBlendMode,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
