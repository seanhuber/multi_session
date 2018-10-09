RSpec.describe 'multi_session', type: :request do
  it 'renders the root page without error' do
    get '/'
    expect(response.body).to include('<h1>hello world!</h1>')
  end

  it 'encrypts and decrypts multi_session cookies' do
    session_values = {
      aaaa: 'alpha',
      bbbb: 'bravo',
      cccc: 'charlie',
      dddd: 'delta',
      eeee: 'echo'
    }
    get '/encrypt_multi_sessions', params: {session_values: session_values}

    expect(response.status).to eq(200)
    session_values.each do |session_key, value|
      expect(response.cookies).to have_key(session_key.to_s)
      expect(response.cookies[session_key.to_s].length > value.length).to be true
    end

    get '/decrypt_multi_sessions', params: {session_keys: session_values.keys}
    expected_response = session_values.map{|k,v| "#{k}-#{v}"}.join(',')
    expect(response.body).to eq(expected_response)
  end
end
