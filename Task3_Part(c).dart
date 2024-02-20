class Position {
  double x;
  double y;

  Position(this.x, this.y);

  // Constant constructor named Origin
  const Position.Origin() : x = 0, y = 0;
}

class Size {
  double w;
  double h;

  Size(this.w, this.h);

  // Constant constructor named Zero
  const Size.Zero() : w = 0, h = 0;
}

class Frame {
  Position _position;
  Size _size;

  // a) Properties can be modified by using cascading
  Frame(this._position, this._size);

  // b) Redirecting constructor
  Frame.fromPosition(Position position)
      : this(Position.Origin(), Size.Zero()) {
    _position = position;
  }

  // c) Getters and setters for Position & Size
  Position get Position => _position;
  set Position(Position value) => _position = value;

  Size get Size => _size;
  set Size(Size value) => _size = value;

  // d) Getters for underlying X, Y, W, H properties
  double get X => _position.x;
  double get Y => _position.y;

  double get W => _size.w;
  double get H => _size.h;

  // e) Factory constructor that throws an exception for negative values
  factory Frame.noNegative(Position position, Size size) {
    if (size.w < 0 || size.h < 0) {
      throw ArgumentError("Width and Height must not be negative.");
    }
    return Frame(position, size);
  }

  // f) Named constructor
  Frame.named(Position position, Size size) : this(position, size);

  @override
  String toString() {
    return 'Frame{Position: $_position, Size: $_size}';
  }
}

void main() {
  // Creating a Frame using the regular constructor
  Frame frame1 = Frame(Position(5, 10), Size(15, 20));
  print('Frame 1: $frame1');

  // Using cascading to modify properties
  Frame frame2 = Frame(Position(3, 7), Size(25, 30))
    ..Position = Position.Origin()
    ..Size = Size.Zero();
  print('Frame 2: $frame2');

  // Creating a Frame using the redirecting constructor
  Frame frame3 = Frame.fromPosition(Position(8, 12));
  print('Frame 3: $frame3');

  // Using the factory constructor with negative values (will throw an exception)
  try {
    Frame negativeFrame = Frame.noNegative(Position(2, 5), Size(-2, 5));
    print('Negative Frame: $negativeFrame');
  } catch (e) {
    print('Error: $e');
  }
}
