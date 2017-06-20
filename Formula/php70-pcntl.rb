require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pcntl < AbstractPhp70Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  revision 11

  bottle do
    cellar :any_skip_relocation
    sha256 "2da66b8acb36dc77c3c60846c503e2104a33124b5db636d609ceb23fbbf2bf7b" => :sierra
    sha256 "56437323d6a92744575f7ce1b03d20a2c339e2f1450ed3951a88d1a0b5527106" => :el_capitan
    sha256 "9246bcaf226d1b738b596440208d0b4774ba0558b23b7fa87bb985bf1778de1c" => :yosemite
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION

  def install
    Dir.chdir "ext/pcntl"

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking"
    system "make"
    prefix.install "modules/pcntl.so"
    write_config_file if build.with? "config-file"
  end
end
