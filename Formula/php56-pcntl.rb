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
    revision 11
    sha256 "604afee24d4be8be742a33f31b92243bd49fb9cf3c26acc1ad41db1e4dd2d396" => :el_capitan
    sha256 "714c970b2e5183f521833a437f45391a53d8607d946de0237e7f84bbe39ce273" => :yosemite
    sha256 "7fa2269cc31f236bb7afab7c3071a739f7bd74f9d7b71a38b9321a9ff309e5c0" => :mavericks
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







