class CheckRequest
    def initialize(app)
      @app = app
    end
    def call(env)
        params=Rack::Request.new(env)
        puts ".........FROM MIDDLEWARE......."
        puts "params: #{params.params}"
        @app.call(env)
    end
end