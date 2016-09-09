# Decorate Models with connectec carrierwave :preview
#
module Carrierwave::PreviewDecorator

  def preview_url(size = :two_one)
    Rails.cache.fetch ['Carrierwave::PreviewDecorator.preview_url', object, size] do
      size = size.to_s

      if object.preview_processing
        preview_placeholder(eval("#{object.preview.class.name}::#{size.upcase}_DIMENSIONS").join('x'))
      else
        begin
          object.preview.send(size).url
        rescue NoMethodError
          preview_placeholder(eval("#{object.preview.class.name}::#{size.upcase}_DIMENSIONS").join('x'), "undefined :#{size}")
        end
      end
    end
  end

  def preview_path(size = :two_one)
    Rails.cache.fetch ['Carrierwave::PreviewDecorator.preview_path', object, size] do
      size = size.to_s

      if object.preview_processing
        preview_placeholder(eval("#{object.preview.class.name}::#{size.upcase}_DIMENSIONS").join('x'))
      else
        begin
          object.preview.send(size).path
        rescue NoMethodError
          preview_placeholder(eval("#{object.preview.class.name}::#{size.upcase}_DIMENSIONS").join('x'), "undefined :#{size}")
        end
      end
    end
  end

  def preview_placeholder(size = '600x600', text = nil )
    "http://placehold.it/#{size}?text=#{object.class}+Placeholder+#{text}"
  end
end
