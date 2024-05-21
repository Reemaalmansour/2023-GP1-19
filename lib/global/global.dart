import 'dart:ui';

import 'package:font_awesome_flutter/font_awesome_flutter.dart' as FAIcons;
import 'package:geolocator/geolocator.dart';

import '../model/category/category_model.dart';
import '../model/place/place_model.dart';
import '../model/trip/trip_model.dart';
import '../model/user/user_model.dart';

UserModel? kUser;

class Global {
  // static BlogCubit blogCubit = BlogCubit.instance;
  static Position? userPosition;
  static Location ksaLocation = Location(lat: 23.8859, lng: 45.0792);
  // static List<String> recommendationTypes = [];
  static List<PlaceModel> favPlaces = [];
  static List<PlaceModel> discoveryPlaces = [];
  static List<PlaceModel> recentPlaces = [];
  static List<TripModel> kTrips = [];
  static List<TripModel> kSharedTrips = [];
  static List<String> ksaDistrictsLatLng = [
    "24.736772754028955,46.57457256708812",
    "24.7031,46.6780",
    "24.6940,46.6837",
    "24.8018,46.7156",
    // "24.6996, 46.7207",
    "24.7743,46.7384",
    "24.7743,46.7384",
  ];

  // unique colors for each category
  static List<Color> uniqueColors = [
    const Color(0xFFE57373),
    const Color(0xFFBA68C8),
    const Color(0xFF64B5F6),
    const Color(0xFF4DB6AC),
    const Color(0xFF81C784),
    const Color(0xFFFFD54F),
    const Color(0xFFFF8A65),
    const Color(0xFFA1887F),
    const Color(0xFF90A4AE),
    // red
    const Color.fromARGB(255, 255, 0, 0),
    // green
    const Color.fromARGB(255, 0, 255, 0),
    // blue
    const Color.fromARGB(255, 0, 0, 255),
    // yellow
    const Color.fromARGB(255, 255, 255, 0),
    // cyan
    const Color.fromARGB(255, 0, 255, 255),
    // magenta
    const Color.fromARGB(255, 255, 0, 255),
    // orange
    const Color.fromARGB(255, 255, 165, 0),
    // pink
    const Color.fromARGB(255, 255, 192, 203),
    // purple
    const Color.fromARGB(255, 128, 0, 128),
    // brown
    const Color.fromARGB(255, 165, 42, 42),
    // gray
    const Color.fromARGB(255, 128, 128, 128),
    // white
    const Color.fromARGB(255, 255, 255, 255),
    // black
    const Color.fromARGB(255, 0, 0, 0),
  ];

  static const List<CategoryModel> categories = [
    const CategoryModel(
      cId: "0",
      name: 'All',
      types: [],
      image: null,
      icon: FAIcons.FontAwesomeIcons.list,
      //write description here
      description: "Write Description Here",
    ),
    const CategoryModel(
      cId: "1",
      name: 'Restaurants',
      types: [
        "restaurant",
        "point_of_interest",
      ],
      image: null,
      icon: FAIcons.FontAwesomeIcons.utensils,
      //write description here
      description: "Write Description Here",
    ),
    const CategoryModel(
      cId: "2",
      name: 'Hotels',
      types: [
        "hotel",
        "lodging",
        "hostel",
        "point_of_interest",
      ],
      image: null,
      icon: FAIcons.FontAwesomeIcons.hotel,
      description: "description",
    ),
    const CategoryModel(
      cId: "3",
      name: 'Activities',
      types: [
        "amusement_park",
        "aquarium",
        "art_gallery",
        "bowling_alley",
        "park",
        "zoo",
        "point_of_interest",
      ],
      image: null,
      icon: FAIcons.FontAwesomeIcons.fireFlameCurved,
      description: "description",
    ),
    const CategoryModel(
      cId: "4",
      name: 'Cafe',
      types: [
        "cafe",
        "point_of_interest",
        "establishment",
        "bakery",
        "meal_takeaway",
        "meal_delivery",
      ],
      image: null,
      icon: FAIcons.FontAwesomeIcons.mugSaucer,
      description: "description",
    ),
    const CategoryModel(
      cId: "5",
      name: 'Shopping',
      types: [
        "shopping_mall",
        "store",
        "clothing_store",
        "shoe_store",
        "jewelry_store",
        "point_of_interest",
      ],
      image: null,
      icon: FAIcons.FontAwesomeIcons.bagShopping,
      description: "description",
    ),
  ];

  static const String mapStyle = '''
  [
    {
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#212121"
        }
      ]
    },
    {
      "elementType": "labels.icon",
      "stylers": [
        {
          "visibility": "off"
        }
      ]
    },
    {
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#757575"
        }
      ]
    },
    {
      "elementType": "labels.text.stroke",
      "stylers": [
        {
          "color": "#212121"
        }
      ]
    },
    {
      "featureType": "administrative",
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#757575"
        }
      ]
    },
    {
      "featureType": "administrative.country",
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#9e9e9e"
        }
      ]
    },
    {
      "featureType": "administrative.land_parcel",
      "stylers": [
        {
          "visibility": "off"
        }
      ]
    },
    {
      "featureType": "administrative.locality",
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#bdbdbd"
        }
      ]
    },
    {
      "featureType": "poi",
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#757575"
        }
      ]
    },
    {
      "featureType": "poi.park",
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#181818"
        }
      ]
    },
    {
      "featureType": "poi.park",
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#616161"
        }
      ]
    },
    {
      "featureType": "poi.park",
      "elementType": "labels.text.stroke",
      "stylers": [
        {
          "color": "#1b1b1b"
        }
      ]
    },
    {
      "featureType": "road",
      "elementType": "geometry.fill",
      "stylers": [
        {
          "color": "#2c2c2c"
        }
      ]
    },
    {
      "featureType": "road",
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#8a8a8a"
        }
      ]
    },
    {
      "featureType": "road.arterial",
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#373737"
        }
      ]
    },
    {
      "featureType": "road.highway",
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#3c3c3c"
        }
      ]
    },
    {
      "featureType": "road.highway.controlled_access",
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#4e4e4e"
        }
      ]
    },
    {
      "featureType": "road.local",
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#616161"
        }
      ]
    },
    {
      "featureType": "transit",
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#757575"
        }
      ]
    },
    {
      "featureType": "water",
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#000000"
        }
      ]
    },
    {
      "featureType": "water",
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#3d3d3d"
        }
      ]
    }
  ]
  ''';
}
