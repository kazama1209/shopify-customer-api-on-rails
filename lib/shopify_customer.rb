class ShopifyCustomer
  # 初期設定
  def initialize
    shop_url = "https://#{ENV["SHOPIFY_API_KEY"]}:#{ENV["SHOPIFY_PASSWORD"]}@#{ENV["SHOPIFY_STORE_DOMAIN"]}"

    ShopifyAPI::Base.site = shop_url
    ShopifyAPI::Base.api_version = "2021-04"
    ShopifyAPI::Shop.current
  end

  # SSO基盤側でユーザー情報の変更（メールアドレスなど）を行った際、Shopify側の顧客情報を変更する。
  # 引数はキーワード引数形式で渡す（email: hoge@example.com, address: hogefugapiyo）。
  def update(multipass_identifier, **args)
    # Multipassログイン時に渡している「multipass_identifer」をもとに顧客情報を取得。
    customer = ShopifyAPI::Customer.search(multipass_identifier: multipass_identifier)[0]
    return false if customer.nil?

    customer.update_attributes(args)

    true
  rescue => e
    return false, e
  end
end
