import 'package:flutter/widgets.dart';
import 'package:mit_x/mit_x.dart';

class GetNavConfig extends RouteInformation {
  final List<MitXPage> currentTreeBranch;
  MitXPage? get currentPage => currentTreeBranch.last;

  GetNavConfig({
    required this.currentTreeBranch,
    required super.uri,
    required super.state,
  });

  GetNavConfig copyWith({
    List<MitXPage>? currentTreeBranch,
    required String? location,
    required Object? state,
  }) {
    return GetNavConfig(
      currentTreeBranch: currentTreeBranch ?? this.currentTreeBranch,
      uri: location != null ? Uri.parse(location) : uri,
      state: state ?? this.state,
    );
  }

  static GetNavConfig? fromRoute(String route) {
    final res = MitX.routeTree.matchRoute(route);
    if (res.treeBranch.isEmpty) return null;
    return GetNavConfig(
      currentTreeBranch: res.treeBranch,
      uri: Uri.parse(route),
      state: null,
    );
  }

  @override
  String toString() => '''
======GetNavConfig=====\ncurrentTreeBranch: $currentTreeBranch\ncurrentPage: $currentPage\n======GetNavConfig=====''';
}
