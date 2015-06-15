require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Pcntl < AbstractPhp55Extension
  init
  homepage "http://php.net/manual/en/book.pcntl.php"
  url      PHP_SRC_TARBALL
  sha256   PHP_CHECKSUM[:sha256]
  version  PHP_VERSION

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "50fd13d6ad44a3ce9565e3fb06c7f25a4e125a1cc60e7aedb8f9cde785e9f87c" => :yosemite
    sha256 "e6bc8ac0cd07742bf7ce47e6521aa93d583a771ac422c9ed8b7aeff5d7f69bc9" => :mavericks
    sha256 "e34afa3cbbf1fd986c4fbce5b348ec3f9afffc6278849ea2490aa3d9955ea6c3" => :mountain_lion
  end

  def install
    Dir.chdir "ext/pcntl"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking"
    system "make"
    prefix.install "modules/pcntl.so"
    write_config_file if build.with? "config-file"
  end
end
