require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Imagick < AbstractPhp53Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://pecl.php.net/package/imagick"
  url "https://pecl.php.net/get/imagick-3.3.0.tgz"
  sha256 "bd69ebadcedda1d87592325b893fa78a5710a0ca7307f8e18c5e593949b1db2d"
  revision 2

  bottle do
    sha256 "8c760677d18f6781d672b16cad02c7c6bd2c7678d9785de9878509e282fb2c55" => :el_capitan
    sha256 "3ecbc3bb8b64a775028bb69e027e1e5b15a7c87d5829e56e0bf555276e96e430" => :yosemite
    sha256 "89d84ff6a20eabe1c93a12e313ed0894ff7f534a186e44d9138929c7740af409" => :mavericks
  end

  depends_on "pkg-config" => :build
  depends_on "imagemagick"

  def install
    Dir.chdir "imagick-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          "--with-imagick=#{Formula["imagemagick"].opt_prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/imagick.so"
    write_config_file if build.with? "config-file"
  end
end
