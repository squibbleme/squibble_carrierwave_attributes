# Decorate Models with connectec carrierwave :file
#
module Carrierwave::FileDecorator

  def file_url(size = :two_one)
    Rails.cache.fetch ['Carrierwave::FileDecorator.file_url', object, size] do
      size = size.to_s

      if object.file_processing
        file_placeholder(eval("#{object.file.class.name}::#{size.upcase}_DIMENSIONS").join('x'))
      else
        begin
          object.file.send(size).url
        rescue NoMethodError
          file_placeholder(eval("#{object.file.class.name}::#{size.upcase}_DIMENSIONS").join('x'), "undefined :#{size}")
        end
      end
    end
  end

  def file_path(size = :two_one)
    Rails.cache.fetch ['Carrierwave::FileDecorator.file_path', object, size] do
      size = size.to_s

      if object.file_processing
        file_placeholder(eval("#{object.file.class.name}::#{size.upcase}_DIMENSIONS").join('x'))
      else
        begin
          object.file.send(size).path
        rescue NoMethodError
          file_placeholder(eval("#{object.file.class.name}::#{size.upcase}_DIMENSIONS").join('x'), "undefined :#{size}")
        end
      end
    end
  end

  def file_placeholder(size = '600x600', text = nil )
    "http://placehold.it/#{size}?text=#{object.class}+Placeholder+#{text}"
  end
end
