abstract class CommentsStates{}

class CommentsInitialState extends CommentsStates{}
class CommentsLoadingState extends CommentsStates{}
class CommentsSuccessState extends CommentsStates{}
class CommentsErrorState extends CommentsStates{}


class GetCommentsLoadingState extends CommentsStates{}
class GetCommentsSuccessState extends CommentsStates{}
class GetCommentsErrorState extends CommentsStates{}

