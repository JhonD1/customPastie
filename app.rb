require 'securerandom'
require 'pry'
require 'bcrypt'
require_relative 'config/create_tables'

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
        password = BCrypt::Password.create(r.params['password'])

        msg = Message.create(
          content: secret_msg, slug: SecureRandom.hex(16), password_digest: password
        )
        msg.save

        view 'share_secret', locals: { secret_msg: msg, host: env['HTTP_HOST'] }
      end
    end

    r.on 'share' do
      # @wrong_password = nil
      r.get do
        slug = r.params['slug']
        view 'verify_password_secret', locals: { slug: slug }
      end
      
      r.post do
        msg = Message.find( slug: r.params['slug'] )
        if BCrypt::Password.new(msg.password_digest) == r.params['password']
          view 'show_secret', locals: { msg: msg }
        else
          @wrong_password = "You have entered a wrong password"
          r.redirect env['HTTP_REFERER']
        end
      end
    end
  end
end