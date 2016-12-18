require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Imagick < AbstractPhp71Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://pecl.php.net/package/imagick"
  url "https://pecl.php.net/get/imagick-3.4.3RC1.tgz"
  sha256 "50bbc46e78cd6e1ea5d7660be1722258e60b1729483ca14b02da7cf9f5ed3e6a"
  head "https://github.com/mkoppanen/imagick.git"
  revision 3

  bottle do
    sha256 "3fb080b4b7112c7f56fd27116c4734dd6d06e75fe918b69c938da5188a21b65b" => :sierra
    sha256 "d45d7c06f027973cfffb61b44c261fec31164492777b5657e46ef00183baefa2" => :el_capitan
    sha256 "da943b4581d0536c179735dc56e56ea1952e3434becea0aca0c9a6610ba10353" => :yosemite
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
