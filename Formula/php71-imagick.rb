require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Imagick < AbstractPhp71Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://pecl.php.net/package/imagick"
  url "https://pecl.php.net/get/imagick-3.4.3RC1.tgz"
  sha256 "50bbc46e78cd6e1ea5d7660be1722258e60b1729483ca14b02da7cf9f5ed3e6a"
  head "https://github.com/mkoppanen/imagick.git"
  revision 1

  bottle do
    sha256 "47265b8692a377673a92682bbc228ba79293cc049f369e68b1648e4a189a911e" => :el_capitan
    sha256 "5ad174739c85057db40ac4bc54f9d50fd76667b8f9254a468b635ce5ec62ec1c" => :yosemite
    sha256 "8d97aea5508a6efc0b667a8ae374dbb1bdab9e1b200e114299d5c75250497939" => :mavericks
  end

  depends_on "pkg-config" => :build
  depends_on "imagemagick"

  def install
    Dir.chdir "imagick-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--with-imagick=#{Formula["imagemagick"].opt_prefix}"
    system "make"
    prefix.install "modules/imagick.so"
    write_config_file if build.with? "config-file"
  end
end
