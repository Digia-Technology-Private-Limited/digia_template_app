import 'dart:js';
import 'package:bytes/util/platform_impl/base_util.dart';

class PlatformUtilImpl extends BaseUtil {
  @override
  String getProjectId() {
    return context['projectId'];
  }
}
