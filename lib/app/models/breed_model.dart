class Breed {
  String title;
  Breed({
    required this.title,
  });
}

class DogBreed extends Breed {
  DogBreed(String title) : super(title: title);
}

class CatBreed extends Breed {
  CatBreed(String title) : super(title: title);
}
