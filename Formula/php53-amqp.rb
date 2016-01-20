require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php53Amqp < AbstractPhp53Extension
  init
  desc "Communicates with any AMQP 0-9-1 compatible server."
  homepage "https://pecl.php.net/package/amqp"
  url "https://pecl.php.net/get/amqp-1.6.1.tgz"
  sha256 "cc24ddf7d4140fa68c127af98a59b72f8b51f73a663816e3e82d676566701d62"
  head "https://github.com/pdezwart/php-amqp.git"

  bottle do
    cellar :any
    sha256 "123560730c1029d7e90966c72d1a3de22594e91b9bd454df60161f3d43cc4382" => :el_capitan
    sha256 "f65a0926321b6d0b05acc9966d8578bc04c52a670ff76cb58e7fc6a27c66e6c4" => :yosemite
    sha256 "b170a25bbb7e8782bf4851e98a0b96ff75378a48f694b4a519f9ed1bb226b193" => :mavericks
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
