module ActiveCampaign
  module MethodCreator
    def define_api_calls(resource, gets = [], posts = [], deletes = [], puts = [])
      gets.each { |method| define_get_method(resource, method) }
      posts.each { |method| define_post_method(resource, method) }
      deletes.each { |method| define_delete_method(resource, method) }
      puts.each { |method| define_put_method(resource, method) }
    end

    def define_get_method(resource, call)
      define_api_method(:get, resource, call)
    end

    def define_post_method(resource, call)
      define_api_method(:post, resource, call)
    end

    def define_delete_method(resource, call)
      define_api_method(:delete, resource, call)
    end

    def define_put_method(resource, call)
      define_api_method(:put, resource, call)
    end

    def define_api_method(method, resource, call)
      define_method "#{resource}_#{call}" do |options = {}|
        send(method, __method__, options)
      end
    end
  end
end
