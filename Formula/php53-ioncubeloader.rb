require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php53Ioncubeloader < AbstractPhp53Extension
  init
  homepage 'http://www.ioncube.com/loaders.php'
  if Hardware.is_64_bit?
    version '4.5.2'
    url 'http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_dar_x86-64.tar.gz'
    sha1 '2b9b32901eb08f7ffa0702fde4f12104c2dcd12e'
  else
    version '4.5.2'
    url 'http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_dar_x86.tar.gz'
    sha1 'b502134dcde6aa6ec3f652397a00c86a1fd4c744'
  end

  def extension_type; "zend_extension"; end

  def install
    prefix.install "ioncube_loader_dar_5.3.so" => "ioncubeloader.so"
    write_config_file unless build.include? "without-config-file"
  end
end
