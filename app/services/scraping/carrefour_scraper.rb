require 'mechanize'
require 'nokogiri'
require 'open-uri'

module Scraping
  class CarrefourScraper
    class << self
      def execute
        agent = Mechanize.new
        page = agent.get('https://www.carrefour.es/supermercado/el-mercado/cat20002/c')
        products = page.search('.product-card')
        json_array = products.map do |product|
          build_data(product)
        end
        binding.pry
        # TODO: Next page
      end

      private

      def page_urls
      end

      def build_data(product)
        {
          name: product.search('.product-card__title-link').text.squish,
          price: product.search('.product-card__prices').text.gsub(',', '.').delete('€').squish.split(' ').last.to_f,
          image: product.search('.product-card__image').first['src']
        }
      end
    end
  end
end