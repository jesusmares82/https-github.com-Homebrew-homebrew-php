require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Tidy < AbstractPhp56Extension
  init
  homepage "http://php.net/manual/en/book.tidy.php"
  url      PHP_SRC_TARBALL
  sha256   PHP_CHECKSUM[:sha256]
  version  PHP_VERSION

  bottle do
    root_url "https://homebrew.bintray.com/bottles-php"
    sha256 "eceaf9706530034cab44574be55ad1cd00d57f5321bbabfdc01a5e4f0480b4a5" => :yosemite
    sha256 "ae5b48dfa422f79baeb31ff9052a985d92c698155554842afb6a4c14c7b3c40b" => :mavericks
    sha256 "a03c52c64336fe2ab661611c7f48029911e232a05c76c73f4bf03cf27871d5d3" => :mountain_lion
  end

  def install
    Dir.chdir "ext/tidy"

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking",
                          "--with-tidy"
    system "make"
    prefix.install "modules/tidy.so"
    write_config_file if build.with? "config-file"
  end
end
