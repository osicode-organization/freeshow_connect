import 'package:fpdart/fpdart.dart';
import 'package:freeshow_connect/src/data/data_sources/post_calls.dart';

import '../../core/error/exceptions/exceptions.dart';
import '../../domain/domain_repository/post_calls_repository_interface.dart';

class PostCallsRepositoryImpl extends PostCallsRepositoryInterface {
  PostCalls postCallsInstance;
  PostCallsRepositoryImpl({required this.postCallsInstance});

  @override
  Future<Either<String, void>> nextScripture() async {
    try {
      final data = await postCallsInstance.nextScripture();
      return Right(data);
    } on ServerException catch (e) {
      return Left(e.message);
    }
  }

  @override
  Future<Either<String, void>> previousScripture() async {
    try {
      final data = await postCallsInstance.previousScripture();
      return Right(data);
    } on ServerException catch (e) {
      return Left(e.message);
    }
  }

  @override
  Future<Either<String, void>> startScripture(String reference) async {
    try {
      final data = await postCallsInstance.startScripture(reference);
      return Right(data);
    } on ServerException catch (e) {
      return Left(e.message);
    }
  }

  @override
  Future<Either<String, void>> nextSlide() async {
    try {
      final data = await postCallsInstance.nextSlide();
      return Right(data);
    } on ServerException catch (e) {
      return Left(e.message);
    }
  }

  @override
  Future<Either<String, void>> previousSlide() async {
    try {
      final data = await postCallsInstance.previousSlide();
      return Right(data);
    } on ServerException catch (e) {
      return Left(e.message);
    }
  }

  @override
  Future<Either<String, void>> selectSlideByIndex(
    String showId,
    String layoutId,
    int index,
  ) async {
    try {
      final data = await postCallsInstance.selectSlideByIndex(
        showId,
        layoutId,
        index,
      );
      return Right(data);
    } on ServerException catch (e) {
      return Left(e.message);
    }
  }

  @override
  Future<Either<String, void>> selectProjectById(String id) async {
    try {
      final data = await postCallsInstance.selectProjectById(id);
      return Right(data);
    } on ServerException catch (e) {
      return Left(e.message);
    }
  }

  @override
  Future<Either<String, void>> selectProjectByIndex(String number) async {
    try {
      final data = await postCallsInstance.selectProjectByIndex(number);
      return Right(data);
    } on ServerException catch (e) {
      return Left(e.message);
    }
  }

  @override
  Future<Either<String, void>> selectProjectByName(String name) async {
    try {
      final data = await postCallsInstance.selectProjectByName(name);
      return Right(data);
    } on ServerException catch (e) {
      return Left(e.message);
    }
  }

  @override
  Future<Either<String, void>> selectShowByName(String name) async {
    try {
      final data = await postCallsInstance.selectShowByName(name);
      return Right(data);
    } on ServerException catch (e) {
      return Left(e.message);
    }
  }

  @override
  Future<Either<String, void>> setShow(String id, String name) async {
    try {
      final data = await postCallsInstance.setShow(id, name);
      return Right(data);
    } on ServerException catch (e) {
      return Left(e.message);
    }
  }

  @override
  Future<Either<String, void>> startShow(String string) async {
    try {
      final data = await postCallsInstance.startShow(string);
      return Right(data);
    } on ServerException catch (e) {
      return Left(e.message);
    }
  }
}
