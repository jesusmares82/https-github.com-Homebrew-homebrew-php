require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Pcntl < AbstractPhp70Extension
  init
  desc "Process Control support"
  homepage "http://php.net/manual/en/book.pcntl.php"
  bottle do
    cellar :any_skip_relocation
    sha256 "212efaa6d17b7ee983745ced9358b090011113d6d1baa6d2cb6589bf57963c61" => :el_capitan
    sha256 "78590f5703193c2a0170c107daa8faa3d7f438393c39dea49813e4af1f6d0cb7" => :yosemite
    sha256 "4a547d9b948a4061f07bc1b26e7ead4ccc0fd640ff36b2aa40b2e79a3884cb6c" => :mavericks
  end

  url PHP_SRC_TARBALL
  sha256 PHP_CHECKSUM[:sha256]
  version PHP_VERSION
  revision 2

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
