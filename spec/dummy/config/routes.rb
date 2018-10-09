Rails.application.routes.draw do
  root 'multi_session_test#some_action'
  get 'encrypt_multi_sessions', to: 'multi_session_test#encrypt_multi_sessions'
  get 'decrypt_multi_sessions', to: 'multi_session_test#decrypt_multi_sessions'
end
