
import 'package:flutter/cupertino.dart';

import 'features/products_showcase/ui/image_gallery.dart';
import 'features/splash/ui/splash_screen.dart';



final Map<String, WidgetBuilder> routes = {
  GalleryImages.routeName: (context) => GalleryImages(),

  SplashScreen.routeName: (context) => const SplashScreen(),

};
