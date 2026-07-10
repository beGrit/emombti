import 'package:flutter/material.dart';

import '../view_models/login_viewmodel.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key, required this.viewModel});

  final LoginViewModel viewModel;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    widget.viewModel.loginWithAccountAndPassword.addListener(_onResult);
    widget.viewModel.register.addListener(_onResult);
  }

  @override
  void didUpdateWidget(covariant LoginForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.viewModel.loginWithAccountAndPassword.removeListener(_onResult);
    oldWidget.viewModel.register.removeListener(_onResult);
    widget.viewModel.loginWithAccountAndPassword.addListener(_onResult);
    widget.viewModel.register.addListener(_onResult);
  }

  @override
  void dispose() {
    widget.viewModel.loginWithAccountAndPassword.removeListener(_onResult);
    widget.viewModel.register.removeListener(_onResult);
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (!widget.viewModel.loginWithAccountAndPassword.running &&
        !widget.viewModel.register.running) {
      if (_formKey.currentState?.validate() ?? false) {
        widget.viewModel.loginWithAccountAndPassword.execute((
          _emailController.value.text,
          _passwordController.value.text,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(32),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: const Icon(Icons.email_outlined),
                      border: const UnderlineInputBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                      ),
                      filled: true,
                      fillColor: colorScheme.surfaceContainerHighest.withValues(
                        alpha: 0.5,
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) =>
                        (value == null || value.isEmpty) ? 'Enter email' : null,
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock_outline),
                      border: const UnderlineInputBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                      ),
                      filled: true,
                      fillColor: colorScheme.surfaceContainerHighest.withValues(
                        alpha: 0.5,
                      ),
                    ),
                    obscureText: true,
                    validator: (value) => (value == null || value.length < 6)
                        ? 'Password too short'
                        : null,
                  ),
                  const SizedBox(height: 32),

                  ListenableBuilder(
                    listenable: widget.viewModel.loginWithAccountAndPassword,
                    builder: (context, child) {
                      return FilledButton(
                        onPressed: _handleLogin,
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child:
                            widget.viewModel.loginWithAccountAndPassword.running
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.login, size: 20),
                                  SizedBox(width: 8),
                                  Text('Login', style: TextStyle(fontSize: 16)),
                                ],
                              ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onResult() {
    if (widget.viewModel.loginWithAccountAndPassword.completed) {
      widget.viewModel.loginWithAccountAndPassword.clearResult();
      widget.viewModel.register.clearResult();
    }

    if (widget.viewModel.loginWithAccountAndPassword.error) {
      widget.viewModel.loginWithAccountAndPassword.clearResult();
      _showRegisterConfirmDialog();
    }

    if (widget.viewModel.register.completed) {
      widget.viewModel.register.clearResult();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration Successfully.')),
      );
    }

    if (widget.viewModel.register.error) {
      widget.viewModel.register.clearResult();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Registration Failed.')));
    }
  }

  void _showRegisterConfirmDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return ListenableBuilder(
          listenable: widget.viewModel.register,
          builder: (context, child) {
            if (widget.viewModel.register.running) {
              return const Center(child: CircularProgressIndicator());
            }
            return AlertDialog(
              title: const Text('Login failed'),
              content: const Text(
                'Would you like to create a new account with this email and password?',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  onPressed: () {
                    widget.viewModel.register.execute((
                      _emailController.text,
                      _passwordController.text,
                    ));
                  },
                  child: const Text('Create Account'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
