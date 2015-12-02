require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php56Pcntl < AbstractPhp56Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  bottle do
    cellar :any_skip_relocation
    revision 5
    sha256 "247da1525752d7d326a3b50a908266919f1b0d289f3519cec60d04fa90d8ec56" => :el_capitan
    sha256 "bfc7a9a1e19e1a50417f93e5bf00ac7b4bd6e303bd411a74e6762ebebb948af5" => :yosemite
    sha256 "497386004d43c9e839981e49d4a156f94b4510de1175783b89834be2488c3bf1" => :mavericks
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
