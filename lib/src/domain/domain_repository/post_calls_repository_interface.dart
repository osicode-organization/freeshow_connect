import 'package:fpdart/fpdart.dart';

abstract class PostCallsRepositoryInterface {
  /// scriptures
  Future<Either<String, void>> nextScripture();
  Future<Either<String, void>> previousScripture();
  Future<Either<String, void>> startScripture(String reference);

  /// slides
  Future<Either<String, void>> nextSlide();
  Future<Either<String, void>> previousSlide();
  Future<Either<String, void>> selectSlideByIndex(
    String showId,
    String layoutId,
    int index,
  );

  ///projects
  Future<Either<String, void>> selectProjectById(String id);
  Future<Either<String, void>> selectProjectByIndex(String number);
  Future<Either<String, void>> selectProjectByName(String name);

  /// shows
  Future<Either<String, void>> selectShowByName(String name);

  Future<Either<String, void>> startShow(String string);

  Future<Either<String, void>> setShow(String id, String name);
}
