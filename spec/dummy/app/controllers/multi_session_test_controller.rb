class MultiSessionTestController < ApplicationController
  def some_action
  end

  def encrypt_multi_sessions
    params.require(:session_values).permit!.each do |session_key, value|
      multi_session[session_key] = value
    end
    head :ok
  end

  def decrypt_multi_sessions
    session_values = params.require(:session_keys).map do |key|
      "#{key}-#{multi_session[key]}"
    end.join(',')
    render inline: session_values
  end
end
