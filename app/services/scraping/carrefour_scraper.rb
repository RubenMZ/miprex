require 'mechanize'
require 'nokogiri'
require 'open-uri'

module Scraping
  class CarrefourScraper
    class << self
      attr_reader :products

      def execute(pages=[0])
        pages.map(&method(:process_page)).compact.flatten
      end

      private

      def get_page(page)
        HTTParty.get(page_url(page))
      end

      def hostname
        'https://www.carrefour.es'
      end

      def page_url(page)
        offset = page * 24
        "#{hostname}/cloud-api/plp-food-papi/v1/supermercado/bebidas/cat20003/c?offset=#{offset}&_maxreflevel=3&preview=false"
      end

      def process_page(page)
        response = get_page page
        process_products response['results']['items']
      end

      def process_products(products)
        products.map(&method(:build_product_hash))
      end

      def build_product_hash(product)
        {
          name: product['name'],
          price: format_price(product['price']),
          quantity: calculate_quantity(product),
          unit: product['measure_unit'].capitalize,
          image_url: product['images']['desktop'],
          product_url: product_url(product)
        }
      end

      def product_url(product)
        "#{hostname}#{product['url']}"
      end

      def calculate_quantity(product)
        quantity = format_price(product['price']) / format_price(product['price_per_unit'])
        quantity.round(2)
      end

      def format_price(value)
        value.gsub(',', '.').delete('€').squish.split(' ').last.to_f
      end
    end
  end
end
