module Scraping
  class MainScraper
    class << self
      attr_reader :service, :supermarket

      def execute(supermarket_name='')
        initiate(supermarket_name)
        data_array = service.execute
        products = create_products(data_array)
        prices_attrs = build_prices(data_array, products)
        create_prices(prices_attrs)
        show_summary
      end

      private

      def initiate(supermarket_name)
        @products_counter = Product.count
        @prices_counter = Price.count
        @time = Time.current
        @service = instantiate_service(supermarket_name.to_sym)
        @supermarket = Supermarket.find_by(name: supermarket_name)
      end

      def instantiate_service(supermarket_name)
        "Scraping::#{supermarket_name}Scraper".constantize
      end

      def create_products(array)
        array.map { |data| create_product(data) }
      end

      def create_product(data)
        # TODO: Improve search
        Product.search_by_name(data[:name]).first || Product.create(
          name: data[:name],
          quantity: data[:quantity].to_f,
          unit: data[:unit],
          image_url: data[:image_url]
        )
      end

      def build_prices(array, products)
        array.zip(products).map do |data, product|
          build_price_attributes(data, product)
        end
      end

      def build_price_attributes(data, product)
        {
          value: data[:price].to_f,
          product_id: product.id,
          supermarket_id: supermarket.id
        }
      end

      def create_prices(array)
        Price.create(array)
      end

      def show_summary
        current_products_count = Product.count
        current_prices_count = Price.count
        puts "*** Importación terminada para #{supermarket.name} (#{Time.current - @time}segs)"
        puts "+ Nuevos productos importados: #{current_products_count - @products_counter}"
        puts "+ Nuevos precios importados: #{current_prices_count - @prices_counter}"
        puts "- Productos Totales: #{current_products_count}"
        puts "- Precios Totales (#{supermarket.name}): #{Price.where(supermarket_id: supermarket.id).count}"
        puts "- Precios Totales: #{current_prices_count}"
      end
    end
  end
end
