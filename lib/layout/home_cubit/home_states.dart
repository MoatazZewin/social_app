abstract class HomeStates{}
class HomeInitialState extends HomeStates{}

class HomeGetUserLoadingState extends HomeStates{}
class HomeGetUserSuccessState extends HomeStates{}
class HomeGetUserErrorState extends HomeStates{
  final String error;
  HomeGetUserErrorState(this.error);
}

class HomeGetAllUsersLoadingState extends HomeStates{}
class HomeGetAllUsersSuccessState extends HomeStates{}
class HomeGetAllUsersErrorState extends HomeStates{
  final String error;
  HomeGetAllUsersErrorState(this.error);
}

class GetPostsLoadingState extends HomeStates{}
class GetPostsSuccessState extends HomeStates{}
class GetPostsErrorState extends HomeStates{
  final String error;
  GetPostsErrorState(this.error);
}


class LikePostSuccessState extends HomeStates{}
class LikePostErrorState extends HomeStates{
  final String error;
  LikePostErrorState(this.error);
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

class UploadPostImageSuccessState extends HomeStates{}
class UploadPostImageErrorState extends HomeStates{}


class RemovePostImageState extends HomeStates{}


class UserUpdateLoadingState extends HomeStates{}
class UserUpdateErrorState extends HomeStates{}

class CreatePostLoadingState extends HomeStates{}
class CreatePostSuccessState extends HomeStates{}
class CreatePostErrorState extends HomeStates{}

class GetLikesSuccessState extends HomeStates{}
class GetLikesErrorState extends HomeStates{}


class SendMessageSuccessState extends HomeStates{}
class SendMessageErrorState extends HomeStates{}

class GetMessageSuccessState extends HomeStates{}


class ChangeLikesPostLengthSuccessState extends HomeStates{}
class AddUserLikeSuccessState extends HomeStates{}

class DeleteLikeFromPostSuccessState extends HomeStates{}
class DeleteLikeFromPostErrorState extends HomeStates{}

