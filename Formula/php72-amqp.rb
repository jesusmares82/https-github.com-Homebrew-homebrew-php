require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Amqp < AbstractPhp72Extension
  init
  desc "Communicates with any AMQP 0-9-1 compatible server."
  homepage "https://pecl.php.net/package/amqp"
  url "https://pecl.php.net/get/amqp-1.7.1.tgz"
  sha256 "38a92eaef1aa863404170bcd15605f7f78140eeec1ff5be6af65c5b8081e2599"
  head "https://github.com/pdezwart/php-amqp.git"
  revision 1

  bottle do
    cellar :any
    sha256 "ca3b58b802b7dfa67c45aba264d5a974a90428446118c2ab907ceb6148215960" => :sierra
    sha256 "e7425563575c69911f6c3854ac880f2e4e3a21b2cb14f81365e8b1ef33d823d2" => :el_capitan
    sha256 "4131488e7c36966122514ab650ced3f59da53c0fb316db92df26bbbab1a73f6e" => :yosemite
  end

  depends_on "rabbitmq-c"

  def install
    Dir.chdir "amqp-#{version}" unless build.head?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/amqp.so"
    write_config_file if build.with? "config-file"
  end
end
