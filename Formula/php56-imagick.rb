require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Imagick < AbstractPhp56Extension
  init
  desc "Provides a wrapper to the ImageMagick library."
  homepage "https://pecl.php.net/package/imagick"
  url "https://github.com/mkoppanen/imagick/archive/3.4.3.tar.gz"
  sha256 "15be7add24705e2541a07425a0806c1f32364399408f757964b5ddf0a0e9cc2d"
  head "https://github.com/mkoppanen/imagick.git"

  bottle do
    sha256 "4040e9f73f4bbf529a268f1ae917688127877336501af7793037bab4f5267e8b" => :sierra
    sha256 "e9eb83ff5173e94374bbde2716db01406e59823e9c667a4bf5120b902e314886" => :el_capitan
    sha256 "ef9b4390e28dc7b88a5e003f0cb1d26c4a22ae1fcbe2234c7e6b6c23c06693b4" => :yosemite
  end

  depends_on "pkg-config" => :build
  depends_on "imagemagick"

  def install
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
