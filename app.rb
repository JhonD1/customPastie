require 'securerandom'
require 'pry'

class App < Roda
  plugin :render

  route do |r|
    r.root do 
      r.redirect '/secret'
    end

    r.on 'secret' do
      r.get do
        view 'enter_secret'
      end

      r.post do
        secret_msg = r.params['secret_message']
        msg = Message.create(
          content: secret_msg, slug: SecureRandom.hex(16)
        )
        msg.save

        view 'share_secret', locals: { secret_msg: msg }
      end
    end

    r.on 'share' do
      slug = r.params['slug']
      msg = Message.find( slug: slug )

      view 'show_secret', locals: { msg: msg }
    end
  end
end