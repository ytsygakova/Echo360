# Convenience functions for HTTP methods
module Generic
  class Helper
    def self.get_call(url)
      @response = Net::HTTP.get_response(url)
      puts '__________________________'
      puts 'METHOD: GET               '
      puts '__________________________'
      puts 'URL: ' + url
      puts '__________________________'
      puts 'RESPONSE'
      puts '__________________________'
      puts self.pretty_print_json(@response)
      puts '__________________________'
      return @response
    end

    def self.get_error_message(response)
      @response_body = JSON.parse(response)
      @error_response = @response_body[0] if @response_body .is_a?(Array)
      return @error_response['error_message']
    end

    def self.pretty_print_json(json)
      begin
        JSON.pretty_generate(JSON.parse(json))
      rescue
        json
      end
    end

    def self.display_response(response)
      "\n\n--------------------\n\nURL: #{@response.instance_variable_get("@args")[:url]}\nStatus: #{response.code}\n\n#{self.pretty_print_json(@response)}\n\n--------------------\n"
    end
  end
end
