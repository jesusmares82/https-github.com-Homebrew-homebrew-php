require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php54Xmldiff < AbstractPhp54Extension
  init
  homepage 'http://pecl.php.net/package/xmldiff'
  url 'http://pecl.php.net/get/xmldiff-0.9.1.tgz'
  sha1 '93f790182d017c307da3d56d3fb3d1c1a89a83e1'

  def install
    Dir.chdir "xmldiff-#{version}"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/xmldiff.so"
    write_config_file unless build.include? "without-config-file"
  end
end
