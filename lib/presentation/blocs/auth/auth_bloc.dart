import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/models/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    on<AuthCheckStatusEvent>(_onCheckStatus);
    on<AuthLoginEvent>(_onLogin);
    on<AuthLogoutEvent>(_onLogout);
    on<AuthSignupEvent>(_onSignup);
  }

  void _onCheckStatus(AuthCheckStatusEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    
    // Simulate checking auth status
    await Future.delayed(const Duration(seconds: 1));
    
    // For demo purposes, create a mock user
    const mockUser = User(
      id: '1',
      displayName: 'John Doe',
      email: 'john.doe@spotify.com',
      images: ['https://i.pravatar.cc/300?img=1'],
      country: 'US',
      followers: 1234,
      following: 567,
      product: 'premium',
      isCurrentUser: true,
    );
    
    emit(const AuthenticatedState(mockUser));
  }

  void _onLogin(AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    
    try {
      // Simulate login process
      await Future.delayed(const Duration(seconds: 2));
      
      // Mock successful login
      const user = User(
        id: '1',
        displayName: 'John Doe',
        email: 'john.doe@spotify.com',
        images: ['https://i.pravatar.cc/300?img=1'],
        country: 'US',
        followers: 1234,
        following: 567,
        product: 'premium',
        isCurrentUser: true,
      );
      
      emit(const AuthenticatedState(user));
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }

  void _onLogout(AuthLogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    
    // Simulate logout process
    await Future.delayed(const Duration(seconds: 1));
    
    emit(UnauthenticatedState());
  }

  void _onSignup(AuthSignupEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    
    try {
      // Simulate signup process
      await Future.delayed(const Duration(seconds: 2));
      
      // Mock successful signup
      const user = User(
        id: '2',
        displayName: 'Jane Smith',
        email: 'jane.smith@spotify.com',
        images: ['https://i.pravatar.cc/300?img=2'],
        country: 'US',
        followers: 0,
        following: 0,
        product: 'free',
        isCurrentUser: true,
      );
      
      emit(const AuthenticatedState(user));
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }
}

