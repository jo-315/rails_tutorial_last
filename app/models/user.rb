class User < ActiveRecord::Base
    has_many :microposts, dependent: :destroy 
    attr_accessor :remember_token, :activation_token, :reset_token
    before_save {self.email = email.downcase }
    before_create :create_activation_digest
    validates :name, presence: true, length: {maximum:50}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: {maximum: 255}, format: {with:  VALID_EMAIL_REGEX }, uniqueness: {case_sesitive: false}
    has_secure_password
    validates :password, presence: true, length: {minimum: 6}, allow_nil: true
    
    # 渡された文字列のハッシュ値を返す
    def self.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end
    
    #cookieの永続化のためのtoken, randomなtokenを返す
    def self.new_token 
        SecureRandom.urlsafe_base64
    end
    
    def make_remember_digest 
        self.remember_token = User.new_token #あるUserのremember_tokenを作成
        update_attribute(:remember_digest, User.digest(remember_token))
        #remember_digestはUserのカラム、ランダムなremember_tokenのハッシュ値を更新
    end
    
    # 渡されたトークンがダイジェストと一致したらtrueを返す
    def authenticated?(remember_token)
       BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end
    
    def forget_remember_digest
        update_attribute(:remember_digest, nil)
    end
    
    def create_reset_digest
        self.reset_token = User.new_token
        update_attribute(:reset_digest, User.digeset(reset_token))
    end
    
    def password_reset_expired?
        reset_sent_at < 2.hours.ago
    end
    
    private 
    
      def create_activation_digest
          self.activation_token = User.new_token #randomなtokenを返す
          self.activation_digest = User.digest(activation_token) #activation_digestをもとに暗号作成
      end
end
