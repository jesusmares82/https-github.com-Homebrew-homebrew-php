require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php55Ioncubeloader < AbstractPhp55Extension
  init
  homepage 'http://www.ioncube.com/loaders.php'
  version '4.5.0'
  url 'http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_dar_x86-64.tar.gz'
  sha1 '62b2b2f0328cbee95e71fae0f03ea87f611a6a3c'
  depends_on :arch => :x86_64

  def extension_type; "zend_extension"; end

  def install
    prefix.install "ioncube_loader_dar_5.5.so" => "ioncubeloader.so"
    write_config_file unless build.include? "without-config-file"
  end
end
