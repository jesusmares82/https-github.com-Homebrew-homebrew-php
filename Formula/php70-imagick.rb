require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Imagick < AbstractPhp70Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://pecl.php.net/package/imagick"
  url "https://pecl.php.net/get/imagick-3.4.2.tgz"
  sha256 "8e16b7bc6cf6567f4b4c4ac7294cbf650fe050a848c6a7ba6e2bee02097ab4a8"
  head "https://github.com/mkoppanen/imagick.git"
  revision 3

  bottle do
    sha256 "d712a1580e51dd831613bf9e974d8bf7b856a616dac1912df609294c4352fe54" => :el_capitan
    sha256 "d65f680b14076985f281a8860bdaf0a31117bfcd89b17b1b3f4cc4d86ab9a0c8" => :yosemite
    sha256 "e409add91890d9e145023a2093efc5db8a6864ff7a6a189741dbf9f7b0ce8c4e" => :mavericks
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
