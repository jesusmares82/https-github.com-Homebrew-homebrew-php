require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Gmagick < AbstractPhp54Extension
  init
  homepage 'http://pecl.php.net/package/gmagick'
  url 'http://pecl.php.net/get/gmagick-1.1.6RC2.tgz'
  sha1 '8779b2d8d1b836f2f69bc93744a905b277ab2690'

  depends_on "graphicsmagick"

  def install
    Dir.chdir "gmagick-#{version}"

    ENV.universal_binary if build.universal?

    args = []
    args << "--prefix=#{prefix}"
    args << phpconfig
    args << "--with-gmagick=#{Formula['graphicsmagick'].opt_prefix}"

    safe_phpize
    system "./configure", *args

    system "make"
    prefix.install "modules/gmagick.so"
    write_config_file if build.with? "config-file"
  end
end
