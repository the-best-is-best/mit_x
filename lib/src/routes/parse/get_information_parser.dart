import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:mit_x/mit_x.dart';
import 'package:mit_x/src/routes/config/get_nav_config.dart';

class GetInformationParser extends RouteInformationParser<GetNavConfig> {
  final String initialRoute;

  GetInformationParser({
    this.initialRoute = '/',
  }) {
    MitX.log('GetInformationParser is created !');
  }
  @override
  SynchronousFuture<GetNavConfig> parseRouteInformation(
    RouteInformation routeInformation,
  ) {
    var location = routeInformation.uri;
    if (location.path == '/') {
      //check if there is a corresponding page
      //if not, relocate to initialRoute
      if (!MitX.routeTree.routes.any((element) => element.name == '/')) {
        location = Uri.parse(initialRoute);
      }
    }

    MitX.log('GetInformationParser: route location: $location');

    final matchResult = MitX.routeTree.matchRoute(location.path);

    return SynchronousFuture(
      GetNavConfig(
        currentTreeBranch: matchResult.treeBranch,
        uri: location,
        state: routeInformation.state,
      ),
    );
  }

  @override
  RouteInformation restoreRouteInformation(GetNavConfig configuration) {
    return RouteInformation(
      uri: configuration.uri,
      state: configuration.state,
    );
  }
}
