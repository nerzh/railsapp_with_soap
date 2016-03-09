
def json_response
  JSON.parse(response.body)
end

def login_user
  before(:each) do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in user
  end
end