# Decorate Models with connectec carrierwave :portrait
#
module Carrierwave::PortraitDecorator

  def portrait_url(size = :two_one)
    Rails.cache.fetch ['Carrierwave::PortraitDecorator.portrait_url', object, size] do
      size = size.to_s

      if object.portrait_processing
        portrait_placeholder(eval("#{object.portrait.class.name}::#{size.upcase}_DIMENSIONS").join('x'))
      else
        begin
          object.portrait.send(size).url
        rescue NoMethodError
          portrait_placeholder(eval("#{object.portrait.class.name}::#{size.upcase}_DIMENSIONS").join('x'), "undefined :#{size}")
        end
      end
    end
  end

  def portrait_path(size = :two_one)
    Rails.cache.fetch ['Carrierwave::PortraitDecorator.portrait_path', object, size] do
      size = size.to_s

      if object.portrait_processing
        portrait_placeholder(eval("#{object.portrait.class.name}::#{size.upcase}_DIMENSIONS").join('x'))
      else
        begin
          object.portrait.send(size).path
        rescue NoMethodError
          portrait_placeholder(eval("#{object.portrait.class.name}::#{size.upcase}_DIMENSIONS").join('x'), "undefined :#{size}")
        end
      end
    end
  end

  def portrait_placeholder(size = '600x600', text = nil )
    "http://placehold.it/#{size}?text=#{object.class}+Placeholder+#{text}"
  end

end
