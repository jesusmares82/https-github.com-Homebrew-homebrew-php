require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Magickwand < AbstractPhp55Extension
  init
  homepage "http://www.magickwand.org"
  url "http://www.magickwand.org/download/php/MagickWandForPHP-1.0.9-2.tar.bz2"
  sha1 "b3c12b5a6f8fb28df7f8c480f2df0eb5baedff71"

  depends_on "pkg-config" => :build
  depends_on "imagemagick"

  def install
    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          "--with-magickwand=#{Formula["imagemagick"].opt_prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/magickwand.so"
    write_config_file if build.with? "config-file"
  end

  test do
    shell_output("php -m").include?("magickwand")
  end
end
