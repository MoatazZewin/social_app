abstract class HomeStates{}
class HomeInitialState extends HomeStates{}
class HomeGetUserLoadingState extends HomeStates{}
class HomeGetUserSuccessState extends HomeStates{}
class HomeGetUserErrorState extends HomeStates{
  final String error;
  HomeGetUserErrorState(this.error);
}
class HomeChangeBottomNavState extends HomeStates{}
class NewPostsState extends HomeStates{}
class ProfileImagePickedSuccessState extends HomeStates{}
class ProfileImagePickedErrorState extends HomeStates{}

class CoverImagePickedSuccessState extends HomeStates{}
class CoverImagePickedErrorState extends HomeStates{}

class UploadCoverImageSuccessState extends HomeStates{}
class UploadCoverImageErrorState extends HomeStates{}

class UploadProfileImageSuccessState extends HomeStates{}
class UploadProfileImageErrorState extends HomeStates{}


class UserUpdateLoadingState extends HomeStates{}
class UserUpdateErrorState extends HomeStates{}