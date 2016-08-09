OmniAuth.config.logger = Rails.logger
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
    "726991080060-nf7ol8c4fc77ahobhmd6vlmg8ampgo9e.apps.googleusercontent.com",
    "8Nb1Le9NS3bB-G6_Emv1vB6w"
  provider :facebook,
    "679912158830852",
    "f54ddd4b9c8063c5ec6c489bbf2f9705"
  provider :github,
    "71c5bf558cb822eaa67c",
    "758354178615330646dd99dbb7763075e4ee9c27"
end
