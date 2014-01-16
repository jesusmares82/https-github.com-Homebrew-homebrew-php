require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php55Ioncubeloader < AbstractPhp55Extension
  init
  homepage 'http://www.ioncube.com/loaders.php'
  version '4.5.2'
  url 'http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_dar_x86-64.tar.gz'
  sha1 '2b9b32901eb08f7ffa0702fde4f12104c2dcd12e'
  depends_on :arch => :x86_64

  def extension_type; "zend_extension"; end

  def install
    prefix.install "ioncube_loader_dar_5.5.so" => "ioncubeloader.so"
    write_config_file unless build.include? "without-config-file"
  end
end
