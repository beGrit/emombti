import 'package:emombti/data/repositories/user/user_repository.dart';
import 'package:emombti/domain/models/user/user.dart';
import 'package:emombti/utils/result.dart';
import 'package:image_picker/image_picker.dart';

class UserAvatarUpdateUseCase {
  UserAvatarUpdateUseCase({required UserRepository userRepository})
    : _userRepository = userRepository;

  final UserRepository _userRepository;

  Future<Result<User>> pickAndUploadAvatar(
    String userId,
    ImagePicker picker,
  ) async {
    try {
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
      return await _userRepository.updateAvatar(userId, bytes, image.name);
    } catch (e) {
      return Result.error(Exception('Failed to process image: $e'));
    }
  }
}
