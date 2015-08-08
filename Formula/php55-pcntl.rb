require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php55Pcntl < AbstractPhp55Extension
  init
  homepage "http://php.net/manual/en/book.pcntl.php"
  url      PHP_SRC_TARBALL
  sha256   PHP_CHECKSUM[:sha256]
  version  PHP_VERSION

  bottle do
    cellar :any
    sha256 "1d34645102c06e050ed226c267493997e2e97dbd32bf88d3108e2baf531bd40f" => :yosemite
    sha256 "cdd1987c91f59fd491a9d355473872b6c8b1b7aa4f04dfc9a4884d9e759ec637" => :mavericks
    sha256 "b84277ffcf16147fc40027cc38af8523fa6f176b6140cea557c916665ad42793" => :mountain_lion
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

