require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php55Ioncubeloader < AbstractPhp55Extension
  init
  homepage 'http://www.ioncube.com/loaders.php'
  if Hardware.is_64_bit?
    version '4.6.0'
    url 'http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_dar_x86-64.tar.gz'
    sha1 '81f8bf68ca7f5cb0c143e4efc05a0248fc7f0328'
  else
    version '4.6.0'
    url 'http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_dar_x86.tar.gz'
    sha1 'd1bc5498e8a59d775faa22206a23f0276b71fc19'
  end

  def extension_type; "zend_extension"; end

  def install
    prefix.install "ioncube_loader_dar_5.5.so" => "ioncubeloader.so"
    write_config_file if build.with? "config-file"
  end
end
