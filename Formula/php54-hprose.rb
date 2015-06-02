require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Hprose < AbstractPhp54Extension
  init
  homepage "http://pecl.php.net/package/hprose"
  url "http://pecl.php.net/get/hprose-1.5.4.tgz"
  sha256 "28733983073d5272b7096129dc23717c42485f905556082352bb0954b64bb996"
  head "https://github.com/hprose/hprose-pecl.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "5c68c512d6a3c3562ab9208d7c52d121e1e05f51c640e23d0e5e2e478ac00d14" => :yosemite
    sha256 "bbc66e713fe54c643760192ddd5b0ee84dbb0a5790d588ae3dc6305067776933" => :mavericks
    sha256 "b0c926da285b8e91b0f9aec59beb1274e14f352eacf0c5bd3119e1a8880fd7c0" => :mountain_lion
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
