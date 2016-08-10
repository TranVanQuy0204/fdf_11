Rails.application.config.session_store :cookie_store, key: "_base_app_session"
Rails.application.config.session_store :cookie_store,
  key: "order_id", :expire_after => 60.minutes
