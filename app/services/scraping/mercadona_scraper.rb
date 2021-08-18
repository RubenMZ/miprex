require 'httparty'

module Scraping
  class MercadonaScraper
    CATEGORIES = [
      'Agua y refrescos',
      'Aperitivos',
      # 'Arroz, legumbres y pasta',
      'Azúcar, caramelos y chocolate',
      # 'Bebé',
      # 'Bodega',
      'Cacao, café e infusiones',
      # 'Carne',
      'Cereales y galletas',
      # 'Charcutería y quesos',
      # 'Congelados',
      # 'Conservas, caldos y cremas',
      # 'Cuidado del cabello',
      # 'Cuidado facial y corporal',
      # 'Fitoterapia y parafarmacia',
      # 'Fruta y verdura',
      # 'Huevos, leche y mantequilla',
      # 'Limpieza y hogar',
      # 'Maquillaje',
      # 'Marisco y pescado',
      # 'Mascotas',
      # 'Panadería y pastelería',
      'Pizzas y platos preparados',
      'Postres y yogures',
      'Zumos'
    ].freeze

    CATEGORIES_BLACKLIST = [
      'Bebé',
      'Bodega',
      'Cuidado del cabello',
      'Cuidado facial y corporal',
      'Fitoterapia y parafarmacia',
      'Marisco y pescado',
      'Limpieza y hogar',
      'Maquillaje',
      'Mascotas',
      'Pizzas y platos preparados'
    ].freeze

    ALL_PAGES = (1..156).freeze

    class << self
      def execute(pages=ALL_PAGES)
        pages.map(&method(:process_page)).compact.flatten
      end

      private

      def process_page(page)
        puts page
        response = get_page page

        return unless allow_category? response['name']

        process_categories response['categories']
      end

      def get_page(page)
        HTTParty.get("https://tienda.mercadona.es/api/categories/#{page}")
      end

      def allow_category?(category)
        CATEGORIES.include?(category) && !CATEGORIES_BLACKLIST.include?(category)
      end

      def process_categories(categories)
        categories.map { |c| process_products(c['products']) }.flatten
      end

      def process_products(products)
        products.map(&method(:build_product_hash))
      end

      def build_product_hash(product)
        price = product['price_instructions']
        {
          name: "#{product['display_name']} #{product['packaging']}",
          price: price['unit_price'],
          quantity: price['unit_size'],
          unit: price['reference_format'],
          image_url: product['thumbnail'],
          product_url: product['share_url']
        }
      end
    end
  end
end
