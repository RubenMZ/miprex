require 'mechanize'
require 'nokogiri'
require 'open-uri'

module Scraping
  class CarrefourScraper
    class << self
      attr_reader :products

      SECTIONS_WHITELIST = [
        'la-despensa/cat20001',
        'productos-frescos/cat20002',
        'supermercado/bebidas/cat20003',
        'limpieza-y-hogar/cat20005'
        # 'perfumeria-e-higiene/cat20004',
        # 'bebe/cat20006',
        # 'mascotas/cat20007',
        # 'parafarmacia/cat20008',
        # 'ofertas-en-electronica-textil-y-bazar/cat10017263'
      ].freeze

      ALL_PAGES = (0..41).freeze

      def execute(sections=SECTIONS_WHITELIST)
        sections.map(&method(:process_section)).compact.flatten
      end

      private

      def get_page(section, page)
        HTTParty.get(page_url(section, page))
      end

      def hostname
        'https://www.carrefour.es'
      end

      def page_url(section, page)
        offset = page * 24
        url_attributes = {offset: offset, _maxreflevel: 3, preview: false}
        attrs = URI.encode_www_form(url_attributes) # {a: 1, b: 2} => "a=1&b=2"
        "#{hostname}/cloud-api/plp-food-papi/v1/supermercado/#{section}/c?#{attrs}"
      end

      def process_section(section)
        puts section
        ALL_PAGES.map do |page|
          puts page
          process_page(section, page)
        end.flatten
      end

      def process_page(section, page)
        response = get_page(section, page)
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
