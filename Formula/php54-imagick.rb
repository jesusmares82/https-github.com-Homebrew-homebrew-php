require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Imagick < AbstractPhp54Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://pecl.php.net/package/imagick"
  url "https://pecl.php.net/get/imagick-3.3.0.tgz"
  sha256 "bd69ebadcedda1d87592325b893fa78a5710a0ca7307f8e18c5e593949b1db2d"
  head "https://github.com/mkoppanen/imagick.git"

  bottle do
    sha256 "4295916f3aad15708d14d07592ebd1cced805af3c6e83a05fd5bb0cfcea6566e" => :el_capitan
    sha256 "e4368d84a00e6ad402a23bfb15d6f93643a765c17c108cd41bc76046d63011bd" => :yosemite
    sha256 "6b69b5c2ce39ff3f2cf4107f9a4ba9ed2c47be8a65541edfeb83cfe5497f89f9" => :mavericks
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
