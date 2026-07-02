import 'dart:async';

import 'package:emombti/app_state/auth.dart';
import 'package:emombti/app_state/chat.dart';
import 'package:emombti/data/repositories/chat/chat_repository.dart';
import 'package:emombti/data/repositories/user/user_repository.dart';
import 'package:emombti/domain/models/chat/chat.dart';
import 'package:emombti/domain/models/user/user.dart';
import 'package:emombti/utils/command.dart';
import 'package:emombti/utils/result.dart';
import 'package:flutter/material.dart';

class ChatsViewModel extends ChangeNotifier {
  ChatsViewModel({
    required AuthState authState,
    required ChatRepository chatRepository,
    required UserRepository userRepository,
    required ChatState chatState,
  }) : _authState = authState,
       _chatRepository = chatRepository,
       _userRepository = userRepository,
       _chatState = chatState {
    loadRoomsCommand = Command0<void>(_loadRoomsInternal);
    createChatRoomCommand = Command1<Chat, User>(_createChatRoomInternal);
    deleteRoomCommand = Command1<void, String>(_deleteRoomInternal);
  }

  final AuthState _authState;
  final ChatRepository _chatRepository;
  final UserRepository _userRepository;
  final ChatState _chatState;

  late final Command0<void> loadRoomsCommand;
  late final Command1<Chat, User> createChatRoomCommand;
  late final Command1<void, String> deleteRoomCommand;

  List<User> _searchResults = [];
  List<User> get searchResults => _searchResults;

  bool _isSearchingUsers = false;
  bool get isSearchingUsers => _isSearchingUsers;

  String? _searchError;
  String? get searchError => _searchError;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  Timer? _searchDebounce;

  void onSearchQueryChanged(String query) {
    _searchQuery = query;
    notifyListeners();

    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 350), () {
      _searchUsers(query);
    });
  }

  Future<void> _searchUsers(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) {
      _searchResults = [];
      _searchError = null;
      _isSearchingUsers = false;
      notifyListeners();
      return;
    }

    final currentUserId = _authState.user?.id;
    _isSearchingUsers = true;
    _searchError = null;
    notifyListeners();

    final result = await _userRepository.searchUsers(
      trimmed,
      excludeUserId: currentUserId,
    );

    if (result is Ok<List<User>>) {
      _searchResults = result.value;
      _searchError = null;
    } else {
      _searchResults = [];
      _searchError = (result as Error).error.toString();
    }

    _isSearchingUsers = false;
    notifyListeners();
  }

  void clearSearch() {
    _searchDebounce?.cancel();
    _searchQuery = '';
    _searchResults = [];
    _searchError = null;
    _isSearchingUsers = false;
    notifyListeners();
  }

  Future<Result<Chat>> _createChatRoomInternal(User selectedUser) async {
    final currentUser = _authState.user;
    final currentUserId = currentUser?.id;
    final otherUserId = selectedUser.id;

    if (currentUserId == null || currentUserId.isEmpty) {
      return Result.error(Exception('User not authenticated'));
    }
    if (otherUserId == null || otherUserId.isEmpty) {
      return Result.error(Exception('Selected user is invalid'));
    }

    final result = await _chatRepository.createDirectChat(
      currentUserId: currentUserId,
      otherUserId: otherUserId,
      otherUserName: selectedUser.name ?? selectedUser.email,
    );

    if (result is Ok<Chat>) {
      final room = result.value;
      final existingIndex = _chatState.chats.indexWhere((r) => r.id == room.id);
      if (existingIndex >= 0) {
        final updatedRooms = List<Chat>.from(_chatState.chats);
        updatedRooms[existingIndex] = room;
        _chatState.setChats(updatedRooms);
      } else {
        _chatState.addChat(room);
      }
    }

    return result;
  }

  Future<Result<void>> _loadRoomsInternal() async {
    final user = _authState.user;
    if (user == null) {
      return Result.error(Exception('User not authenticated'));
    }

    final result = await _chatRepository.getChats(user.id ?? '');

    if (result is Ok<List<Chat>>) {
      _chatState.setChats(result.value);
      return Result.ok(null);
    }
    return Result.error((result as Error).error);
  }

  Future<Result<void>> _deleteRoomInternal(String roomId) async {
    final user = _authState.user;
    if (user == null) {
      return Result.error(Exception('User not authenticated'));
    }

    final previousRooms = List<Chat>.from(_chatState.chats);
    _chatState.removeChat(roomId);

    final result = await _chatRepository.deleteRoom(
      userId: user.id ?? '',
      roomId: roomId,
    );

    if (result is! Ok<void>) {
      _chatState.setChats(previousRooms);
    }

    return result;
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    super.dispose();
  }
}
