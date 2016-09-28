require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Amqp < AbstractPhp54Extension
  init
  desc "Communicates with any AMQP 0-9-1 compatible server."
  homepage "https://pecl.php.net/package/amqp"
  url "https://pecl.php.net/get/amqp-1.7.1.tgz"
  sha256 "38a92eaef1aa863404170bcd15605f7f78140eeec1ff5be6af65c5b8081e2599"
  head "https://github.com/pdezwart/php-amqp.git"

  bottle do
    cellar :any
    sha256 "56ccb6e674a54a0388c4a90eff11960acedde513d1ac5a4f8b7eb0d7cf61fda9" => :el_capitan
    sha256 "3e39082bdd7605e08194ea6ff9c4f7414c6763f44453059292556377af76c6de" => :yosemite
    sha256 "7f3a05889f5caba9b7a2294d2c16e93c304f038407f5a8fe16e2b49961b22150" => :mavericks
  end

  depends_on "rabbitmq-c"

  def install
    Dir.chdir "amqp-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/amqp.so"
    write_config_file if build.with? "config-file"
  end
end
