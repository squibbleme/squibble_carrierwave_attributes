# Decorate Models with connectec carrierwave :thumbnail
#
module Carrierwave::ThumbnailDecorator

  def thumbnail_url(size = :two_one)
    Rails.cache.fetch ['Carrierwave::ThumbnailDecorator.thumbnail_url', object, size] do
      size = size.to_s

      if object.thumbnail_processing
        thumbnail_placeholder(eval("#{object.thumbnail.class.name}::#{size.upcase}_DIMENSIONS").join('x'))
      else
        begin
          object.thumbnail.send(size).url
        rescue NoMethodError
          thumbnail_placeholder(eval("#{object.thumbnail.class.name}::#{size.upcase}_DIMENSIONS").join('x'), "undefined :#{size}")
        end
      end
    end
  end

  def thumbnail_path(size = :two_one)
    Rails.cache.fetch ['Carrierwave::ThumbnailDecorator.thumbnail_path', object, size] do
      size = size.to_s

      if object.thumbnail_processing
        thumbnail_placeholder(eval("#{object.thumbnail.class.name}::#{size.upcase}_DIMENSIONS").join('x'))
      else
        begin
          object.thumbnail.send(size).path
        rescue NoMethodError
          thumbnail_placeholder(eval("#{object.thumbnail.class.name}::#{size.upcase}_DIMENSIONS").join('x'), "undefined :#{size}")
        end
      end
    end
  end

  def thumbnail_placeholder(size = '600x600', text = nil )
    "http://placehold.it/#{size}?text=#{object.class}+Placeholder+#{text}"
  end

end
