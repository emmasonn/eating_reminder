import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:informat/core/exceptions/exception.dart';
import 'package:informat/core/failure/failure.dart';
import 'package:informat/core/network_info/network_info.dart';
import 'package:informat/core/resources/strings.dart';

class HiveFireServiceRunner<T> {
  final NetworkInfo networkInfo;
  final Future<bool> Function(T)? onCacheTask;
  final  Future<T> Function()? getFromCache;


  const HiveFireServiceRunner({
    required this.networkInfo,
    this.onCacheTask,
    this.getFromCache,
   });

  Future<Either<Failure,T>> runServiceTask(
    Future<T> Function() remoteTask,
  ) async {
       if(await networkInfo.isConnected) {
         try {
           final result = await remoteTask.call();
           if (onCacheTask != null) {
             onCacheTask!(result);
           }
           return Right(result);
         }on ServerException catch (e) {
           log('Server Error');
           return Left(ServerFailure(serverFailure, e.message));
         } on CacheException catch (e) {
           log('Cache Error');
           return Left(CacheFailure(cacheFailure, e.message));
         } on HandshakeException {
           log('Handshake Error');
           return const Left(InternetFailure(networkFailure, networkError));
         } on SocketException {
           log('Socket Error');
           return const Left(InternetFailure(networkFailure, noInternet));
         } on FormatException {
           log('Format Error');
           return const Left(ProcessFailure(processFailure, formatError));
         } on TimeoutException {
           log('Timeout Error');
           return const Left(InternetFailure(networkFailure, timeoutError));
         } on Exception {
           log('Unknown Error');
           return const Left(UnknownFailure(unknownError));
         }
    }else {
         if(getFromCache!=null) {
           return Right(await getFromCache!());
         }else{
           return const Left(InternetFailure(networkFailure, noInternet));
         }
       }
  }

  Future<Either<Failure,T>> runCacheTask(Future<T> Function() cached) async {
     return Right(await cached.call());
  }
}