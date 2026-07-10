import 'package:emombti/app_state/auth.dart';
import 'package:emombti/data/repositories/activity/activity_repository.dart';
import 'package:emombti/data/repositories/auth/auth_repository.dart';
import 'package:emombti/data/repositories/user/user_repository.dart';
import 'package:emombti/domain/models/activity/activity.dart';
import 'package:emombti/domain/models/user/user.dart';
import 'package:emombti/domain/use_cases/user/user_avatar_update_use_case.dart';
import 'package:emombti/utils/command.dart';
import 'package:emombti/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MeScreenViewModel extends ChangeNotifier {
  MeScreenViewModel(
    this._activityRepository,
    this._authRepository,
    this._userRepository,
    this._authState,
    this._userAvatarUpdateUseCase,
  ) {
    _authState.addListener(_onAuthStateChanged);
    loadActivity = Command0<List<Activity>>(_loadActivityInternal);
    pickAndUploadAvatarCommand = Command0<User>(_pickAndUploadAvatar);
    pickAndUploadBackgoundImgCommand = Command0<User>(
      _pickAndUploadBackgroundImg,
    );
    deleteActivityCommand = Command1<void, String>(_deleteActivity);
  }

  final ActivityRepository _activityRepository;
  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  final AuthState _authState;
  final UserAvatarUpdateUseCase _userAvatarUpdateUseCase;
  late final Command0<List<Activity>> loadActivity;
  late final Command0<User> pickAndUploadAvatarCommand;
  late final Command0<User> pickAndUploadBackgoundImgCommand;
  late final Command1<void, String> deleteActivityCommand;

  List<Activity> _activities = [];
  List<Activity> get activities => _activities;

  User? get user => _authState.user;

  Future<Result<List<Activity>>> _loadActivityInternal() async {
    final userId = user?.id;
    if (userId == null || userId.isEmpty) {
      _activities = [];
      notifyListeners();
      return Result.ok(_activities);
    }

    final result = await _activityRepository.getActivities(userId);
    switch (result) {
      case Ok<List<Activity>>():
        _activities = result.value;
        notifyListeners();
      case Error<List<Activity>>():
        break;
    }
    return result;
  }

  Future<Result<User>> _pickAndUploadAvatar() async {
    Result<User> result = await _userAvatarUpdateUseCase.pickAndUploadAvatar(
      user?.id ?? '',
      ImagePicker(),
    );
    if (result is Ok<User>) {
      _authState.updateAuthenticatedUser(
        user?.copyWith(avatar: result.value.avatar),
      );
    }
    return result;
  }

  Future<Result<User>> _pickAndUploadBackgroundImg() async {
    ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 75,
    );
    if (image == null) {
      return Result.error(Exception('No image selected'));
    }
    final bytes = await image.readAsBytes();
    Result<User> result = await _userRepository.updateBackgroundImg(
      user?.id ?? '',
      bytes,
      image.name,
    );
    if (result is Ok<User>) {
      _authState.updateAuthenticatedUser(
        user?.copyWith(backgroundImg: result.value.backgroundImg),
      );
    }
    return result;
  }

  Future<Result<void>> _deleteActivity(String activityId) async {
    final userId = user?.id;
    if (userId == null) {
      return Result.error(Exception('User not authenticated'));
    }

    final result = await _activityRepository.deleteActivity(userId, activityId);
    if (result is Ok) {
      _activities.removeWhere((a) => a.id == activityId);
      notifyListeners();
    }
    return result;
  }

  Future<void> logout() async {
    final result = await _authRepository.logout();
    if (result is Ok) {
      _authState.updateAuthenticatedUser(null);
    }
  }

  void _onAuthStateChanged() {
    if (user == null && _activities.isNotEmpty) {
      _activities = [];
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _authState.removeListener(_onAuthStateChanged);
    super.dispose();
  }
}
