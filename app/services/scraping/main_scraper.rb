module Scraping
  class MainScraper
    class << self
      attr_reader :service, :supermarket

      def execute(supermarket_name='', sections: [156])
        initiate(supermarket_name)
        products = service.execute(sections)
        products.each do |object|
          product = create_product(object)
          create_price(object, product)
        end
      end

      private

      def initiate(supermarket_name)
        @service = scrapers_correspondence[supermarket_name.to_sym]
        @supermarket = Supermarket.find_by(name: supermarket_name)
      end

      def scrapers_correspondence
        {
          'Mercadona': Scraping::MercadonaScraper,
          'Carrefour': Scraping::CarrefourScraper
        }
      end

      def create_product(data)
        # TODO: Improve search
        Product.search_by_name(name: data[:name]).first || Product.create(
          name: data[:name],
          quantity: data[:quantity].to_f,
          unit: data[:unit],
          image_url: data[:image_url]
        )
      end

      def create_price(data, product)
        Price.create(
          value: data[:price].to_f,
          product_id: product.id,
          supermarket_id: supermarket.id
        )
      end
    end
  end
end
