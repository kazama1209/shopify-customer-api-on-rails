class ShopifyMultipassController < ApplicationController
  def confirm
  end

  def login
    # Shopifyへ渡す顧客情報（必須項目はメールアドレスでそれ以外は任意）
    customer_data = {
      email: current_user.email,
      identifier: current_user.id
    }

    shopify_multipass = ShopifyMultipass.new(ENV["SHOPIFY_MULTIPASS_SECRET"])

    # 次のようなURLが作成される 「https://<ストアのドメイン>/account/login/multipass/<トークン>」
    url = shopify_multipass.generate_url(customer_data, ENV["SHOPIFY_STORE_DOMAIN"])
    redirect_to url
  end
end
