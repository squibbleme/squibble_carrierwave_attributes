# Decorate Models with connectec carrierwave :image
#
module Carrierwave::ImageDecorator

  def image_url(size = :two_one)
    Rails.cache.fetch ['Carrierwave::ImageDecorator.image_url', object, size] do
      size = size.to_s

      if object.image_processing
        image_placeholder(eval("#{object.image.class.name}::#{size.upcase}_DIMENSIONS").join('x'))
      else
        begin
          object.image.send(size).url
        rescue NoMethodError
          image_placeholder(eval("#{object.image.class.name}::#{size.upcase}_DIMENSIONS").join('x'), "undefined :#{size}")
        end
      end
    end
  end

  def image_path(size = :two_one)
    Rails.cache.fetch ['Carrierwave::ImageDecorator.image_path', object, size] do
      size = size.to_s

      if object.image_processing
        image_placeholder(eval("#{object.image.class.name}::#{size.upcase}_DIMENSIONS").join('x'))
      else
        begin
          object.image.send(size).path
        rescue NoMethodError
          image_placeholder(eval("#{object.image.class.name}::#{size.upcase}_DIMENSIONS").join('x'), "undefined :#{size}")
        end
      end
    end
  end

  def image_placeholder(size = '600x600', text = nil )
    "http://placehold.it/#{size}?text=#{object.class}+Placeholder+#{text}"
  end
end
