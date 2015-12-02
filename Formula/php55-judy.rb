require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Judy < AbstractPhp55Extension
  init
  desc "PHP Extension for libJudy."
  homepage "https://github.com/orieg/php-judy"
  url "https://pecl.php.net/get/Judy-1.0.2.tgz"
  sha256 "6b913af2c44ac84a2224fecf8a81ddcb0c753252cafd153cb0e9d7c33a333118"
  head "https://github.com/orieg/php-judy.git"

  bottle do
    cellar :any
    revision 1
    sha256 "f0cf74b9133932fa7b568fcb62debf0f7a9807cb42aa92cd3114d9b3855adc8d" => :el_capitan
    sha256 "f45e9d558b8d157773d1e91ee966c4ce8b64374d1a0f060a9ffe459da4f78c54" => :yosemite
    sha256 "127d737af25b22f7674df6c2904d44272e1d0259f7c3e3c4d689c49defdefa4f" => :mavericks
  end

  depends_on "judy"

  def install
    Dir.chdir "judy-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/judy.so"
    write_config_file if build.with? "config-file"
  end
end
