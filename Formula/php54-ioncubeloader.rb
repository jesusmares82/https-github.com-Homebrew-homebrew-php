require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php54Ioncubeloader < AbstractPhp54Extension
  init
  homepage 'http://www.ioncube.com/loaders.php'
  if Hardware.is_64_bit?
    version '4.5.3'
    url 'http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_dar_x86-64.tar.gz'
    sha1 '8db9d893b8be25519fc5cbebe76895fdfb510992'
  else
    version '4.5.3'
    url 'http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_dar_x86.tar.gz'
    sha1 'e42a3fa4869449771c245891ed5f2fab2ed44e64'
  end

  def extension_type; "zend_extension"; end

  def install
    prefix.install "ioncube_loader_dar_5.4.so" => "ioncubeloader.so"
    write_config_file unless build.include? "without-config-file"
  end
end
