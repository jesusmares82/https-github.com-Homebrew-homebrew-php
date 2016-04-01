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
    sha256 "a20d51bc98df12efdd421dabf98a1aee60e4af2e35aaef242ee9bd6fb2785b97" => :el_capitan
    sha256 "9b483f06253e7af803a45d2ce62086abf201e6ab88f39330593f0df3cf4ba8db" => :yosemite
    sha256 "291605c8dcb0d99c57130e36586d1c63988eb87efe38de59d77af59e9babdf98" => :mavericks
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




