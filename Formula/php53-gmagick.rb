require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php53Gmagick < AbstractPhp53Extension
  init
  homepage 'http://pecl.php.net/package/gmagick'
  url 'http://pecl.php.net/get/gmagick-1.1.6RC2.tgz'
  sha1 '8779b2d8d1b836f2f69bc93744a905b277ab2690'

  depends_on "graphicsmagick"

  def install
    Dir.chdir "gmagick-#{version}"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/gmagick.so"
    write_config_file unless build.include? "without-config-file"
  end
end
