// Mocks generated by Mockito 5.0.17 from annotations
// in restaurant_app/test/restaurant_detail_provider_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i6;
import 'dart:ui' as _i9;

import 'package:mockito/mockito.dart' as _i1;
import 'package:restaurant_app/data/api/api_service.dart' as _i5;
import 'package:restaurant_app/data/model/restaurant.dart' as _i2;
import 'package:restaurant_app/data/model/restaurant_detail.dart' as _i3;
import 'package:restaurant_app/data/model/restaurant_post_review.dart' as _i4;
import 'package:restaurant_app/provider/restaurant_detail_provider.dart' as _i7;
import 'package:restaurant_app/utils/result_state.dart' as _i8;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeRestaurantResult_0 extends _i1.Fake implements _i2.RestaurantResult {
}

class _FakeRestaurantDetail_1 extends _i1.Fake implements _i3.RestaurantDetail {
}

class _FakeRestaurantSearch_2 extends _i1.Fake implements _i2.RestaurantSearch {
}

class _FakeRestaurantPostReview_3 extends _i1.Fake
    implements _i4.RestaurantPostReview {}

class _FakeApiService_4 extends _i1.Fake implements _i5.ApiService {}

/// A class which mocks [ApiService].
///
/// See the documentation for Mockito's code generation for more information.
class MockApiService extends _i1.Mock implements _i5.ApiService {
  MockApiService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i2.RestaurantResult> restaurantList() =>
      (super.noSuchMethod(Invocation.method(#restaurantList, []),
              returnValue:
                  Future<_i2.RestaurantResult>.value(_FakeRestaurantResult_0()))
          as _i6.Future<_i2.RestaurantResult>);
  @override
  _i6.Future<_i3.RestaurantDetail> restaurantDetail(String? id) =>
      (super.noSuchMethod(Invocation.method(#restaurantDetail, [id]),
              returnValue:
                  Future<_i3.RestaurantDetail>.value(_FakeRestaurantDetail_1()))
          as _i6.Future<_i3.RestaurantDetail>);
  @override
  _i6.Future<_i2.RestaurantSearch> searchRestaurant(String? query) =>
      (super.noSuchMethod(Invocation.method(#searchRestaurant, [query]),
              returnValue:
                  Future<_i2.RestaurantSearch>.value(_FakeRestaurantSearch_2()))
          as _i6.Future<_i2.RestaurantSearch>);
  @override
  _i6.Future<_i4.RestaurantPostReview> postReview(
          String? id, String? name, String? review) =>
      (super.noSuchMethod(Invocation.method(#postReview, [id, name, review]),
              returnValue: Future<_i4.RestaurantPostReview>.value(
                  _FakeRestaurantPostReview_3()))
          as _i6.Future<_i4.RestaurantPostReview>);
}

/// A class which mocks [RestaurantDetailProvider].
///
/// See the documentation for Mockito's code generation for more information.
class MockRestaurantDetailProvider extends _i1.Mock
    implements _i7.RestaurantDetailProvider {
  MockRestaurantDetailProvider() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.ApiService get apiService =>
      (super.noSuchMethod(Invocation.getter(#apiService),
          returnValue: _FakeApiService_4()) as _i5.ApiService);
  @override
  String get restaurantId =>
      (super.noSuchMethod(Invocation.getter(#restaurantId), returnValue: '')
          as String);
  @override
  _i3.RestaurantDetail get result =>
      (super.noSuchMethod(Invocation.getter(#result),
          returnValue: _FakeRestaurantDetail_1()) as _i3.RestaurantDetail);
  @override
  String get message =>
      (super.noSuchMethod(Invocation.getter(#message), returnValue: '')
          as String);
  @override
  _i8.ResultState get state => (super.noSuchMethod(Invocation.getter(#state),
      returnValue: _i8.ResultState.loading) as _i8.ResultState);
  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);
  @override
  _i6.Future<dynamic> fetchRestaurantDetail(String? restaurantId) => (super
      .noSuchMethod(Invocation.method(#fetchRestaurantDetail, [restaurantId]),
          returnValue: Future<dynamic>.value()) as _i6.Future<dynamic>);
  @override
  void addListener(_i9.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void removeListener(_i9.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#removeListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void dispose() => super.noSuchMethod(Invocation.method(#dispose, []),
      returnValueForMissingStub: null);
  @override
  void notifyListeners() =>
      super.noSuchMethod(Invocation.method(#notifyListeners, []),
          returnValueForMissingStub: null);
}
