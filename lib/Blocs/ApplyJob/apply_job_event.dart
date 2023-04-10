part of 'apply_job_bloc.dart';

abstract class ApplyJobEvent extends Equatable {
  const ApplyJobEvent();

  @override
  List<Object> get props => [];
}

class ApplyButtonPressed extends ApplyJobEvent {
  final String userId;
  final String name;
  final String description;
  final String amount;
  final String location;
  final String image;
  final Timestamp createdAt;
  final String userImage;
  final String userName;
  final String userRole;
  final String belongsTo;

  const ApplyButtonPressed(
      {required this.userId,
      required this.name,
      required this.description,
      required this.amount,
      required this.location,
      required this.image,
      required this.createdAt,
      required this.userImage,
      required this.userName,
      required this.userRole,
      required this.belongsTo});

  @override
  List<Object> get props => [
        userId,
        name,
        description,
        amount,
        location,
        image,
        createdAt,
        userImage,
        userName,
        userRole,
        belongsTo
      ];
}
