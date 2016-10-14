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
    sha256 "1ae1cfe0b389f8ed846848d6dc3018aae69f0a914f01391d4942f8b6eb53d9f3" => :sierra
    sha256 "b42b09a9852647d17c0b8f587a23d74996664e7a262aeb7df5faf9f4b84a795e" => :el_capitan
    sha256 "02093c8025291439b183e050d15ac0a1995dbae81df573319b66700110891ef2" => :yosemite
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
