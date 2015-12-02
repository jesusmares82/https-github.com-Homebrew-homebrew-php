require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Judy < AbstractPhp54Extension
  init
  desc "PHP Extension for libJudy."
  homepage "https://github.com/orieg/php-judy"
  url "https://pecl.php.net/get/Judy-1.0.2.tgz"
  sha256 "6b913af2c44ac84a2224fecf8a81ddcb0c753252cafd153cb0e9d7c33a333118"
  head "https://github.com/orieg/php-judy.git"

  bottle do
    cellar :any
    sha256 "1009b0141d08111192c05cbb320b83bf56eaa966bfb5ea66fd14672b2fa714e7" => :el_capitan
    sha256 "272a5710e98c357f696fe915bbc44e239099a33e284c9c62b95834f09b54c8a7" => :yosemite
    sha256 "27620269eac936360a024ddc47e04c7ae143662c4aac2ddbb41870bd164ba172" => :mavericks
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
