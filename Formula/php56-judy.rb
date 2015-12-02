require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Judy < AbstractPhp56Extension
  init
  desc "PHP Extension for libJudy."
  homepage "https://github.com/orieg/php-judy"
  url "https://pecl.php.net/get/Judy-1.0.2.tgz"
  sha256 "6b913af2c44ac84a2224fecf8a81ddcb0c753252cafd153cb0e9d7c33a333118"
  head "https://github.com/orieg/php-judy.git"

  bottle do
    cellar :any
    revision 1
    sha256 "2e72a26ed1c7a623c1e5e994a7bb45f40008e2457745d1eb767528d57cc84fb1" => :el_capitan
    sha256 "4357dee8e2d458a35ccd8057632f6bc86b1ca8ceb5a69549c51e7ae11ead327d" => :yosemite
    sha256 "fd22bbd096a845233401d381fa867819e150ca813b64dbc7e5bfc3b7f1f7081e" => :mavericks
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
