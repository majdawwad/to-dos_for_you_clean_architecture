import 'package:dartz/dartz.dart';

import '../../features/auth/domain/entities/user.dart';
import '../../features/settings/domain/entities/profile_user.dart';
import '../../features/todos/domain/entities/todo.dart';
import '../../features/user_tasks/domain/entities/user_todo.dart';
import '../errors/failures/failures.dart';

typedef FailureOrSignUpAuth = Either<Failure, Unit>;
typedef FailureOrSignInAuth = Either<Failure, User>;

typedef DeleteOrUpdateOrAddTodo = Future<Unit> Function();
typedef FailureOrTodoos = Either<Failure, Unit>;
typedef FailureOrTodos = Either<Failure, List<Todo>>;
typedef FailureOrTodo = Either<Failure, Todo>;

typedef FailureOrUserTodos = Either<Failure, List<UserTodo>>;
typedef FailureOrUserTodo = Either<Failure, Unit>;

typedef FailureOrProfileUserInfo = Either<Failure, ProfileUser>;
