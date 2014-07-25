require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Ioncubeloader < AbstractPhp54Extension
  init
  homepage 'http://www.ioncube.com/loaders.php'
  if Hardware.is_64_bit?
    version '4.6.1'
    url 'http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_dar_x86-64.tar.gz'
    sha1 '1c4879d248b6bc472a8cd215026c02bec98f6f2f'
  else
    version '4.6.1'
    url 'http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_dar_x86.tar.gz'
    sha1 'ad2dac48d5889886fccbebb81d3da8db8d79f717'
  end

  def extension_type; "zend_extension"; end

  def install
    prefix.install "ioncube_loader_dar_5.4.so" => "ioncubeloader.so"
    write_config_file if build.with? "config-file"
  end
end
