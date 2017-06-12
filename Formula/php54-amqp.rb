require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Amqp < AbstractPhp54Extension
  init
  desc "Communicates with any AMQP 0-9-1 compatible server."
  homepage "https://pecl.php.net/package/amqp"
  url "https://pecl.php.net/get/amqp-1.9.1.tgz"
  sha256 "219cdad0ef26d30c9d820be3d0c06a9b35d3d1cb6b7e049948bc952223721119"
  head "https://github.com/pdezwart/php-amqp.git"

  bottle do
    cellar :any
    sha256 "02c7e4e8ef9697ce765484e3417de2f44d8b2b01ff82bc69c47b30fc880ad6b1" => :sierra
    sha256 "642526b78e5164f3e26aad328a4cc8c38e10c719617cb55a9a0c2240cde4554e" => :el_capitan
    sha256 "e9831ff752bb99da11f5726ed4163c6a5b7e008c728fb0c27071c075b0df85b0" => :yosemite
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
