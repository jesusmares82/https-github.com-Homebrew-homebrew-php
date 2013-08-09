require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php53Ioncubeloader < AbstractPhp53Extension
  init
  homepage 'http://www.ioncube.com/loaders.php'
  version '4.2.2'
  if Hardware.is_64_bit?
    url 'http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_dar_x86-64.tar.gz'
    sha1 '067c47387725db434ab0e7d486a2d6eff6fab37c'
  else
    url 'http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_dar_x86.tar.gz'
    sha1 'a370d6cab86fe32be8df7ac4c2a1e16fa55c3742'
  end

  def extension_type; "zend_extension"; end

  def install
    prefix.install "ioncube_loader_dar_5.3.so" => "ioncubeloader.so"
    write_config_file unless build.include? "without-config-file"
  end
end
