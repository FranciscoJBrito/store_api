module ApplicationHelper
      def playload_test
            JSON.parse(response.body, symbolize_names: true)
      end 
end