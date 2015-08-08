require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php54Pcntl < AbstractPhp54Extension
  init
  homepage "http://php.net/manual/en/book.pcntl.php"
  url      PHP_SRC_TARBALL
  sha256   PHP_CHECKSUM[:sha256]
  version  PHP_VERSION

  bottle do
    cellar :any
    sha256 "778f3cdeb7be631f15086e4ddca20d69e938993ac4aea7f2c6e12ecb83930dff" => :yosemite
    sha256 "a974e032c620446cbe6d90131407b541710849b93de18a5bebe669428171354d" => :mavericks
    sha256 "008756ff30e4eed035f31941ad6b23fdb5c1b9c33a32954e56676515318c9c1e" => :mountain_lion
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

