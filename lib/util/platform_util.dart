import 'package:digia_template_app/util/platform_impl/stub_util.dart'
    if (dart.library.io) 'platform_impl/mobile_util.dart'
    if (dart.library.html) 'platform_impl/web_util.dart';


class PlatformUtil {
  static final PlatformUtil _singleton = PlatformUtil._internal();
  final PlatformUtilImpl _platformUtilImpl = PlatformUtilImpl();
  factory PlatformUtil() {
    return _singleton;
  }

  PlatformUtil._internal();

  String getProjectId() {
    return _platformUtilImpl.getProjectId();
  }
}