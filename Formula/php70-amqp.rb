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
    sha256 "f85ca29da8ead3c7c6ae0381f99082c6de30fcd8e9d182cdc77efe1558562ce0" => :sierra
    sha256 "8bb45ffe451026b30277a5c6afbda76de2792460c5d600467ce3e58ea4fe0c4b" => :el_capitan
    sha256 "bc9118cea7179bacc61f1fe08f8bee2d7ab6f99b292d13cdfd17e37e8f865076" => :yosemite
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
