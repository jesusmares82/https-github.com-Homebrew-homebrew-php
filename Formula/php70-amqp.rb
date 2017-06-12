require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Amqp < AbstractPhp70Extension
  init
  desc "Communicates with any AMQP 0-9-1 compatible server."
  homepage "https://pecl.php.net/package/amqp"
  url "https://pecl.php.net/get/amqp-1.9.1.tgz"
  sha256 "219cdad0ef26d30c9d820be3d0c06a9b35d3d1cb6b7e049948bc952223721119"
  head "https://github.com/pdezwart/php-amqp.git"

  bottle do
    cellar :any
    sha256 "aa5500543d23a4df73fa0c057668711f5b58228523aefb5e644329fa2eefaaaf" => :sierra
    sha256 "1cbe818471c317bc613c61a868e88ea3412413bdb7691983c2f8d3e736ab9934" => :el_capitan
    sha256 "f22e54dd2b7b34e5fba9343f561a96413c94158c5b636d7c94ee70abd6d9c515" => :yosemite
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
