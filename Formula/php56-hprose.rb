require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Hprose < AbstractPhp56Extension
  init
  homepage "http://pecl.php.net/package/hprose"
  url "http://pecl.php.net/get/hprose-1.5.4.tgz"
  sha256 "28733983073d5272b7096129dc23717c42485f905556082352bb0954b64bb996"
  head "https://github.com/hprose/hprose-pecl.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "46f07fccc659149400bdf3d60ac2dfb41361794a9e10dc94c43095a7d4484245" => :yosemite
    sha256 "58cfeda966b53337f18ac8c10f08aa0aaf2d35c2e038ac66eecac7e781dd983b" => :mavericks
    sha256 "185922ebd8d6ee491cba0f4f47ac465d1310053715252b642dfe3486ed0ed66a" => :mountain_lion
  end

  def install
    Dir.chdir "hprose-#{version}" unless build.head?

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig
    system "make"
    prefix.install "modules/hprose.so"
    write_config_file if build.with? "config-file"
  end

  test do
    shell_output("php -m").include?("hprose")
  end
end
