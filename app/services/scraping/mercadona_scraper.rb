require 'httparty'

module Scraping
  class MercadonaScraper
    class << self
      attr_reader :categories

      def execute(sections=[156])
        sections.map do |section|
          initiate(section)

          json_array = categories.map { |c| build_category(c) }.flatten
        end.flatten
      end

      private

      def initiate(section)
        response = HTTParty.get("https://tienda.mercadona.es/api/categories/#{section}")
        @categories = response['categories']
      end

      def section_counts
        (1..156)
      end

      def products(category)
        category['products']
      end

      def build_category(category)
        products(category).map { |p| build_data(p) }
      end

      def build_data(product)
        price = product['price_instructions']
        {
          name: "#{product['display_name']} #{product['packaging']}",
          price: price['unit_price'],
          quantity: price['unit_size'],
          unit: price['reference_format'],
          image_url: product['thumbnail']
        }
      end
    end
  end
end
