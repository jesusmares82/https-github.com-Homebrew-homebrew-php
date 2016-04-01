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
    sha256 "17ee9987d4b3d12fc5693c28c06c639533e29fbf795a13f7c68a4c052dad9803" => :el_capitan
    sha256 "e94eaeb9e639724442806ef2595ffb30e7b40c706b5c570a14d7a2c21f7b19c1" => :yosemite
    sha256 "68086270a12684abe30152ff1a870fe7cb87cb352cd6aae666ac8ff36cd753eb" => :mavericks
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




