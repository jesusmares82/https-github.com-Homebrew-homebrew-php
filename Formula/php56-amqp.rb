require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Amqp < AbstractPhp56Extension
  init
  desc "Communicates with any AMQP 0-9-1 compatible server."
  homepage "https://pecl.php.net/package/amqp"
  url "https://pecl.php.net/get/amqp-1.9.1.tgz"
  sha256 "219cdad0ef26d30c9d820be3d0c06a9b35d3d1cb6b7e049948bc952223721119"
  head "https://github.com/pdezwart/php-amqp.git"

  bottle do
    cellar :any
    sha256 "ba016414d157b9ee53a331a8ca902edeaf5c8a420124477ad55a4ab189ada499" => :sierra
    sha256 "439ab46b5326bc6fef84776c53a073b342f0cef58a16d9886a5fa4700df59439" => :el_capitan
    sha256 "da60fcba59d260641ec235a5d83d30aee2e7161b8c2e3ce8c55ab8bcac10ee7a" => :yosemite
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
