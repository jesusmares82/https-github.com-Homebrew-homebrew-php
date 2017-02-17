require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php71Pcntl < AbstractPhp71Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  revision 9

  bottle do
    cellar :any_skip_relocation
    sha256 "82e7291968a1a00c74a1d1b2ec972bbeb02b6b88baf0c259f170277f33da580e" => :sierra
    sha256 "9e659d9e7162f8aea21b80fc20c2b6ee2ea3990c92a1a504fb92189d63b29bfa" => :el_capitan
    sha256 "868bcbaf492d206ba3ee9d5c0b469e9941b548b4ff9ce64c9fc1ed6273ec7e10" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

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
