import 'dart:ui';

Color mapNumberToColor(int number) {
  const colorMap = {
    1: Color(0xFFFF0000), // Red
    2: Color(0xFF00FF00), // Green
    3: Color(0xFF0000FF), // Blue
    4: Color(0xFFFFFF00), // Yellow
    5: Color(0xFFFF00FF), // Magenta
    6: Color(0xFF00FFFF), // Cyan
    7: Color(0xFF000000), // Black
    8: Color(0xFFFFA500), // Orange
    9: Color(0xFF800080), // Purple
    'w': Color(0xFFFFFFFF), // White (neutral)
    0: Color(0xFFFFFFFF), // White for 0 (neutral)
  };

  return colorMap[number] ??
      const Color(0xFFFFFFFF); // Default to white if not found
}
