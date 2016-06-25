require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Pcntl < AbstractPhp55Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    cellar :any_skip_relocation
    revision 9
    sha256 "08bbc09088c46878d4e634f0a55359a384e5ab2c99ccf1fc6d97ca451d8dc47a" => :el_capitan
    sha256 "530b84feb3ad515791891c3c54e50a650c5b3e5964741b9ce893142d36a3f8fa" => :yosemite
    sha256 "6d2430b30911f7685d416d9335c6fe10144e6e708cbcb54194ed2e3b05ee1ca1" => :mavericks
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







