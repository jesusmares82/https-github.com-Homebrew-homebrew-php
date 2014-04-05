require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php55Ioncubeloader < AbstractPhp55Extension
  init
  homepage 'http://www.ioncube.com/loaders.php'
  if Hardware.is_64_bit?
    version '4.6.0'
    url 'http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_dar_x86-64.tar.gz'
    sha1 '39cdebc7bd77b0fd21bf2a9ed8df5e620a9d6ed5'
  else
    version '4.6.0'
    url 'http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_dar_x86.tar.gz'
    sha1 '5c36e22544c2e39c3c5a4ff8490d2bfb9b6cf4b8'
  end

  def extension_type; "zend_extension"; end

  def install
    prefix.install "ioncube_loader_dar_5.5.so" => "ioncubeloader.so"
    write_config_file unless build.include? "without-config-file"
  end
end
